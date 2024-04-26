import xverifysdk
import Foundation
import React
import Alamofire

@objc(EidSdkModule)
class EidSdkModule: NSObject {
    @objc func initialize(apiKey: String, apiBaseUrl: String, customerCode: String){
        APISERVICE.initialize(apiKey: apiKey, apiBaseUrl: apiBaseUrl, customerCode: customerCode)
    }
    
    @objc func getPersonalInfo(imageUrlStr: String, resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock){
        MRZController.getMRZInfo(imageUrlStr: imageUrlStr, timeRequired: 0, completion: { data in
            guard let info = data else {
                reject(nil, nil, nil)
                return
            }
            let mrzKey = MRZController.generateMRZKey(eidNumber: info.documentNumber, dateOfBirth: info.dateOfBirth, dateOfExpiry: info.dateOfExpiry)
            
            NFCController.getNFCCardInfo(mrzKey: mrzKey, completion: { data in
                do{
                    let info = NFCController.readEidModel(eidModel: data)
                    let jsonData = try info.toDictionary()
                    resolve(jsonData)
                }
                catch{
                    reject(nil, nil, error)
                }
            }, errorHandler: { e in
                reject(nil, nil, e)
            })
        }, errorHandler: { e in
            reject(nil, nil, e)
        })
    }
}
