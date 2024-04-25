//
//  MRZInfo.swift
//  react-native-national-db-lib
//
//  Created by Phương Đăng Trần Thành on 23/4/24.
//

import Foundation

public class MRZInfo: Codable{
    var documentType: DocumentType
    var documentCode: String
    var issuingState: String
    var nationality: String
    var documentNumber: String
    var dateOfBirth: String
    var gender: String
    var dateOfExpiry: String
    
    enum CodingKeys: String, CodingKey{
        case documentType
        case documentCode
        case issuingState
        case nationality
        case documentNumber
        case dateOfBirth
        case gender
        case dateOfExpiry
    }
    
    public init(documentType: DocumentType, documentCode: String, issuingState: String, nationality: String, documentNumber: String, dateOfBirth: String, gender: String, dateOfExpiry: String) {
        self.documentType = documentType
        self.documentCode = documentCode
        self.issuingState = issuingState
        self.nationality = nationality
        self.documentNumber = documentNumber
        self.dateOfBirth = dateOfBirth
        self.gender = gender
        self.dateOfExpiry = dateOfExpiry
    }
    
    public required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        documentType = try container.decode(DocumentType.self, forKey: .documentType)
        documentCode = try container.decode(String.self, forKey: .documentCode)
        issuingState = try container.decode(String.self, forKey: .issuingState)
        nationality = try container.decode(String.self, forKey: .nationality)
        documentNumber = try container.decode(String.self, forKey: .documentNumber)
        dateOfBirth = try container.decode(String.self, forKey: .dateOfBirth)
        gender = try container.decode(String.self, forKey: .gender)
        dateOfExpiry = try container.decode(String.self, forKey: .dateOfExpiry)
    }
}

extension MRZInfo{
    public func encode(to encoder: any Encoder) throws{
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(documentType, forKey: .documentType)
        try container.encode(documentCode, forKey: .documentCode)
        try container.encode(issuingState, forKey: .issuingState)
        try container.encode(nationality, forKey: .nationality)
        try container.encode(documentNumber, forKey: .documentNumber)
        try container.encode(dateOfBirth, forKey: .dateOfBirth)
        try container.encode(gender, forKey: .gender)
        try container.encode(dateOfExpiry, forKey: .dateOfExpiry)
    }
}
