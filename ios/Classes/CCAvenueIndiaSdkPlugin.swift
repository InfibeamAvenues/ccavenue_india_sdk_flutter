import Flutter
import UIKit
import CCAvenueIndiaSDK

public class CcavenueIndiaSdkPlugin: NSObject, FlutterPlugin, CCAvenueDelegate {
    
    private var flutterResult: FlutterResult?
    private var snapshotView: UIView?

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "plugin_ccavenue", binaryMessenger: registrar.messenger())
        let instance = CcavenueIndiaSdkPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if call.method == "payCCAvenue" {
            guard let arguments = call.arguments as? [String: Any] else {
                result(FlutterError(code: "INVALID_ARGS", message: "Arguments are missing", details: nil))
                return
            }
            initiateCCAvenueSDK(result: result, arguments: arguments)
        } else {
            result(FlutterMethodNotImplemented)
        }
    }

    private func initiateCCAvenueSDK(result: @escaping FlutterResult, arguments: [String: Any]) {
        let accessCode         = arguments["accessCode"]          as? String ?? ""
        let encRequest         = arguments["encRequest"]          as? String ?? ""
        let appColor           = arguments["appColor"]           as? String ?? "#1F46BD"
        let fontColor          = arguments["fontColor"]          as? String ?? "#FFFFFF"
        let paymentEnvironment = arguments["paymentEnvironment"] as? String ?? "production"
        let encryptionMode     = arguments["encryptionMode"]     as? String ?? "aes128"    
      

        guard !accessCode.isEmpty, !encRequest.isEmpty else {
            result(FlutterError(code: "INVALID_PARAMS", message: "empty params", details: nil))
            return
        }

        self.flutterResult = result

        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            guard let self = self else { return }
            
            // Get the key window correctly for iOS 13+ and older
            let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) ?? UIApplication.shared.keyWindow
            guard let flutterVC = window?.rootViewController else { return }

            NSLog("🚀 About to call CCAvenueOrder init...")

            let model = CCAvenueOrder(
                accessCode: accessCode,
                encRequest: encRequest,
                paymentEnvironment: paymentEnvironment,
                appColor: appColor,
                fontColor: fontColor,
                encryptionMode: encryptionMode
            )

             

            // Take Flutter screenshot
            let renderer = UIGraphicsImageRenderer(bounds: flutterVC.view.bounds)
            let screenshot = renderer.image { ctx in
                flutterVC.view.drawHierarchy(in: flutterVC.view.bounds, afterScreenUpdates: false)
            }
            let snapshot = UIImageView(image: screenshot)
            snapshot.frame = window?.bounds ?? .zero
            snapshot.contentMode = .scaleAspectFill
            window?.addSubview(snapshot)
            self.snapshotView = snapshot    
            CCAvenueSDK.initTransaction(model, delegate: self, displayController: flutterVC)
        
        }
    }

    public func onTransactionResponse(_ jsonResponse: [String : Any]?) {
        
        let pendingResult  = self.flutterResult
        self.flutterResult = nil

        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.snapshotView?.removeFromSuperview()
            self.snapshotView = nil

            if let data = jsonResponse,
               let jsonData = try? JSONSerialization.data(withJSONObject: data),
               let jsonStr = String(data: jsonData, encoding: .utf8) {
                pendingResult?(jsonStr)
            } else {
                pendingResult?(FlutterError(code: "PAYMENT_ERROR", message: "Failed", details: nil))
            }
        }
    }
}