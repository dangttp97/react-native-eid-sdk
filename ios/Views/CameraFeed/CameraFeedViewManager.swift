//
//  CameraFeedViewManager.swift
//  react-native-eid-sdk
//
//  Created by Phương Đăng Trần Thành on 3/5/24.
//

import Foundation
import React
import xverifysdk

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
