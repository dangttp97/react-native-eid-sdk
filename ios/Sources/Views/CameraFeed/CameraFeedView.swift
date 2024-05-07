//
//  CameraFeedView.swift
//  react-native-eid-sdk
//
//  Created by Phương Đăng Trần Thành on 3/5/24.
//

import UIKit
import CoreMedia
import AVFoundation
import xverifysdk

protocol CameraFeedViewDelegate{
    func cameraDidReturnMRZData(info: MRZInfo?, key: String)
}

class CameraFeedView: UIView {
    private var session = AVCaptureSession()
    private let cameraFrame = UIView()
    private var previewLayer: AVCaptureVideoPreviewLayer!
    
    var delegate: CameraFeedViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI(){
        AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { result in
            DispatchQueue.main.async {
                self.previewLayer = AVCaptureVideoPreviewLayer(session: self.session)
                self.previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
                self.previewLayer.frame = self.frame
                self.previewLayer.cornerRadius = 10
                self.layer.addSublayer(self.previewLayer)
                
                self.setupCaptureSessionOutput()
                self.setupCaptureSessionInput()
                self.setupLayer()
            }
        })
    }
    
    private func setupLayer(){
        self.layer.cornerRadius = 10.0
        cameraFrame.layer.cornerRadius = 10.0
        cameraFrame.removeFromSuperview()
        self.addSubview(cameraFrame)
        cameraFrame.frame = self.frame
    }
    
    private func setupCaptureSessionInput(){
        let discoverySession = AVCaptureDevice.DiscoverySession(
            deviceTypes: [.builtInWideAngleCamera],
            mediaType: .video,
            position: .back
        )
        let captureDevice = discoverySession.devices.first { $0.position == .back }
        
        guard let device = captureDevice else {
            print("Failed to get capture device for camera position: back")
            return
        }
        do {
            session.beginConfiguration()
            let currentInputs = session.inputs
            for input in currentInputs {
                session.removeInput(input)
            }
            
            let input = try AVCaptureDeviceInput(device: device)
            guard session.canAddInput(input) else {
                print("Failed to add capture session input.")
                return
            }
            session.addInput(input)
            session.commitConfiguration()
        } catch {
            print("Failed to create capture device input: \(error.localizedDescription)")
        }
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        startSession()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cameraFrame.frame = self.frame
    }
    
    private func startSession(){
        session.startRunning()
    }
    
    private func stopSession(){
        session.stopRunning()
    }
    
    private func processMRZBuffer(_ buffer: CMSampleBuffer){
        MRZUtils.processMRZ(sampleBuffer: buffer, timeRequired: 0, callback: { info in
            let mrzKey = EIDFACADE.generateMRZKey(eidNumber: info!.documentNumber, dateOfBirth: info!.dateOfBirth, dateOfExpiry: info!.dateOfExpiry)
            self.delegate?.cameraDidReturnMRZData(info: info, key: mrzKey)
        })
    }
    
    private func setupCaptureSessionOutput(){
        session.beginConfiguration()
        session.sessionPreset = .high
        let output = AVCaptureVideoDataOutput()
        output.videoSettings = [(kCVPixelBufferPixelFormatTypeKey as String): kCVPixelFormatType_32BGRA]
        output.alwaysDiscardsLateVideoFrames = true
        let outputQueue = DispatchQueue(label: "vn.com.finviet.VideoDataOutputQueue")
        output.setSampleBufferDelegate(self, queue: outputQueue)
        guard session.canAddOutput(output) else {
            print("Failed to add capture session output.")
            return
        }
        session.addOutput(output)
        session.commitConfiguration()
    }
}

extension CameraFeedView: AVCaptureVideoDataOutputSampleBufferDelegate{
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard CMSampleBufferGetImageBuffer(sampleBuffer) != nil else {
            print("Failed to get image buffer from sample buffer.")
            return
        }
        processMRZBuffer(sampleBuffer)
    }
}
