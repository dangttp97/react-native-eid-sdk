//
//  NFCController.swift
//  Alamofire
//
//  Created by Phương Đăng Trần Thành on 25/4/24.
//

import Foundation
import xverifysdk

class NFCController{
    class func getNFCCardInfo(mrzKey: String, completion: @escaping (_ data: NfcEidModel) -> Void, errorHandler: @escaping (_ e: Error) -> Void){
        EIDFACADE.readChipNfc(mrzKey: mrzKey, completionHandler: completion, errorHandler: errorHandler)
    }
    
    class func readEidModel(eidModel: NfcEidModel?) -> PersonalInfo{
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
        contentData.dsCert = eidModel?.documentSigningCertificate?.certToPEM().toBase64() ?? ""
        contentData.idCardNumber = eidModel?.dg13?.eidNumber ?? ""
        contentData.deviceType = "mobile"
        if let province = eidModel?.dg13?.placeOfResidence {
            contentData.province = CecaUtils.getProvince(address: province) ?? ""
        }
        content.data = contentData
        request.content = content
        
        request.signature = CecaUtils.generateSignature(secretKey: "2540E77E5DF54A6493C5D8F2EF585C8E", request: request)
        
        if let eidFaceImage = eidModel?.eidImage {
            let fileName = "ID_\(Date().millisecondsSince1970).jpg"
            let path = Utils.saveFileToLocal(eidFaceImage, fileName: fileName)
        }
        
        let dataGroup = eidModel?.dg13
        
        return PersonalInfo(eidNumber: dataGroup?.eidNumber, fullName: dataGroup?.fullName, gender: dataGroup?.gender, dateOfIssues: dataGroup?.dateOfIssue, dateOfExpiry: dataGroup?.dateOfExpiry, dateOfBirth: dataGroup?.dateOfBirth, nationality: dataGroup?.nationality, ethnicity: dataGroup?.ethnicity, religion: dataGroup?.religion, placeOfOrigin: dataGroup?.placeOfOrigin, placeOfResidence: dataGroup?.placeOfResidence, personalIdentification: dataGroup?.personalIdentification, fatherName: dataGroup?.fatherName, motherName: dataGroup?.motherName, spouseName: dataGroup?.spouseName, oldEidNumber: dataGroup?.oldEidNumber)
    }
}
