import 'package:flutter/material.dart';
import 'package:flutter_alatpay/flutter_alatpay.dart';

void main() {
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void _payment() {
    String apiKey = 'primary or secondary key (api key)';
    String businessId = 'business id';
    String email = 'mmnlchidera@gmail.com';
    String phone = '+2349077745730';
    String firstName = 'Emmanuel';
    String lastName = 'Nwaegunwa';
    String currency = 'NGN';
    String amount = '100000';
    Map metaData = {
      'key': 'value',
    };

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AlatPayWidget(
        apiKey: apiKey,
        businessId: businessId,
        email: email,
        phone: phone,
        firstName: firstName,
        lastName: lastName,
        currency: currency,
        amount: amount,
        metaData: metaData,
        onTransaction: (response) {
          // do something with response
        },
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ElevatedButton(
            onPressed: _payment, child: const Text('Go to Payment')),
      ),
    );
  }
}
