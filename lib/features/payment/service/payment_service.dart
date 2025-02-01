import 'dart:convert';
import 'dart:developer';

import 'package:coffee_app/core/secrets.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class PaymentService {
  static Future<bool> makePayment() async {
    try {
      final secretClient = await createPaymentIntent(100, "usd");
      if (secretClient == null) {
        log("client secret is null");
        return false;
      }
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: secretClient,
        merchantDisplayName: "Caffely",
      ));
      await Stripe.instance.presentPaymentSheet();
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  static Future<String?> createPaymentIntent(
      int amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': (amount * 100).toString(),
        'currency': currency,
      };
      var response = await http
          .post(Uri.parse(stripePaymentIntentUrl), body: body, headers: {
        'Authorization': 'Bearer $stripeSecretKey',
        'Content-Type': 'application/x-www-form-urlencoded'
      });
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      log(responseBody.toString());
      return responseBody["client_secret"];
    } catch (err) {
      print('err charging user: ${err.toString()}');
      return null;
    }
  }
}
