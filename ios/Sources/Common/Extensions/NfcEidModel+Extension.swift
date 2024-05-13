//
//  NfcEidModel+Extension.swift
//  react-native-eid-sdk
//
//  Created by Phương Đăng Trần Thành on 13/5/24.
//

import Foundation

extension NfcEidModel{
    func toJSON() -> [String: Any]{
        let faceImageStr = self.eidImage?.toBase64()
        return [
            "dateOfBirth": self.dg13?.dateOfBirth,
            "dateOfExpiry": self.dg13?.dateOfExpiry,
            "dateOfIssue": self.dg13?.dateOfIssue,
            "eidNumber": self.dg13?.eidNumber,
            "ethnicity": self.dg13?.ethnicity,
            "face": faceImageStr,
            "fatherName": self.dg13?.fatherName,
            "fullname": self.dg13?.fullName,
            "gender": self.dg13?.gender,
            "motherName": self.dg13?.motherName,
            "oldEidNumber": self.dg13?.oldEidNumber,
            "personalIdentification": self.dg13?.personalIdentification,
            "placeOfOrigin": self.dg13?.placeOfOrigin,
            "placeOfResidence": self.dg13?.placeOfResidence,
            "religion": self.dg13?.religion,
            "spouseName": self.dg13?.spouseName
        ]
    }
}
