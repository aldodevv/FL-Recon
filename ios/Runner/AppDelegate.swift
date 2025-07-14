import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    // 1. Dapatkan FlutterViewController untuk mengakses binary messenger.
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController

    // 2. Definisikan nama channel yang SAMA PERSIS.
    let dataChannel = FlutterMethodChannel(name: "id.co.recon.dev/yeamplow",
                                           binaryMessenger: controller.binaryMessenger)

    // 3. Atur handler untuk menerima panggilan dari Flutter.
    dataChannel.setMethodCallHandler({
      (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      
      // 4. Gunakan 'switch' untuk menangani metode yang dipanggil.
      switch call.method {
      case "sendString":
        // Ambil argumen sebagai String, gunakan guard untuk keamanan
        guard let data = call.arguments as? String else {
          result(FlutterError(code: "INVALID_ARGUMENT", message: "String argument expected", details: nil))
          return
        }
        // Print di console Xcode
        print("NativeLog-Swift: Received String: \(data)")
        result(nil) // Kirim konfirmasi sukses (opsional)
      
      case "sendObject":
        // Ambil argumen sebagai Dictionary (Map di Swift)
        guard let data = call.arguments as? [String: Any] else {
          result(FlutterError(code: "INVALID_ARGUMENT", message: "Object/Dictionary argument expected", details: nil))
          return
        }
        print("NativeLog-Swift: Received Object: \(data)")
        result(nil)
        
      case "sendArray":
        // Ambil argumen sebagai Array
        guard let data = call.arguments as? [Any] else {
          result(FlutterError(code: "INVALID_ARGUMENT", message: "Array argument expected", details: nil))
          return
        }
        print("NativeLog-Swift: Received Array: \(data)")
        result(nil)
        
      default:
        result(FlutterMethodNotImplemented)
      }
    })
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
