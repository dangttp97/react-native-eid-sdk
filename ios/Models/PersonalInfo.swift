//
//  PersonalInfo.swift
//  react-native-national-db-lib
//
//  Created by Phương Đăng Trần Thành on 25/4/24.
//

import Foundation

class PersonalInfo: Codable{
    var eidNumber: String?
    var fullName: String?
    var gender: String?
    var dateOfIssues: String?
    var dateOfExpiry: String?
    var dateOfBirth: String?
    var nationality: String?
    var ethnicity: String?
    var religion: String?
    var placeOfOrigin: String?
    var placeOfResidence: String?
    var personalIdentification: String?
    var fatherName: String?
    var motherName: String?
    var spouseName: String?
    var oldEidNumber: String?
    
    enum CodingKeys: CodingKey{
        case eidNumber
        case fullName
        case gender
        case dateOfIssues
        case dateOfExpiry
        case dateOfBirth
        case nationality
        case ethnicity
        case religion
        case placeOfOrigin
        case placeOfResidence
        case personalIdentification
        case fatherName
        case motherName
        case spouseName
        case oldEidNumber
    }
    
    init(eidNumber: String?, fullName: String?, gender: String?, dateOfIssues: String?, dateOfExpiry: String?, dateOfBirth: String?, nationality: String?, ethnicity: String?, religion: String?, placeOfOrigin: String? = nil, placeOfResidence: String? = nil, personalIdentification: String? = nil, fatherName: String? = nil, motherName: String? = nil, spouseName: String? = nil, oldEidNumber: String? = nil) {
        self.eidNumber = eidNumber
        self.fullName = fullName
        self.gender = gender
        self.dateOfIssues = dateOfIssues
        self.dateOfExpiry = dateOfExpiry
        self.dateOfBirth = dateOfBirth
        self.nationality = nationality
        self.ethnicity = ethnicity
        self.religion = religion
        self.placeOfOrigin = placeOfOrigin
        self.placeOfResidence = placeOfResidence
        self.personalIdentification = personalIdentification
        self.fatherName = fatherName
        self.motherName = motherName
        self.spouseName = spouseName
        self.oldEidNumber = oldEidNumber
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.dateOfBirth = try container.decode(String.self, forKey: .dateOfBirth)
        self.dateOfExpiry = try container.decode(String.self, forKey: .dateOfExpiry)
        self.dateOfIssues = try container.decode(String.self, forKey: .dateOfIssues)
        self.eidNumber = try container.decode(String.self, forKey: .eidNumber)
        self.ethnicity = try container.decode(String.self, forKey: .ethnicity)
        self.fatherName = try container.decode(String.self, forKey: .fatherName)
        self.fullName = try container.decode(String.self, forKey: .fullName)
        self.gender = try container.decode(String.self, forKey: .gender)
        self.motherName = try container.decode(String.self, forKey: .motherName)
        self.nationality = try container.decode(String.self, forKey: .nationality)
        self.oldEidNumber = try container.decode(String.self, forKey: .oldEidNumber)
        self.personalIdentification = try container.decode(String.self, forKey: .personalIdentification)
        self.placeOfOrigin = try container.decode(String.self, forKey: .placeOfOrigin)
        self.placeOfResidence = try container.decode(String.self, forKey: .placeOfResidence)
        self.religion = try container.decode(String.self, forKey: .religion)
        self.spouseName = try container.decode(String.self, forKey: .spouseName)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.eidNumber, forKey: .eidNumber)
        try container.encode(self.fullName, forKey: .fullName)
        try container.encode(self.gender, forKey: .gender)
        try container.encode(self.dateOfIssues, forKey: .dateOfIssues)
        try container.encode(self.dateOfExpiry, forKey: .dateOfExpiry)
        try container.encode(self.dateOfBirth, forKey: .dateOfBirth)
        try container.encode(self.nationality, forKey: .nationality)
        try container.encode(self.ethnicity, forKey: .ethnicity)
        try container.encode(self.religion, forKey: .religion)
        try container.encodeIfPresent(self.placeOfOrigin, forKey: .placeOfOrigin)
        try container.encodeIfPresent(self.placeOfResidence, forKey: .placeOfResidence)
        try container.encodeIfPresent(self.personalIdentification, forKey: .personalIdentification)
        try container.encodeIfPresent(self.fatherName, forKey: .fatherName)
        try container.encodeIfPresent(self.motherName, forKey: .motherName)
        try container.encodeIfPresent(self.spouseName, forKey: .spouseName)
        try container.encodeIfPresent(self.oldEidNumber, forKey: .oldEidNumber)
    }
}
