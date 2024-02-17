import 'dart:developer';
import 'package:crafty_bay/presentation/ui/widgets/payment_success_or_failed_dialog.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebViewScreen extends StatefulWidget {
  const PaymentWebViewScreen({super.key, required this.url});

  final String url;

  @override
  State<PaymentWebViewScreen> createState() => _PaymentWebViewScreenState();
}

class _PaymentWebViewScreenState extends State<PaymentWebViewScreen> {
  late WebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.endsWith('=success')) {
              log(request.url);
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) => const PaymentSuccessorFailedDialog(
                  isSuccess: true,
                ),
              );
              return NavigationDecision.prevent;
            } else if (request.url.endsWith('=Failed')) {
              log(request.url);
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const PaymentSuccessorFailedDialog(
                  isSuccess: false,
                ),
              );

              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    log(widget.url);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
      ),
      body: WebViewWidget(
        controller: _webViewController,
      ),
    );
  }
}


