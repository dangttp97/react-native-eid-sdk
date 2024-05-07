import xverifysdk
import AVFoundation
import UIKit
import React
import Alamofire
import CoreMedia

protocol CameraFeedDelegate{
    func cameraFeedDidOutput(sampleBuffer: CMSampleBuffer)
}

//@objc(CameraFeedView)
//class CameraFeedView: RCTViewManager{
//    private var cameraView: UIView = UIView()
//    private var borderedCameraView = UIView()
//    private lazy var previewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
//    
//    private var captureSession = AVCaptureSession()
//    
//    @objc public func startSession(){
//        captureSession.startRunning()
//    }
//    
//    @objc public func stopSession(){
//        captureSession.stopRunning()
//    }
//    
//    private func setupCaptureSessionOutput(){
//        captureSession.beginConfiguration()
//        captureSession.sessionPreset = .high
//        let output = AVCaptureVideoDataOutput()
//        output.videoSettings = [(kCVPixelBufferPixelFormatTypeKey as String): kCVPixelFormatType_32BGRA]
//        output.alwaysDiscardsLateVideoFrames = true
//        let outputQueue = DispatchQueue(label: "vn.jth.xverifydemoapp.VideoDataOutputQueue")
//        output.setSampleBufferDelegate(self, queue: outputQueue)
//        guard captureSession.canAddOutput(output) else {
//            print("Failed to add capture session output.")
//            return
//        }
//        captureSession.addOutput(output)
//        captureSession.commitConfiguration()
//    }
//    
//    private func captureDevice(forPosition position: AVCaptureDevice.Position) -> AVCaptureDevice? {
//        if #available(iOS 10.0, *) {
//            let discoverySession = AVCaptureDevice.DiscoverySession(
//                deviceTypes: [.builtInWideAngleCamera],
//                mediaType: .video,
//                position: .unspecified
//            )
//            return discoverySession.devices.first { $0.position == position }
//        }
//        return nil
//    }
//    
//    private func setupCaptureSessionInput(){
//        guard let device = captureDevice(forPosition: .back) else {
//            print("Failed to get capture device for camera position: back")
//            return
//        }
//        do {
//            captureSession.beginConfiguration()
//            let currentInputs = captureSession.inputs
//            for input in currentInputs {
//                captureSession.removeInput(input)
//            }
//            
//            let input = try AVCaptureDeviceInput(device: device)
//            guard captureSession.canAddInput(input) else {
//                print("Failed to add capture session input.")
//                return
//            }
//            captureSession.addInput(input)
//            captureSession.commitConfiguration()
//        } catch {
//            print("Failed to create capture device input: \(error.localizedDescription)")
//        }
//    }
//    
//    private func setupSublayer(){
//        cameraView.layer.cornerRadius = 10.0
//        borderedCameraView.layer.cornerRadius = 10.0
//        borderedCameraView.removeFromSuperview()
//        cameraView.addSubview(borderedCameraView)
//        borderedCameraView.frame = cameraView.frame
//    }
//    
//    override func view() -> UIView! {
//        AVCaptureDevice.requestAccess(for: .video, completionHandler: {success in
//            if(success){
//                self.previewLayer.cornerRadius = 10
//                self.previewLayer.videoGravity = .resizeAspectFill
//                self.previewLayer.frame = self.cameraView.frame
//                self.cameraView.layer.addSublayer(self.previewLayer)
//                self.setupCaptureSessionOutput()
//                self.setupCaptureSessionInput()
//            }
//            self.setupSublayer()
//        })
//        return cameraView
//    }
//}

//@objc class ScanMRZViewController: UIViewController{
//    private var cameraView
//}

extension String{
    var base64: String? {
        get{
            guard let data = self.data(using: String.Encoding.utf8) else {
                return nil
            }
            return data.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
        }
    }
}

//extension CameraFeedView: AVCaptureVideoDataOutputSampleBufferDelegate{
//    private func nfcEidRead(eid: NfcEidModel?) {
//        let request = CecaRequestModel()
//        let info = CecaInfoRequestModel()
//        info.version = "1.0.0"
//        info.senderId = "CECA001"
//        info.receiverId = "GTELEKYC"
//        info.messageType = 101
//        info.sendDate = Date().millisecondsSince1970
//        info.messageId = CecaUtils.generateMessageId(senderId: "CECA001")
//        request.info = info
//        
//        let content = CecaContentRequestModel()
//        content.transactionId = UUID().uuidString.replacingOccurrences(of: "-", with: "").uppercased()
//        let contentData = CecaDataRequestModel()
//        contentData.code = "GTELICT"
//        contentData.cecaTransactionCode = UUID().uuidString.replacingOccurrences(of: "-", with: "").uppercased()
//        contentData.dsCert = eid?.documentSigningCertificate?.certToPEM().base64 ?? ""
//        contentData.idCardNumber = eid?.dg13?.eidNumber ?? ""
//        contentData.deviceType = "mobile"
//        if let province = eid?.dg13?.placeOfResidence {
//            contentData.province = CecaUtils.getProvince(address: province) ?? ""
//        }
//        content.data = contentData
//        request.content = content
//        
//        request.signature = CecaUtils.generateSignature(secretKey: "2540E77E5DF54A6493C5D8F2EF585C8E", request: request)
//        
//        print("CECA verify request \(request)")
//        
//        if let eidFaceImage = eid?.eidImage {
//            let fileName = "ID_\(Date().millisecondsSince1970).jpg"
//            let directoryPath =  try! FileManager().url(for: .picturesDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
//            let urlString: NSURL = directoryPath.appendingPathComponent(fileName) as NSURL
//            print("Image path : \(urlString)")
//            if !FileManager.default.fileExists(atPath: urlString.path!) {
//                do {
//                    try eidFaceImage.jpegData(compressionQuality: 1.0)!.write(to: urlString as URL)
//                    print ("Image Added Successfully")
//                } catch {
//                    print ("Image Not added")
//                }
//            }
//        }
//    }
    
//    @objc func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
//        guard CMSampleBufferGetImageBuffer(sampleBuffer) != nil else {
//            print("Failed to get image buffer from sample buffer.")
//            return
//        }
//        
//        MRZUtils.processMRZ(sampleBuffer: sampleBuffer, timeRequired: 0, callback: { info in
//            print("Data \(info)")
//            DispatchQueue.main.async {
//                let mrzKey = EidFacade.shared.generateMRZKey(eidNumber: info!.documentNumber, dateOfBirth: info!.dateOfBirth, dateOfExpiry: info!.dateOfExpiry)
//                xverifysdk.EidFacade.shared.readChipNfc(mrzKey: mrzKey, completionHandler: { model in
////                    self.nfcEidRead(eid: model)
//                    print("Model \(model)")
//                }, errorHandler: { error in
//                })
//            }
//        })
//    }
//}

@objc(EidSdkModule)
class EidSdkModule: NSObject {
    @objc func getPersonalInfo(imageUrlStr: String, resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock){
        
    }
}
