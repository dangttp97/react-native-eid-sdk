
let ONBOARDDATAMANAGER = OnboardDataManager.shared

class OnboardDataManager: NSObject {

    var mrzKey: String = ""
    var mrzInfo: MRZInfo?
    var eid: NfcEidModel?{
        didSet{
            NotificationCenter.default.post(name: NSNotification.Name("example.eidmodel"), object: oldValue)
        }
    }
    var faceId: String = ""
    var ekycFront: String = ""
    
    var cardFrontPath: String = ""
    var cardBackPath: String = ""
    
    var eidFacePath: String = ""
    var cecaVerifyRequest: CecaRequestModel?
    var ocrResult: OCRResponseModel?
    var businessType: BusinessType? = .verify_eid
    // --------------------------------------
    // MARK: Singleton
    // --------------------------------------
    
    class var shared: OnboardDataManager {
        struct Static {
            static let instance = OnboardDataManager()
        }
        return Static.instance
    }
    
    override init() {
        
    }
    
    func clear() {
        mrzKey = ""
        mrzInfo = nil
        eid = nil
        eidFacePath = ""
        cecaVerifyRequest = nil
        businessType = nil
        cardFrontPath = ""
        cardBackPath = ""
        faceId = ""
        ekycFront = ""
        ocrResult = nil
    }
}
