import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:stripe_payment/stripe_payment.dart';

class StripeScreen extends StatefulWidget {
  const StripeScreen({Key? key}) : super(key: key);

  @override
  _StripeScreenState createState() => _StripeScreenState();
}

class _StripeScreenState extends State<StripeScreen> {
  double _cost = 10.0;
  int amount = 0;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    StripePayment.setOptions(StripeOptions(
        publishableKey:
            'pk_test_51J1rqjLPBwJSson49BWFdOf5mdmuUYZWs1f9mZEYBonui9zOtIhLbOuni0XnwVBlxTyA93PixENQojl9wOjT5dVh00ZiroHBMG',
        androidPayMode: 'test',
        merchantId: 'Test'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            startPayment();
          },
          child: Text('pay'),
        ),
      ),
    );
  }

  Future<void> startPayment() async {
    StripePayment.setStripeAccount('');

    amount = (10 * 100).toInt();

    PaymentMethod _paymentMethod = PaymentMethod();
    _paymentMethod =
        await StripePayment.paymentRequestWithCardForm(CardFormPaymentRequest())
            .then((PaymentMethod paymentMethod) => paymentMethod)
            .catchError((e) {
      print(e);
    });

    startDirectCharge(_paymentMethod);
  }

  Future<void> startDirectCharge(PaymentMethod paymentMethod) async {
    print('charge started');

    final http.Response response = await http.post(Uri.parse(''));

    if (response.body != null) {
      final paymentIntent = jsonDecode(response.body);
      final status = paymentIntent['paymentIntent']['status'];
      final act = paymentIntent['stripeAccount'];

      if (status == 'succeeded')
        print('payment done');
      else {
        StripePayment.setStripeAccount(act);
        await StripePayment.confirmPaymentIntent(PaymentIntent(
                paymentMethodId: paymentIntent['paymentIntent']
                    ['payment_method'],
                clientSecret: paymentIntent['paymentIntent']['client_secret']))
            .then((PaymentIntentResult paymentIntentResult) {
          final status = paymentIntentResult.status;
          if (status == 'succeeded') {
            print('payment done');
          }
        });
      }
    }
  }
}
