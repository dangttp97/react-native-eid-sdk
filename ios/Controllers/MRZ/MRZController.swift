//
//  MRZModule.swift
//  react-native-national-db-lib
//
//  Created by Phương Đăng Trần Thành on 23/4/24.
//

import Foundation
import OpenSSL
import xverifysdk

class MRZController{
    class func getMRZInfo(imageUrlStr: String, timeRequired: Int, completion: @escaping (_ data: MRZInfo?) -> Void, errorHandler: ((_ e: Error) -> Void)?){
        do{
            guard let imageURL = URL(string: imageUrlStr) else { return }
            let imageData = try Data(contentsOf: imageURL)
            MRZUtils.processMRZ(image: UIImage(data: imageData)!, timeRequired: timeRequired, callback: { info in
                let mrzInfo = MRZInfo(documentType: DocumentType(rawValue: (info?.documentType.rawValue ?? DocTypeEnum.TD1.rawValue))!, documentCode: info!.documentCode, issuingState: info!.issuingState, nationality: info!.nationality, documentNumber: info!.documentNumber, dateOfBirth: info!.dateOfBirth, gender: info!.gender, dateOfExpiry: info!.dateOfExpiry)
                completion(mrzInfo)
                
            })
        } catch (let e){
            errorHandler?(e)
        }
    }
    
    class func generateMRZKey(eidNumber: String, dateOfBirth: String, dateOfExpiry: String) -> String{
        return EIDFACADE.generateMRZKey(eidNumber: eidNumber, dateOfBirth: dateOfBirth, dateOfExpiry: dateOfExpiry)
    }
}
