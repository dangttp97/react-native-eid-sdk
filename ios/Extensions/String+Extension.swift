//
//  String+Extension.swift
//  react-native-national-db-lib
//
//  Created by Phương Đăng Trần Thành on 25/4/24.
//

import Foundation

extension String{
    func toBase64() -> String?{
        guard let data = self.data(using: String.Encoding.utf8) else {
            return nil
        }
        return data.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
    }
}
