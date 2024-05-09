import verifysdk


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

extension DataGroup13: Encodable{
    
    
    enum CodingKeys: CodingKey{
        case eidNumber
        case fullName
        case dateOfBirth
        case gender
        case nationality
        case ethnicity
        case religion
        case placeOfOrigin
        case placeOfResidence
        case personalIdentification
        case dateOfIssue
        case dateOfExpiry
        case fatherName
        case motherName
        case spouseName
        case oldEidNumber
        case unkIdNumber
        case unkInfo
    }
    
    public func encode(to encoder: any Encoder) throws {
        
    }
}

@objc(EidSdkModule)
class EidSdkModule: NSObject {
    
    
    @objc(initialize:apiBaseUrl:customerCode:)
    func initialize(_ apiKey: String, apiBaseUrl: String, customerCode: String){
        DISPATCH_ASYNC_BG {
            print("\(apiKey) \(apiBaseUrl) \(customerCode)")
            let urlComp = URLComponents(string: apiBaseUrl)!
            let host = urlComp.host!
            APISERVICE.initialize(apiKey: apiKey , apiBaseUrl: host, customerCode: customerCode)
        }
    }
    
    @objc func presentViewController(_ completion: @escaping RCTResponseSenderBlock){
        DispatchQueue.main.async{
            let mrzScannerVC = MRZScannerViewController()
            mrzScannerVC.completion = completion
            let navController = NavigationController(rootViewController: mrzScannerVC)
            navController.setNavigationBarHidden(true, animated: false)
            navController.modalPresentationStyle = .fullScreen
            
            UIApplication.shared.delegate?.window??.rootViewController?.present(navController, animated: true)
        }
    }
}
