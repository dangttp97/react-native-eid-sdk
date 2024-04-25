//
//  CodableNfcEidModel.swift
//  react-native-national-db-lib
//
//  Created by Phương Đăng Trần Thành on 23/4/24.
//

import Foundation

//class CodableEidVerifyModel: EidVerifyModel, Codable{
//    enum CodingKeys: String, CodingKey{
//        case transactionCode
//        case isValidIdCard
//        case responds
//        case signature
//        case detailMessage
//    }
//    
//    public required init(from decoder: any Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        
//        transactionCode = container.decode(String.self, forKey: .transactionCode)
//        isValidIdCard = container.decode(Bool.self, forKey: .isValidIdCard)
//        responds = container.decode(String.self, forKey: .responds)
//        signature = container.decode(String.self, forKey: .signature)
//        detailMessage = container.decode(String.self, forKey: .detailMessage)
//    }
//}
//
//extension CodableEidVerifyModel{
//    public func encode(to encoder: any Encoder) throws{
//        let container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(transactionCode, forKey: .transactionCode)
//        try container.encode(isValidIdCard, forKey: .isValidIdCard)
//        try container.encode(responds, forKey: .responds)
//        try container.encode(signature, forKey: .signature)
//        try container.encode(detailMessage, forKey: .detailMessage)
//    }
//}
