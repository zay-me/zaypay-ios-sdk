import Flutter
import UIKit
import ZayPay

public class ZayPayFlutterPlugin: NSObject, FlutterPlugin {

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "zaypay_flutter", binaryMessenger: registrar.messenger())
        let instance = ZayPayFlutterPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "launch":
            guard let args = call.arguments as? [String: Any] else {
                result(FlutterError(
                    code: "INVALID_ARGUMENTS",
                    message: "Invalid arguments",
                    details: nil
                ))
                return
            }
            guard let apiKey = args["apiKey"] as? String else {
                result(FlutterError(
                    code: "INVALID_ARGUMENTS",
                    message: "Invalid API key",
                    details: nil
                ))
                return
            }
            guard let withdrawAddress = args["withdrawAddress"] as? String else {
                result(FlutterError(
                    code: "INVALID_ARGUMENTS",
                    message: "Invalid withdraw address",
                    details: nil
                ))
                return
            }
            var options: Zay.Options = .init(
                showDepositModeSwitcher: true,
                startingDepositMode: .crypto
            )
            if let args = args["options"] as? [String: Any] {
                args["showDepositModeSwitcher"].flatMap { $0 as? Bool }.map { options.showDepositModeSwitcher = $0 }
                args["startingDepositMode"].flatMap { $0 as? String }.map {
                    switch $0 {
                    case "crypto":
                        options.startingDepositMode = .crypto
                    case "fiat":
                        let fiatInitialState: (String, Double)? = args["fiatDepositInitialState"].flatMap { $0 as? [String: Any] }
                            .flatMap {
                                guard let currency = $0["currency"] as? String,
                                      let amount = $0["amount"] as? Double
                                else {
                                    return nil
                                }
                                return (currency, amount)
                            }
                        options.startingDepositMode = .fiat(initialState: fiatInitialState.map {
                            .init(currency: $0.0, amount: $0.1)
                        })
                    default:
                        break
                    }
                }
            }
            Task { @MainActor in
                guard let topViewController = UIApplication.shared.topViewController else { assert(false); return }
                Zay.launch(
                    in: topViewController,
                    apiKey: apiKey,
                    withdrawAddress: withdrawAddress,
                    options: options
                )
                result(nil)
            }
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
}

fileprivate extension UIApplication {
    
    var topViewController: UIViewController? {
        UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .first?
            .keyWindow?
            .rootViewController?
            .topViewController
    }
    
}

fileprivate extension UIViewController {
    
    var topViewController: UIViewController? {
        guard let presentedViewController else { return self }
        return presentedViewController.topViewController
    }
    
}
