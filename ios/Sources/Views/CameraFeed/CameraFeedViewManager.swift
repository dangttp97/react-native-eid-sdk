//
//  CameraFeedViewManager.swift
//  react-native-eid-sdk
//
//  Created by Phương Đăng Trần Thành on 3/5/24.
//

import Foundation
import React
import xverifysdk

extension MRZInfo: Encodable{
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
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(dateOfBirth, forKey: .dateOfBirth)
        try container.encode(dateOfExpiry, forKey: .dateOfExpiry)
        try container.encode(documentCode, forKey: .documentCode)
        try container.encode(documentType.rawValue, forKey: .documentType)
        try container.encode(documentNumber, forKey: .documentNumber)
        try container.encode(gender, forKey: .gender)
        try container.encode(issuingState, forKey: .issuingState)
        try container.encode(nationality, forKey: .nationality)
    }
}

@objc(CameraFeedView)
class CameraFeedViewManager: RCTViewManager{
    public var onReturnMRZData: RCTBubblingEventBlock?
    
    override func view() -> UIView! {
        let cameraFeedView = CameraFeedView()
        cameraFeedView.delegate = self
        
        return cameraFeedView
    }
}

extension CameraFeedViewManager: CameraFeedViewDelegate{
    func cameraDidReturnMRZData(info: MRZInfo?, key: String) {
        do{
            let jsonEncoder = JSONEncoder()
            let data = try jsonEncoder.encode(info)
            let jsonObj = try JSONSerialization.jsonObject(with: data) as! [String : Any]
            
            if(onReturnMRZData != nil){
                onReturnMRZData!(jsonObj)
            }
        }
        catch(let error){
            print(error.localizedDescription)
        }
    }
}
