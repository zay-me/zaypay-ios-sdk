import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'zaypay_platform_interface.dart';
import 'zaypay_options.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class WebViewZayPay extends ZayPayPlatform {
  @override
  Future<void> launch(String apiKey, String withdrawAddress, ZayPayOptions options) async {
    if (navigatorKey.currentState == null) {
      throw Exception(
        'NavigatorKey is not attached to MaterialApp. '
        'Add navigatorKey: navigatorKey to your MaterialApp widget.'
      );
    }
    final context = navigatorKey.currentContext;
    if (context == null) {
      throw Exception(
        'Navigator context is null. '
        'Make sure MaterialApp is built before calling launch().'
      );
    }
    await Navigator.push(
      context,
      _ZayPayWebViewScreenRoute(page: ZayPayWebViewScreen(
        apiKey: apiKey,
        withdrawAddress: withdrawAddress,
        options: options,
      ))
    );
  }
}

class ZayPayWebViewScreen extends StatefulWidget {
  final String apiKey;
  final String withdrawAddress;
  final ZayPayOptions options;

  const ZayPayWebViewScreen({
    super.key,
    required this.apiKey,
    required this.withdrawAddress,
    required this.options
  });

  @override
  State<ZayPayWebViewScreen> createState() => _ZayPayWebViewScreenState();
}

class _ZayPayWebViewScreenState extends State<ZayPayWebViewScreen> {
  late final WebViewController webViewController;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    final url = buildUrl(widget.apiKey, widget.withdrawAddress, widget.options);

    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            setState(() {
              isLoading = true;
            });
          },
          onPageFinished: (url) {
            setState(() {
              isLoading = false;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(url));
  }

  String buildUrl(String apiKey, String withdrawAddress, ZayPayOptions options) {
    final baseUrl = 'https://flow.onside.io/widget';
    final params = {
      'api_key': apiKey,
      'withdraw_address': 'sol:$withdrawAddress',
      'hide_deposit_type_switcher': (!options.showDepositModeSwitcher).toString(),
      'deposit_type': options.startingDepositMode.name,
      'onramp_fiat': options.fiatDepositInitialState?.currency,
      'onramp_amount': options.fiatDepositInitialState?.amount.toString()
    }..removeWhere((key, value) => value == null);
    final queryString = params.entries
        .map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value.toString())}')
        .join('&');
print('$baseUrl?$queryString');
    return '$baseUrl?$queryString';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Zay Pay'),
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
          backgroundColor: Color.from(alpha: 1.0, red: 0.05882352941, green: 0.05882352941, blue: 0.07058823529),
          foregroundColor: Colors.white,
        ),
        body: Stack(
          children: [
            WebViewWidget(controller: webViewController),
            if (isLoading)
              const Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}

class _ZayPayWebViewScreenRoute extends PageRouteBuilder {
  final Widget page;

  _ZayPayWebViewScreenRoute({required this.page}) : super(
    opaque: false,
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 1),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
        )),
        child: child,
      );
    },
  );
}
