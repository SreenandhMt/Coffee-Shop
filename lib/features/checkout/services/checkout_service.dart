import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_app/features/address/models/address_model.dart';
import 'package:coffee_app/features/home/models/coffee_model.dart';
import 'package:coffee_app/features/home/models/offer_model.dart';
import 'package:coffee_app/features/home/models/shop_model.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../buying/models/order_details_model.dart';
import '../../orders/models/order_model.dart';

class CheckoutService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<void> removeCheckout(String id) async {
    try {
      await _firestore.collection('checkouts').doc(id).delete();
    } catch (e) {
      rethrow;
    }
  }

  static Future<Either<String, AddressModel?>> getInitAddress() async {
    try {
      return await _firestore
          .collection("users")
          .doc(_auth.currentUser!.uid)
          .collection("address")
          .where("", isEqualTo: true)
          .get()
          .then(
        (value) {
          if (value.docs.isEmpty) {
            return right(null);
          }
          AddressModel address = AddressModel.fromJson(value.docs.first.data());
          return right(address);
        },
      );
    } catch (e) {
      return left(e.toString());
    }
  }

  static Future<void> deliveryOrderConform({
    required ShopModel shop,
    required BasketProductModel product,
    required List<OfferModel> offers,
    required bool isUsePoint,
    required Map paymentMethod,
    required Map deliveryService,
    required Map address,
    required String id,
  }) async {
    try {
      final fee = deliveryService["price"];
      await _firestore.collection('orders').doc(id).set({
        "id": id,
        "type": "Delivery",
        "status": "Conformed",
        "shop-id": shop.id,
        "shop-name": shop.name,
        "shop-image": shop.images,
        "shop-address": shop.address,
        "product-name": product.productModel.name,
        "product-id": product.productModel.id,
        "product-image": product.productModel.imagePath,
        "user-id": FirebaseAuth.instance.currentUser!.uid,
        "discount": offers.map((e) => e.code).toList(),
        "use-point": isUsePoint,
        "payment-method": paymentMethod,
        "payment-status": "Paid",
        "payment-details": [
          {
            "type": "Grand Subtotal",
            "value": product.totalPrice,
          },
          {
            "type": "Service Fee",
            "value": 1.00,
          },
          {
            "type": "Delivery Fee",
            "value": fee,
          },
          {
            "type": "Discount",
            "value": -1.80,
          },
          {
            "type": "200 Points Used",
            "value": -2.00,
          },
          {
            "type": "Total",
            "value": product.totalPrice,
          }
        ],
        "order-date": DateTime.now(),
        "delivery-service": deliveryService,
        "order-details": product.map,
        "transaction-details": [
          {
            "type": "Amount",
            "value": product.totalPrice,
          },
          {
            "type": "Payment Method",
            "value": paymentMethod["name"],
          },
          {
            "type": "Status",
            "value": "Paid",
          },
          {
            "type": "Date",
            "value": DateTime.now().toString(),
          },
          {
            "type": "Time",
            "value": TimeOfDay.now().toString(),
          },
          {
            "type": "Order ID",
            "value": "ORD596FH",
          },
          {
            "type": "Transaction ID",
            "value": "TRC986768PAY",
          },
          {
            "type": "Reference ID",
            "value": "REF569847RES",
          },
        ],
        "address": address,
      });
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> pickupOrderConform({
    required ShopModel shop,
    required BasketProductModel product,
    required List<OfferModel> offers,
    required bool isUsePoint,
    required Map paymentMethod,
    required id,
  }) async {
    try {
      await _firestore.collection('orders').doc(id).set({
        "id": id,
        "type": "Pickup",
        "pickup-time": "", //TODO: add pickup time here
        "status": "Conformed",
        "shop-id": shop.id,
        "shop-name": shop.name,
        "shop-image": shop.images,
        "shop-address": shop.address,
        "product-name": product.productModel.name,
        "product-id": product.productModel.id,
        "product-image": product.productModel.imagePath,
        "user-id": FirebaseAuth.instance.currentUser!.uid,
        "discount": offers.map((e) => e.code).toList(),
        "use-point": isUsePoint,
        "payment-method": paymentMethod,
        "payment-status": "Paid",
        "payment-details": [
          {
            "type": "Grand Subtotal",
            "value": product.totalPrice,
          },
          {
            "type": "Service Fee",
            "value": 1.00,
          },
          {
            "type": "Discount",
            "value": -1.80,
          },
          {
            "type": "200 Points Used",
            "value": -2.00,
          },
          {
            "type": "Total",
            "value": product.totalPrice,
          }
        ],
        "order-date": DateTime.now(),
        "order-details": product.map,
        "transaction-details": [
          {
            "type": "Amount",
            "value": product.totalPrice,
          },
          {
            "type": "Payment Method",
            "value": paymentMethod["name"],
          },
          {
            "type": "Status",
            "value": "Paid",
          },
          {
            "type": "Date",
            "value": DateTime.now().toString(),
          },
          {
            "type": "Time",
            "value": TimeOfDay.now().toString(),
          },
          {
            "type": "Order ID",
            "value": "ORD596FH",
          },
          {
            "type": "Transaction ID",
            "value": "TRC986768PAY",
          },
          {
            "type": "Reference ID",
            "value": "REF569847RES",
          },
        ],
      });
    } catch (e) {
      rethrow;
    }
  }

  static Future<Either<String, ShopModel>> getShopDetails(String shopId) async {
    try {
      final shop = await _firestore
          .collection('shops')
          .doc(shopId)
          .get()
          .then((value) => ShopModel.fromJson(value.data()!));
      return right(shop);
    } catch (e) {
      return left(e.toString());
    }
  }

  static Future<Either<String, List<BasketProductModel>>> getBasketProducts(
      String shopId) async {
    try {
      final response = await _firestore
          .collection('shops')
          .doc(shopId)
          .collection("basket")
          .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((value) async {
        return value;
      });
      List<BasketProductModel> orderDetailsList = [];
      for (var element in response.docs) {
        final coffeeModel = await _firestore
            .collection('products')
            .doc(element.data()["product-id"])
            .get()
            .then((value) => CoffeeModel.fromJson(value.data()!));
        final basketProductModel =
            BasketProductModel.fromJson(element.data(), coffeeModel);
        orderDetailsList.add(basketProductModel);
      }
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
      return right(offers);
    } catch (e) {
      return left(e.toString());
    }
  }

  static Future<Either<String, OrderModel>> getOrderModels(id) async {
    try {
      return _firestore.collection("orders").doc(id).get().then((value) async {
        final orderDetails =
            await _getBasketModel(value.data()!["order-details"]);
        return right(OrderModel.fromJson(value.data()!, orderDetails));
      });
    } catch (e) {
      return left(e.toString());
    }
  }

  static Future<BasketProductModel> _getBasketModel(value) async {
    final coffeeModel = await _firestore
        .collection('products')
        .doc(value["product-id"])
        .get()
        .then((e) => CoffeeModel.fromJson(e.data()!));
    final basketProductModel = BasketProductModel.fromJson(value, coffeeModel);
    return basketProductModel;
  }
}
