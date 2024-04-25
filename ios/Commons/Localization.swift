//
//  Localization.swift
//  react-native-national-db-lib
//
//  Created by Phương Đăng Trần Thành on 23/4/24.
//

import Foundation

public enum Localization: String, CaseIterable{
    case verify = "verify"
    case titleScanStep = "title_scan_step"
    case ok = "ok"
    case cancel = "cancel"
    case loadingData = "loading_data"
    case nextButton = "next_button"
    case tryAgainButton = "try_again_button"
    //Error
    case errorOCRNotSameDocument = "error_ocr_not_same_document"
    
    static func with(key: String) -> Localization{
        return self.allCases.first(where: {"\($0)" == key})!
    }
}
