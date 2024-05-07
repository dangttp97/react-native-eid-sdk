require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))
folly_compiler_flags = '-DFOLLY_NO_CONFIG -DFOLLY_MOBILE=1 -DFOLLY_USE_LIBCPP=1 -Wno-comma -Wno-shorten-64-to-32'

Pod::Spec.new do |s|
#  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  s.static_framework = true
  s.name             = "react-native-eid-sdk"
  s.version          = package["version"]
  s.summary          = package["description"]
  s.homepage         = package["homepage"]
  s.license          = package["license"]
  s.authors          = package["author"]
  s.platforms        = { :ios => min_ios_version_supported }
  s.source           = { :git => "https://github.com/dangttp97/react-native-eid-sdk.git", :tag => "#{s.version}" }
  # Use install_modules_dependencies helper to install the dependencies if React Native version >=0.71.0.
  # See https://github.com/facebook/react-native/blob/febf6b7f33fdb4904669f99d795eba4c0f95d7bf/scripts/cocoapods/new_architecture.rb#L79.
  
  s.vendored_frameworks = 'ios/Frameworks/*.xcframework', "ios/Frameworks/*.framework"
  s.source_files = "ios/Sources/**/*.{h,m,mm,swift}"

  s.dependency "React"
  s.dependency 'Alamofire', '~> 5.8.1'
  s.dependency 'OpenSSL-Universal', '~> 1.1.2200'
  s.dependency 'CocoaLumberjack/Swift'
  s.dependency 'ObjectMapper'
  s.dependency 'SwiftDate'
  s.dependency 'PINCache'
  s.dependency 'SwiftyJSON'
  s.dependency 'GoogleMLKit/Vision'
  s.dependency 'GoogleMLKit/FaceDetection'
  s.dependency 'GoogleMLKit/TextRecognition'
end
