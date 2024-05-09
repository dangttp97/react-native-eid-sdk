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
        
        DispatchQueue.main.async{
            let navController = NavigationController(rootViewController: VerifyEidMainViewController())
            navController.setNavigationBarHidden(true, animated: false)
            navController.modalPresentationStyle = .fullScreen
            
            UIApplication.shared.delegate?.window??.rootViewController?.present(navController, animated: true)
        }
    }
}
