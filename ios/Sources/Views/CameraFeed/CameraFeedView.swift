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

extension MRZInfo: Encodable{
    enum CodingKeys: String, CodingKey{
        case documentType
        case documentCode
        case issuingState
        case nationality
        case documentNumber
        case dateOfBirth
        case gender
        case dateOfExpiry
    }
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(dateOfBirth, forKey: .dateOfBirth)
        try container.encode(dateOfExpiry, forKey: .dateOfExpiry)
        try container.encode(documentCode, forKey: .documentCode)
        try container.encode(documentType.rawValue, forKey: .documentType)
        try container.encode(documentNumber, forKey: .documentNumber)
        try container.encode(gender, forKey: .gender)
        try container.encode(issuingState, forKey: .issuingState)
        try container.encode(nationality, forKey: .nationality)
    }
}

class CameraFeedView: UIView {
    @objc var onReturnMRZData: RCTDirectEventBlock?
    private var session = AVCaptureSession()
    private var previewLayer: AVCaptureVideoPreviewLayer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
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
    
    private func processMRZBuffer(_ buffer: CMSampleBuffer){
        MRZUtils.processMRZ(sampleBuffer: buffer, timeRequired: 0, callback: { info in
            if(info != nil){
                let mrzKey = EIDFACADE.generateMRZKey(eidNumber: info!.documentNumber, dateOfBirth: info!.dateOfBirth, dateOfExpiry: info!.dateOfExpiry)
                
                do{
                    let jsonEncoder = JSONEncoder()
                    let data = try jsonEncoder.encode(info)
                    let jsonObj = try JSONSerialization.jsonObject(with: data) as! [String : Any]
                    
                    if(self.onReturnMRZData != nil){
                        print(jsonObj)
                        self.onReturnMRZData!(jsonObj)
                    }
                }
                catch(let error){
                    print("React Native: \(error.localizedDescription)")
                }
            }
        })
    }
    
    
}

extension CameraFeedView:AVCaptureVideoDataOutputSampleBufferDelegate{
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard CMSampleBufferGetImageBuffer(sampleBuffer) != nil else {
            print("Failed to get image buffer from sample buffer.")
            return
        }
        processMRZBuffer(sampleBuffer)
    }
}
