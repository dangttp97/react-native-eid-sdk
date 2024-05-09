//
//  CameraFeedViewManager.swift
//  react-native-eid-sdk
//
//  Created by Phương Đăng Trần Thành on 3/5/24.
//

import Foundation
import React
import verifysdk

@objc(CameraFeedViewManager)
class CameraFeedViewManager: RCTViewManager{
    override func view() -> UIView! {
        let cameraFeedView = CameraFeedView()
        return cameraFeedView
    }
    
    override static func requiresMainQueueSetup() -> Bool {
        return true
    }
    
}
