
let ONBOARDDATAMANAGER = OnboardDataManager.shared

class OnboardDataManager: NSObject {

    var mrzKey: String = ""
    var mrzInfo: MRZInfo?
    var eid: NfcEidModel?
    var faceId: String = ""
    var ekycFront: String = ""
    
    var cardFrontPath: String = ""
    var cardBackPath: String = ""
    
    var eidFacePath: String = ""
    var cecaVerifyRequest: CecaRequestModel?
    var ocrResult: OCRResponseModel?
    var businessType: BusinessType?
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
