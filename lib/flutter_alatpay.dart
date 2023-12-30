library flutter_alatpay;

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webviewx/webviewx.dart';

class AlatPayWidget extends StatefulWidget {
  final String apiKey;
  final String businessId;
  final Map? metaData;
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
    this.metaData,
    required this.email,
    this.phone = '',
    this.firstName = '',
    this.lastName = '',
    this.currency = 'NGN',
    required this.amount,
    required this.onTransaction,
    this.onClose,
  });

  @override
  AlatPayWidgetState createState() => AlatPayWidgetState();
}

class AlatPayWidgetState extends State<AlatPayWidget> {
  late WebViewXController webviewController;
  String html = "";
  @override
  void initState() {
    super.initState();

    String metaData =
        widget.metaData == null ? 'null' : jsonEncode(widget.metaData);
    String apiKey = '"${widget.apiKey}"';
    String businessId = '"${widget.businessId}"';
    String email = '"${widget.email}"';
    String phone = '"${widget.phone}"';
    String firstName = '"${widget.firstName}"';
    String lastName = '"${widget.lastName}"';
    String currency = '"${widget.currency}"';
    String amount = widget.amount;

    html = """
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
            metadata: $metaData,
            currency: $currency,
            amount: $amount,

            onTransaction: function (response) {
              paymentsuccess(JSON.stringify(response))
            },

            onClose: function () {
              paymentcancel("payment cancel")
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
    print(html);
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Scaffold(
        body: Center(
      // Look here!
      child: WebViewX(
          dartCallBacks: <DartCallback>{
            DartCallback(
              name: 'paymentsuccess',
              callBack: (message) {
                print('message success gotten $message');
                dynamic resp = jsonDecode(message);
                print('the resp $resp');
                widget.onTransaction(resp);
              },
            ),
            DartCallback(
              name: 'paymentcancel',
              callBack: (message) {
                print('message cancel gotten $message');
                if (widget.onClose == null) {
                  Navigator.pop(context);
                } else {
                  widget.onClose!();
                }
              },
            ),
          },
          width: media.width,
          height: media.height,
          initialContent: html,
          initialSourceType: SourceType.html,
          onWebViewCreated: (controller) {
            webviewController = controller;
          }),
    ));
  }
}
