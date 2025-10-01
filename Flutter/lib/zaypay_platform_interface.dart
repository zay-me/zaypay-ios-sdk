import 'dart:io';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'zaypay_webview.dart';
import 'zaypay_method_channel.dart';
import 'zaypay_options.dart';

abstract class ZayPayPlatform extends PlatformInterface {

  ZayPayPlatform() : super(token: _token);

  static final Object _token = Object();

  static ZayPayPlatform? _instance;
  static ZayPayPlatform get instance {
    if (Platform.isIOS) {
      _instance = MethodChannelZayPay();
    } else if (Platform.isAndroid) {
      _instance = WebViewZayPay();
    } else {
      _instance = WebViewZayPay();
    }
    return _instance!;
  }
  
  Future<void> launch(String apiKey, String withdrawAddress, ZayPayOptions options) async {
    throw UnimplementedError('launch() has not been implemented.');
  }

}
