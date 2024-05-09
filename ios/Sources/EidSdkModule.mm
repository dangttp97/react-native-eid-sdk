#import <React/RCTBridgeModule.h>
#import <React/RCTViewManager.h>

@interface RCT_EXTERN_MODULE(EidSdkModule, NSObject)
RCT_EXTERN_METHOD(initialize:(NSString *)apiKey apiBaseUrl:(NSString *)apiBaseUrl customerCode:(NSString *)customerCode)
RCT_EXTERN_METHOD(presentViewController: (RCTResponseSenderBlock)completion)
//RCT_EXTERN_METHOD(verifyEid:([String:Any]) (RCTPromiseResolveBlock)resolve (RCTPromiseRejectBlock)reject)
@end
