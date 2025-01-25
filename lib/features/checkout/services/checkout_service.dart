import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_app/features/home/models/coffee_model.dart';
import 'package:coffee_app/features/home/models/offer_model.dart';
import 'package:dartz/dartz.dart';

import '../../buying/models/order_details_model.dart';

class CheckoutService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<void> removeCheckout(String id) async {
    try {
      await _firestore.collection('checkouts').doc(id).delete();
    } catch (e) {
      rethrow;
    }
  }

  static Future<Either<String, List<OrderDetailsModel>>> getCheckouts(
      String shopId) async {
    try {
      final response = await _firestore
          .collection('checkouts')
          .where("shop-id", isEqualTo: shopId)
          .get()
          .then((value) async {
        return value;
      });
      List<OrderDetailsModel> orderDetailsList = [];
      for (var element in response.docs) {
        final coffeeModel = await _firestore
            .collection('products')
            .doc(element.data()["product-id"])
            .get()
            .then((value) => CoffeeModel.fromJson(value.data()!));
        final orderDetailsModel =
            OrderDetailsModel.fromJson(element.data(), coffeeModel);
        orderDetailsList.add(orderDetailsModel);
      }
      log(orderDetailsList.toString());
      return right(orderDetailsList);
    } catch (e) {
      return left(e.toString());
    }
  }

  static Future<Either<String, List<OfferModel>>> getVouchers() async {
    try {
      final offers =
          await _firestore.collection('offers').get().then((value) => value.docs
              .map(
                (e) => OfferModel.fromJson(e.data()),
              )
              .toList());
      log(offers.toString());
      return right(offers);
    } catch (e) {
      return left(e.toString());
    }
  }
}
