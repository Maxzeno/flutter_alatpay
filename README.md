# AlatPay Payment SDK for Flutter: Seamless Integration with WEMA Bank's Alatpay Gateway

Integrate WEMA Bank's Alatpay payment gateway effortlessly into your Flutter project with the flutter_alatpay SDK. This SDK provides a WebView that loads the Alatpay payment page, complete with transaction details, streamlining the payment processing experience. Handling responses from the payment gateway is simplified through callback functions, allowing you to manage both successful transactions and errors seamlessly.

## Key Features:

### Integration with Alatpay Payment Gateway
Easily integrate the Moamalat payment gateway into your Flutter app using the flutter_alatpay SDK.

### WebView Integration
The SDK offers WebView integration, loading Alatpay's payment page with transaction details for streamlined processing.

### Transaction Handling
Effortlessly manage responses from the payment gateway, with callback functions available for both successful transactions and errors.

### Customizable
Tailor the SDK to your specific needs by configuring parameters such as apiKey, businessId, currency, amount, metaData, and more.

### Cross-Platform Support
AlatPayFlutter supports Android, iOS, and Web platforms, with additional platform compatibility in the pipeline.

## Documentation:

### Required Parameters:

- **apiKey**: The API key obtained from AlatPay.
- **businessId**: The business ID obtained from AlatPay.
- **amount**: The transaction amount to be charged.
- **email**: The user's email address
- **onTransaction**: A callback function triggered upon completion of the payment.

### Optional Parameters:

- **phone**: The user's phone number
- **firstName**: The user's first name
- **lastName**: The user's last name
- **currency**: The currency
- **onClose**: A callback function activated when the service is closed.
- **metaData**: A key value pair of data to send with response


Overall, the flutter_alatpay SDK offers a convenient and secure solution for seamlessly integrating the AlatPay payment gateway into your Flutter app. Simplify your payment processing and enhance the user experience with this comprehensive SDK.

## Reach Me

[Linkedin](https://www.linkedin.com/in/emmanuel-nwaegunwa/)
[Twitter](https://twitter.com/_maxzeno)
[My Portfolio](https://maxzeno.vercel.app/)

Explore AlatPayFlutter now to elevate your payment gateway integration experience in Flutter!

## Installation

To use this package, add `flutter_alatpay` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

```yaml
dependencies:
  flutter_alatpay:
```

## Example

How to use the flutter_alatpay package.

```dart
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
```
