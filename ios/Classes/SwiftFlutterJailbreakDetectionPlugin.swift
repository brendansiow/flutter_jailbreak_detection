import Flutter
import UIKit
import DTTJailbreakDetection

public class SwiftFlutterJailbreakDetectionPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_jailbreak_detection", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterJailbreakDetectionPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

    public func isiOSAppOnMac() -> Bool {
      if #available(iOS 14.0, *) {
        return ProcessInfo.processInfo.isiOSAppOnMac
      }
      return false
    }


  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "jailbroken":
            if isiOSAppOnMac() {
                result(false);
            } else {
              let isJailBroken = DTTJailbreakDetection.isJailbroken()
              result(isJailBroken)
            }
            break
        case "developerMode":
            result(false)
            break
        default:
            result(FlutterMethodNotImplemented)
        }
  }
}
