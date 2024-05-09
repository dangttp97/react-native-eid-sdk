
import AVFoundation
import CoreVideo
import UIKit
import Lottie

class MRZScannerViewController: NavigationBarViewController {
    
    @IBOutlet weak private var cameraView: UIView!
    @IBOutlet weak var cameraFrameImage: UIView!
    @IBOutlet weak var animationScanNfc: LottieAnimationView!
    @IBOutlet weak var mrzInstructionLabel: UILabel!
    @IBOutlet weak var nfcInstructionLabel: UILabel!
    
    @IBOutlet weak var importImageButton: UIButton!
    @IBOutlet weak var mrzScanButton: UIButton!
    @IBOutlet weak var nfcScanButton: UIButton!
    
    private var captureSession = AVCaptureSession()
    private var previewLayer: AVCaptureVideoPreviewLayer!
    
    public var isNFCOnly: Bool = false
    
    // --------------------------------------
    // MARK: Life Cycle
    // --------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationItem.title = LOCALIZED("step_1_scan_mrz")
        setLogoImage(UIImage(named: "ic_header_logo"))
        animationScanNfc.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startSession()
        resetMRZSession()
        if isNFCOnly { startNfcScan() }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        stopSession()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        cameraFrameImage.frame = cameraView.frame
    }
    
    // --------------------------------------
    // MARK: Overried
    // --------------------------------------
    override func setupUI() {
        AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { success in
            if success == false {
                DISPATCH_ASYNC_MAIN {
                    self.setupLayerView()
                }
                return
            }
            DISPATCH_ASYNC_MAIN {
                
                self.previewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
                self.previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
                self.previewLayer.frame = self.cameraView.frame
                self.previewLayer.cornerRadius = 10
                self.view.layer.addSublayer(self.previewLayer)
                
                if self.isNFCOnly {
                    self.previewLayer.isHidden = true
                }
                
                self.setUpCaptureSessionOutput()
                self.setUpCaptureSessionInput()
                self.setupLayerView()
            }
        })
        
        mrzInstructionLabel.text = LOCALIZED("scan_mrz")
        nfcInstructionLabel.text = LOCALIZED("scan_nfc")
        
        mrzScanButton.layer.cornerRadius = self.mrzScanButton.frame.height / 2
        nfcScanButton.layer.cornerRadius = self.nfcScanButton.frame.height / 2
        
        importImageButton.layer.cornerRadius = self.importImageButton.frame.height/2
    }
    
    override var leftBarButton: UIButton? {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        button.backgroundColor = .clear
        button.setImage(UIImage(named: "ic_action_arrowback"), for: .normal)
        button.tintColor = .white
        return button
    }
    
    override func handleLeftBarButtonEvent() {
        if let navigationController = self.navigationController {
            navigationController.popViewController(animated: true)
        }
    }
    
    // --------------------------------------
    // MARK: Private
    // --------------------------------------
    private func setupLayerView() {
        cameraView.layer.cornerRadius = 10.0
        cameraFrameImage.layer.cornerRadius = 10.0
        cameraFrameImage.removeFromSuperview()
        view.addSubview(cameraFrameImage)
        cameraFrameImage.frame = cameraView.frame
    }
    
    private func captureDevice(forPosition position: AVCaptureDevice.Position) -> AVCaptureDevice? {
        if #available(iOS 10.0, *) {
            let discoverySession = AVCaptureDevice.DiscoverySession(
                deviceTypes: [.builtInWideAngleCamera],
                mediaType: .video,
                position: .unspecified
            )
            return discoverySession.devices.first { $0.position == position }
        }
        return nil
    }
    
    private func setUpCaptureSessionOutput() {
        weak var weakSelf = self
        guard let strongSelf = weakSelf else {
            print("Self is nil!")
            return
        }
        strongSelf.captureSession.beginConfiguration()
        strongSelf.captureSession.sessionPreset = AVCaptureSession.Preset.high
        
        let output = AVCaptureVideoDataOutput()
        output.videoSettings = [(kCVPixelBufferPixelFormatTypeKey as String): kCVPixelFormatType_32BGRA]
        output.alwaysDiscardsLateVideoFrames = true
        let outputQueue = DispatchQueue(label: Constant.videoDataOutputQueueLabel)
        output.setSampleBufferDelegate(strongSelf, queue: outputQueue)
        guard strongSelf.captureSession.canAddOutput(output) else {
            print("Failed to add capture session output.")
            return
        }
        strongSelf.captureSession.addOutput(output)
        strongSelf.captureSession.commitConfiguration()
    }
    
    private func setUpCaptureSessionInput() {
        weak var weakSelf = self
        guard let strongSelf = weakSelf else {
            print("Self is nil!")
            return
        }
        guard let device = strongSelf.captureDevice(forPosition: .back) else {
            print("Failed to get capture device for camera position: back")
            return
        }
        do {
            strongSelf.captureSession.beginConfiguration()
            let currentInputs = strongSelf.captureSession.inputs
            for input in currentInputs {
                strongSelf.captureSession.removeInput(input)
            }
            
            let input = try AVCaptureDeviceInput(device: device)
            guard strongSelf.captureSession.canAddInput(input) else {
                print("Failed to add capture session input.")
                return
            }
            strongSelf.captureSession.addInput(input)
            strongSelf.captureSession.commitConfiguration()
        } catch {
            print("Failed to create capture device input: \(error.localizedDescription)")
        }
    }
    
    private func startSession() {
        weak var weakSelf = self
        DISPATCH_ASYNC_BG {
            guard let strongSelf = weakSelf else {
                print("Self is nil!")
                return
            }
            strongSelf.captureSession.startRunning()
        }
    }
    
    private func stopSession() {
        weak var weakSelf = self
        DISPATCH_ASYNC_BG {
            guard let strongSelf = weakSelf else {
                print("Self is nil!")
                return
            }
            strongSelf.captureSession.stopRunning()
        }
    }
    
    private func resetMRZSession() {
        // MRZ
        cameraView.isHidden = false
        if previewLayer != nil {
            previewLayer.isHidden = false
        }
        cameraFrameImage.isHidden = false
        mrzInstructionLabel.isHidden = false
        
        // NCF
        nfcInstructionLabel.isHidden = true
        animationScanNfc.isHidden = true
        
        mrzScanButton.isHidden = true
        nfcScanButton.isHidden = true
        importImageButton.isHidden = false
    }
    
    private func proccessMRZ(sampleBuffer: CMSampleBuffer) {
        MRZUtils.processMRZ(sampleBuffer: sampleBuffer, timeRequired: 0) {[weak self] mrzInfo in
            guard let self = self else {return}
            guard let info = mrzInfo else {
                return
            }
            if self.captureSession.isRunning == true {
                self.captureSession.stopRunning()
            }
            
            DISPATCH_ASYNC_MAIN {
                ONBOARDDATAMANAGER.mrzInfo = info
                ONBOARDDATAMANAGER.mrzKey = EIDFACADE.generateMRZKey(eidNumber: info.documentNumber, dateOfBirth: info.dateOfBirth, dateOfExpiry: info.dateOfExpiry)
                
                self.startNfcScan()
            }
        }
    }
    
    private func startNfcScan() {
        self.cameraView.isHidden = true
        self.cameraFrameImage.isHidden = true
        self.mrzInstructionLabel.isHidden = true
        self.nfcInstructionLabel.isHidden = false
        self.animationScanNfc.isHidden = false
        self.importImageButton.isHidden = true
        if previewLayer != nil {
            self.previewLayer.isHidden = true
        }
        self.animationScanNfc.loopMode = .loop
        self.animationScanNfc.play()
        self.hideBottomButton()
        
        EIDFACADE.readChipNfc(mrzKey: ONBOARDDATAMANAGER.mrzKey) { eid in
            self.nfcEidRead(eid: eid)
            self.showBottomButtons()
        } errorHandler: { error in
            self.showBottomButtons()
        }
    }
    
    
    private func showBottomButtons() {
        DISPATCH_ASYNC_MAIN { [weak self] in
            guard let self = self else {return}
            self.mrzScanButton.isHidden = false
            self.nfcScanButton.isHidden = false
        }
    }
    
    private func hideBottomButton() {
        DISPATCH_ASYNC_MAIN { [weak self] in
            guard let self = self else {return}
            self.mrzScanButton.isHidden = true
            self.nfcScanButton.isHidden = true
        }
    }
    
    private func nfcEidRead(eid: NfcEidModel?) {
        ONBOARDDATAMANAGER.eid = eid
        
        let request = CecaRequestModel()
        let info = CecaInfoRequestModel()
        info.version = "1.0.0"
        info.senderId = "CECA001"
        info.receiverId = "GTELEKYC"
        info.messageType = 101
        info.sendDate = Date().millisecondsSince1970
        info.messageId = CecaUtils.generateMessageId(senderId: "CECA001")
        request.info = info
        
        let content = CecaContentRequestModel()
        content.transactionId = UUID().uuidString.replacingOccurrences(of: "-", with: "").uppercased()
        let contentData = CecaDataRequestModel()
        contentData.code = "GTELICT"
        contentData.cecaTransactionCode = UUID().uuidString.replacingOccurrences(of: "-", with: "").uppercased()
        contentData.dsCert = eid?.documentSigningCertificate?.certToPEM().toBase64() ?? ""
        contentData.idCardNumber = eid?.dg13?.eidNumber ?? ""
        contentData.deviceType = "mobile"
        if let province = eid?.dg13?.placeOfResidence {
            contentData.province = CecaUtils.getProvince(address: province) ?? ""
        }
        content.data = contentData
        request.content = content
        
        request.signature = CecaUtils.generateSignature(secretKey: "2540E77E5DF54A6493C5D8F2EF585C8E", request: request)
        
        ONBOARDDATAMANAGER.cecaVerifyRequest = request
        
        if let eidFaceImage = eid?.eidImage {
            let fileName = "ID_\(Date().millisecondsSince1970).jpg"
            let path = Utils.saveFileToLocal(eidFaceImage, fileName: fileName)
            ONBOARDDATAMANAGER.eidFacePath = path.absoluteString
            if ONBOARDDATAMANAGER.businessType == .transfer {
                ONBOARDDATAMANAGER.faceId = path.absoluteString
            }
        }
        
        DISPATCH_ASYNC_MAIN_AFTER(2) {
            if ONBOARDDATAMANAGER.businessType == .verify_eid {
                self.navigateToVerifyingEidView()
            } else if ONBOARDDATAMANAGER.businessType == .verify_eid_ekyc || ONBOARDDATAMANAGER.businessType == .transfer || ONBOARDDATAMANAGER.businessType == .ocr {
                self.navigateToLivenessView()
            }
        }
    }
    
    private func navigateToVerifyingEidView() {
        DISPATCH_ASYNC_MAIN {
            let controller = INIT_CONTROLLER_XIB(VerifyingEidViewController.self)
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    private func navigateToLivenessView() {
//        DISPATCH_ASYNC_MAIN {
//            let controller = INIT_CONTROLLER_XIB(LivenessViewController.self)
//            self.navigationController?.pushViewController(controller, animated: true)
//        }
    }
    
    private func navigateToImportPictureView() {
        DISPATCH_ASYNC_MAIN {
            let controller = INIT_CONTROLLER_XIB(MRZImportImageViewController.self)
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    // --------------------------------------
    // MARK: Event
    // --------------------------------------
    @IBAction func mrzScanButtonAction(_ sender: UIButton) {
        if isNFCOnly {
            self.navigationController?.popViewController(animated: true)
            return
        }
        self.startSession()
        self.navigationItem.title = LOCALIZED("step_1_scan_mrz")
        self.resetMRZSession()
    }
    
    @IBAction func nfcScanButtonAction(_ sender: UIButton) {
        self.startNfcScan()
        self.navigationItem.title = LOCALIZED("step_2_nfc_read")
    }
    
    
    @IBAction func importImageButtonAction(_ sender: Any) {
        self.navigateToImportPictureView()
    }
}

extension MRZScannerViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    public func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
          print("Failed to get image buffer from sample buffer.")
          return
        }
        self.proccessMRZ(sampleBuffer: sampleBuffer)
    }
}

