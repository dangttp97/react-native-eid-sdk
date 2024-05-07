//
//  CameraFeedViewManager.m
//  react-native-eid-sdk
//
//  Created by Phương Đăng Trần Thành on 3/5/24.
//

#import <Foundation/Foundation.h>
#import <React/RCTBridgeModule.h>
#import <React/RCTViewManager.h>

@interface RCT_EXTERN_MODULE(CameraFeedView, RCTViewManager)
RCT_EXPORT_VIEW_PROPERTY(onReturnMRZData, RCTBubblingEventBlock)
@end


