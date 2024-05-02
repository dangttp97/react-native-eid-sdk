#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(EidSdkModule, NSObject)
RCT_EXTERN_METHOD(initialize:(NSString)apiKey (NSString)apiBaseUrl (NSString)customerCode)
RCT_EXTERN_METHOD(getPersonalInfo:(NSString *)imageUrlStr resolve:(RCTPromiseResolveBlock *)resolve reject:(RCTPromiseRejectBlock *)reject)
//RCT_EXTERN_METHOD(localizeText:(NSString)key (RCTPromiseResolveBlock)resolve)
//RCT_EXTERN_METHOD(verifyEid:([String:Any]) (RCTPromiseResolveBlock)resolve (RCTPromiseRejectBlock)reject)
@end
