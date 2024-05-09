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

fileprivate class InfoPlist{
    class func getValue<T>(with key: String) -> T? where T: Any{
        let dict = Bundle.main.infoDictionary
        return dict?[key] as? T
    }
}

@objc(EidSdkModule)
class EidSdkModule: NSObject {

    
    @objc(initialize:apiBaseUrl:customerCode:)
    func initialize(_ apiKey: String, apiBaseUrl: String, customerCode: String){
        DISPATCH_ASYNC_BG {
            APISERVICE.initialize(apiKey: InfoPlist.getValue(with: "API_KEY") ?? "" , apiBaseUrl: InfoPlist.getValue(with: "API_URL") ?? "", customerCode: InfoPlist.getValue(with: "CUSTOMER_CODE") ?? "")
        }
        
        DispatchQueue.main.async{
            let navController = NavigationController(rootViewController: VerifyEidMainViewController())
            navController.setNavigationBarHidden(true, animated: false)
            
            UIApplication.shared.delegate?.window??.rootViewController?.present(navController, animated: true)
            UIApplication.shared.delegate?.window??.makeKeyAndVisible()
        }
    }
}
