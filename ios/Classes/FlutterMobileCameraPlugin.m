#import "FlutterMobileCameraPlugin.h"
#if __has_include(<flutter_mobile_camera/flutter_mobile_camera-Swift.h>)
#import <flutter_mobile_camera/flutter_mobile_camera-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_mobile_camera-Swift.h"
#endif

@implementation FlutterMobileCameraPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterMobileCameraPlugin registerWithRegistrar:registrar];
}
@end
