import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'zaypay_platform_interface.dart';
import 'zaypay_options.dart';

class MethodChannelZayPay extends ZayPayPlatform {

  @visibleForTesting
  final methodChannel = const MethodChannel('zaypay_flutter');

  @override
  Future<void> launch(String apiKey, String withdrawAddress, ZayPayOptions options) async {
    try {
      await methodChannel.invokeMethod<void>('launch', {
        'apiKey': apiKey,
        'withdrawAddress': withdrawAddress,
        'options': {
          'showDepositModeSwitcher': options.showDepositModeSwitcher,
          'startingDepositMode': options.startingDepositMode.name,
          'fiatDepositInitialState': options.fiatDepositInitialState != null ? {
            'currency': options.fiatDepositInitialState!.currency,
            'amount': options.fiatDepositInitialState!.amount
          } : null
        }
      });
    } on PlatformException catch (e) {
      throw Exception("Failed to launch Zay Pay: '${e.message}'.");
    }
  }

}
