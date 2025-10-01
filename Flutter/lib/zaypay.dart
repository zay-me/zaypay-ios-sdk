
import 'zaypay_platform_interface.dart';
import 'zaypay_options.dart';

export 'zaypay_options.dart';
export 'zaypay_webview.dart';

class ZayPay {
  Future<void> launch(
    {
      required String apiKey,
      required String withdrawAddress, 
      ZayPayOptions options = const ZayPayOptions()
    }
  ) async {
    return ZayPayPlatform.instance.launch(apiKey, withdrawAddress, options);
  }
}
