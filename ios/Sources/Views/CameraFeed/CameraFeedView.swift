//
//  CameraFeedView.swift
//  react-native-eid-sdk
//
//  Created by Phương Đăng Trần Thành on 3/5/24.
//

import UIKit
import CoreMedia
import AVFoundation
import verifysdk
import React

class CameraFeedView: UIView {
    @objc var onReturnCitizenData: RCTDirectEventBlock?
    private var session = AVCaptureSession()
    private var previewLayer: AVCaptureVideoPreviewLayer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    override func reactSetFrame(_ frame: CGRect) {
        super.reactSetFrame(frame)
        self.previewLayer.frame = self.layer.bounds
        self.previewLayer.masksToBounds = true
        self.clipsToBounds = true
        setNeedsLayout()
    }
    
    private func setupUI(){
        AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { result in
            DispatchQueue.main.async {
                self.previewLayer = AVCaptureVideoPreviewLayer(session: self.session)
                self.previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
                self.layer.addSublayer(self.previewLayer)
                
                self.setupCaptureSessionOutput()
                self.setupCaptureSessionInput()
            }
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
    
    private func startSession(){
        DISPATCH_ASYNC_BG {
            self.session.startRunning()
        }
    }
    
    private func stopSession(){
        DISPATCH_ASYNC_BG {
            self.session.stopRunning()
        }
    }
    
    private func readDataFromNfc(withKey mrzKey: String){
        EIDFACADE.readChipNfc(mrzKey: mrzKey, completionHandler: { nfcInfo in
            if(self.onReturnCitizenData != nil){
                self.onReturnCitizenData!(nfcInfo.toJSON())
                self.session.startRunning()
            }
        }, errorHandler: { error in
            print("iOS Read NFC error: \(error.localizedDescription)")
            self.session.startRunning()
        })
    }
    
    private func processMRZBuffer(_ buffer: CMSampleBuffer){
        MRZUtils.processMRZ(sampleBuffer: buffer, timeRequired: 0, callback: { info in
            if(info != nil){
                if self.session.isRunning == true {
                    self.session.stopRunning()
                }
                
                DispatchQueue.main.async {
                    let mrzKey = EIDFACADE.generateMRZKey(eidNumber: info!.documentNumber, dateOfBirth: info!.dateOfBirth, dateOfExpiry: info!.dateOfExpiry)
                    self.readDataFromNfc(withKey: mrzKey)
                }
            }
        })
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
