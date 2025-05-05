import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_app/core/secrets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class PaymentService {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static Future<bool> makePayment(
      int amount, String currency, String shopName) async {
    try {
      final secretClient = await createPaymentIntent(amount, currency);
      if (secretClient == null) {
        debugPrint("client secret is null");
        return false;
      }
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: secretClient,
        merchantDisplayName: shopName,
      ));
      await Stripe.instance.presentPaymentSheet();

      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  static Future<void> setTransactionHistory(
      int amount, String currency, String shopName, String method) async {
    await FirebaseFirestore.instance
        .collection("wallet")
        .doc(auth.currentUser!.uid)
        .collection("history")
        .doc()
        .set({
      "amount": "-\$$amount",
      "date": DateTime.now().toString(),
      "name": shopName,
      "order": DateTime.now().microsecondsSinceEpoch,
      "method": method,
      "status": "success"
    });
  }

  static Future<bool> payWithWallet(
      int amount, String currency, String shopName) async {
    return await FirebaseFirestore.instance
        .collection("wallet")
        .doc(auth.currentUser!.uid)
        .get()
        .then(
      (value) async {
        if (value.data() != null) {
          if (value.data()!["balance"] <= 0) return false;
          await FirebaseFirestore.instance
              .collection("wallet")
              .doc(auth.currentUser!.uid)
              .update({"balance": value.data()!["balance"] - amount});
          await FirebaseFirestore.instance
              .collection("wallet")
              .doc(auth.currentUser!.uid)
              .collection("history")
              .doc()
              .set({
            "amount": "-\$$amount",
            "date": DateTime.now().toString(),
            "name": shopName,
            "order": DateTime.now().microsecondsSinceEpoch,
            "method": "Wallet",
            "status": "success"
          });
          return true;
        } else {
          return false;
        }
      },
    );
  }

  static Future<String?> topUp(int amount, String currency) async {
    await FirebaseFirestore.instance
        .collection("wallet")
        .doc(auth.currentUser!.uid)
        .get()
        .then(
      (value) async {
        if (value.data() != null) {
          await FirebaseFirestore.instance
              .collection("wallet")
              .doc(auth.currentUser!.uid)
              .update({"balance": amount + value.data()!["balance"]});
        } else {
          await FirebaseFirestore.instance
              .collection("wallet")
              .doc(auth.currentUser!.uid)
              .set({"balance": amount});
        }
      },
    );
    await FirebaseFirestore.instance
        .collection("wallet")
        .doc(auth.currentUser!.uid)
        .collection("history")
        .doc()
        .set({
      "amount": "+\$$amount",
      "date": DateTime.now().toString(),
      "name": "Top Up Wallet",
      "order": DateTime.now().microsecondsSinceEpoch,
      "method": "Stripe",
      "status": "success"
    });
    return null;
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
      debugPrint(responseBody.toString());
      return responseBody["client_secret"];
    } catch (err) {
      print('err charging user: ${err.toString()}');
      return null;
    }
  }
}
