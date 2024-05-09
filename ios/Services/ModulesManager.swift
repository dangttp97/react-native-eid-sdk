import UIKit

let MODULESMANAGER = ModulesManager.shared

enum BusinessType: Int {
    case verify_eid         = 0
    case verify_eid_ekyc    = 1
    case transfer           = 2
    case ocr                = 3
    case verify_eid_ceca    = 4
}

protocol ModulesProtocol {
    var type: BusinessType { get }
    var title: String { get }
    var iconImageName: String { get }
    var enable: Bool { get }
}

class EidModule: ModulesProtocol {
    var type: BusinessType = .verify_eid
    var title: String = LOCALIZED("title_eid")
    var iconImageName: String =  "ic_nfc"
    var enable: Bool = true
    required init() {}
}

class EKycModule: ModulesProtocol {
    var type: BusinessType = .verify_eid_ekyc
    var title: String = LOCALIZED("title_ekyc")
    var iconImageName: String =  "ic_peoplescan"
    var enable: Bool = true
    required init() {}
}

class CecaModule: ModulesProtocol {
    var type: BusinessType = .verify_eid_ceca
    var title: String = LOCALIZED("title_ceca")
    var iconImageName: String =  "ic_note"
    var enable: Bool = false
    required init() {}
}

class TransferModule: ModulesProtocol {
    var type: BusinessType = .transfer
    var title: String = LOCALIZED("2345")
    var iconImageName: String =  "ic_card"
    var enable: Bool = true
    required init() {}
}

class OCRModule: ModulesProtocol {
    var type: BusinessType = .ocr
    var title: String = LOCALIZED("OCR")
    var iconImageName: String =  "ic_ocr"
    var enable: Bool = true
    required init() {}
}

class ModulesManager: NSObject {
    
    private var _allModules: [ModulesProtocol];

    // --------------------------------------
    // MARK: Singleton
    // --------------------------------------
    
    class var shared: ModulesManager {
        struct Static {
            static let instance = ModulesManager()
        }
        return Static.instance
    }
    
    override init() {
        _allModules = [
            EidModule.init(),
            EKycModule.init(),
            TransferModule.init(),
            OCRModule.init(),
            CecaModule.init()
        ]
        super.init()
    }
    
    // --------------------------------------
    // MARK: Public
    // --------------------------------------
    
    func getAllModules() -> [ModulesProtocol] {
        return _allModules
    }
    
    func clear() {
        _allModules.removeAll()
    }
    
//    func initController(_ type: BusinessType) -> UIViewController {
//        ONBOARDDATAMANAGER.businessType = type
//        switch (type) {
//        case .verify_eid: return VerifyEidMainViewController()
//        case .verify_eid_ekyc: return VerifyEkycMainViewController()
//        case .verify_eid_ceca: return VerifyCecaMainViewController()
//        case .ocr: return OCRCaptureViewController()
//        case .transfer:
//            if ONBOARDDATAMANAGER.faceId == "" || ONBOARDDATAMANAGER.ekycFront == "" {
//                return VerifyEkycMainViewController()
//            } else {
//                return TransferConfirmViewController()
//            }
//        default: return UIViewController()
//        }
//    }

}
