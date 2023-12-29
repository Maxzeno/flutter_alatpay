library flutter_alatpay;

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class AlatPayWidget extends StatefulWidget {
  final String apiKey;
  final String businessId;
  final String metaData;
  final String email;
  final String phone;
  final String firstName;
  final String lastName;
  final String currency;
  final String amount;
  final Function(dynamic response) onTransaction;
  final Function()? onClose;
  const AlatPayWidget({
    super.key,
    required this.apiKey,
    required this.businessId,
    this.metaData = 'null',
    required this.email,
    this.phone = '',
    this.firstName = '',
    this.lastName = '',
    this.currency = '"NGN"',
    required this.amount,
    required this.onTransaction,
    this.onClose,
  });

  @override
  AlatPayWidgetState createState() => AlatPayWidgetState();
}

class AlatPayWidgetState extends State<AlatPayWidget> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    String metaData = widget.metaData;
    String apiKey = widget.apiKey;
    String businessId = widget.businessId;
    String email = widget.email;
    String phone = widget.phone;
    String firstName = widget.firstName;
    String lastName = widget.lastName;
    String currency = widget.currency;
    String amount = widget.amount;

    String html = """
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, minimum-scale=1.0">
    </head>

    <body>
      <!-- <button onclick="showPayment()"> Pay with Alatpay </button> -->

    <script src="https://web.alatpay.ng/js/alatpay.js"></script>
    <script>
        let popup = Alatpay.setup({
            apiKey: $apiKey,
            businessId: $businessId,
            email: $email,
            phone: $phone,
            firstName: $firstName,
            lastName: $lastName,
            metaData: $metaData,
            currency: $currency,
            amount: $amount,

            onTransaction: function (response) {
                console.log("paymentsuccess", response)
            },

            onClose: function () {
                console.log("paymentcancel")
            }
        });

        function showPayment() {
            popup.show();
        }
        showPayment()
    </script>
    </body>

    </html>
    """;

    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setOnConsoleMessage((message) {
        debugPrint('flutter message.message ${message.message}');
        if (message.message.startsWith('paymentsuccess')) {
          String respStr = message.message.split('paymentsuccess')[1];
          dynamic resp = jsonDecode(respStr);
          widget.onTransaction(resp);
        }
        if (message.message == 'paymentcancel') {
          if (widget.onClose == null) {
            Navigator.pop(context);
          } else {
            widget.onClose!();
          }
        }
      })
      ..enableZoom(true)
      ..loadHtmlString(html);

    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }

    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: _controller);
  }
}
