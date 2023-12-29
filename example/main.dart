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
    String apiKey = 'eebb6239d69e4a7f813153564b764321';
    String businessId = '559r9b55-c939-4b30-2005-08dc0162527h';
    String email = 'mmnlchidera@gmail.com';
    String phone = '+2349077745730';
    String firstName = 'Emmanuel';
    String lastName = 'Nwaegunwa';
    String currency = 'NGN';
    String amount = '100000';

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return AlatPayWidget(
          apiKey: apiKey,
          businessId: businessId,
          email: email,
          phone: phone,
          firstName: firstName,
          lastName: lastName,
          currency: currency,
          amount: amount,
          onTransaction: (response) {
            // do something with response
          },
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ElevatedButton(
          onPressed: _payment,
          child: const Text('Go to Payment'),
        ),
      ),
    );
  }
}
