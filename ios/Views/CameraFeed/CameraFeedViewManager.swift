//
//  CameraFeedViewManager.swift
//  react-native-eid-sdk
//
//  Created by Phương Đăng Trần Thành on 3/5/24.
//

import Foundation
import React
import verifysdk

<<<<<<< Updated upstream:ios/Views/CameraFeed/CameraFeedViewManager.swift
@objc(CameraFeedView)
=======
@objc(CameraFeedViewManager)
>>>>>>> Stashed changes:ios/Sources/Views/CameraFeed/CameraFeedViewManager.swift
class CameraFeedViewManager: RCTViewManager{
    override func view() -> UIView! {
        let cameraFeedView = CameraFeedView()
        return cameraFeedView
    }
    
    override static func requiresMainQueueSetup() -> Bool {
        return true
    }
    
}
