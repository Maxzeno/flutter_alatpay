# Wema Bank AlatPay payment SDK

A Flutter package for integrating Wema Bank AlatPay payment into your mobile applications by Emmanuel Nwaegunwa. AlatPay is a payment gateway service.

## Installation

To use this package, add `flutter_alatpay` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

```yaml
dependencies:
  flutter_alatpay:
```

## Example

How to use the flutter_alatpay package.

```dart
// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:flutter_alatpay/flutter_alatpay.dart';

void main() {
  runApp(const MaterialApp(home: MyHome()));
}

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  void _payment() {
    String apiKey = 'eebb6239d69e4a7f813153564b764321';
    String businessId = '559r9b55-c939-4b30-2005-08dc0162527h';
    String email = 'mmnlchidera@gmail.com';
    String phone = '+2349077745730';
    String firstName = 'Emmanuel';
    String lastName = 'Nwaegunwa';
    String currency = 'NGN';
    String amount = '100000';

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
```
