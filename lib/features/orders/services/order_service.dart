import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_app/features/buying/models/order_details_model.dart';
import 'package:coffee_app/features/home/models/shop_model.dart';
import 'package:coffee_app/features/orders/models/order_model.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../home/models/coffee_model.dart';

class OrderService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static DocumentSnapshot? _lastDocument;
  static bool activeOrderHasData = true;
  static Future<Either<String, List<OrderModel>>> getActiveOrderModels() async {
    try {
      final user = _auth.currentUser!;
      return _firestore
          .collection("orders")
          .where("user-id", isEqualTo: user.uid)
          .where("status", isEqualTo: "Conformed")
          .limit(10)
          .orderBy("order", descending: true)
          .get()
          .then((value) async {
        if (value.docs.isNotEmpty) {
          _lastDocument = value.docs.last;
          activeOrderHasData = true;
        } else {
          activeOrderHasData = false;
        }
        List<OrderModel> orders = [];
        for (var element in value.docs) {
          final orderDetails =
              await _getBasketModel(element.data()["order-details"]);
          orders.add(OrderModel.fromJson(element.data(), orderDetails));
        }
        return right(orders);
      });
    } catch (e) {
      return left(e.toString());
    }
  }

  static Future<Either<String, List<OrderModel>>> loadMoreActiveData() async {
    try {
      if (!activeOrderHasData) {
        return left("Data done");
      }
      final user = _auth.currentUser!;
      if (_lastDocument != null) {
        return _firestore
            .collection("orders")
            .where("user-id", isEqualTo: user.uid)
            .where("status", isEqualTo: "Conformed")
            .startAfterDocument(_lastDocument!)
            .limit(10)
            .get()
            .then((value) async {
          if (value.docs.isNotEmpty) {
            _lastDocument = value.docs.last;
          } else {
            activeOrderHasData = false;
          }
          List<OrderModel> orders = [];
          for (var element in value.docs) {
            final orderDetails =
                await _getBasketModel(element.data()["order-details"]);
            orders.add(OrderModel.fromJson(element.data(), orderDetails));
          }
          return right(orders);
        });
      }
      return left("No data found");
    } catch (e) {
      return left(e.toString());
    }
  }

  static Future<Either<String, List<OrderModel>>>
      getCompletedOrderModels() async {
    try {
      final user = _auth.currentUser!;
      return _firestore
          .collection("orders")
          .where("user-id", isEqualTo: user.uid)
          .where("status", isEqualTo: "completed")
          .limit(10)
          .get()
          .then((value) async {
        List<OrderModel> orders = [];
        for (var element in value.docs) {
          final orderDetails =
              await _getBasketModel(element.data()["order-details"]);
          orders.add(OrderModel.fromJson(element.data(), orderDetails));
        }
        return right(orders);
      });
    } catch (e) {
      return left(e.toString());
    }
  }

  static Future<Either<String, List<OrderModel>>>
      getCanceledOrderModels() async {
    try {
      final user = _auth.currentUser!;
      return _firestore
          .collection("orders")
          .where("user-id", isEqualTo: user.uid)
          .where("status", isEqualTo: "canceled")
          .limit(10)
          .get()
          .then((value) async {
        List<OrderModel> orders = [];
        for (var element in value.docs) {
          final orderDetails =
              await _getBasketModel(element.data()["order-details"]);
          orders.add(OrderModel.fromJson(element.data(), orderDetails));
        }
        return right(orders);
      });
    } catch (e) {
      return left(e.toString());
    }
  }

  static Future<void> rateAndReviewShop(
      double rating, String review, String shopId) async {
    final user = FirebaseAuth.instance.currentUser!;
    final response = await _firestore
        .collection("shops")
        .doc(shopId)
        .get()
        .then((value) => value.data()!);

    final updateRating = _updateRating(response["rating"].toDouble(),
        (int.tryParse(response["rate-count"].toString()) ?? 0), rating);

    await _firestore.collection("shops").doc(shopId).update({
      "rating": updateRating,
      "all-rating": FieldValue.arrayUnion([rating]),
      "rate-count": ((int.tryParse(response["rate-count"].toString()) ?? 0) + 1)
    });
    if (review.isEmpty) return;
    await _firestore.collection("reviews").doc().set({
      "rating": rating,
      "review": review,
      "user-id": user.uid,
      "shop-id": shopId,
      "date": DateTime.now().toString(),
      "order": DateTime.now().millisecondsSinceEpoch,
      "username": user.displayName,
      "image": user.photoURL
    });
  }

  static Future<Either<String, ShopModel>> getShopModelById(String id) async {
    try {
      return _firestore.collection("shops").doc(id).get().then((value) async {
        final orderModel = ShopModel.fromJson(value.data()!);
        return right(orderModel);
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

  static double _updateRating(
      double currentAverage, int totalRatings, double newRating) {
    return ((currentAverage * totalRatings) + newRating) / (totalRatings + 1);
  }

  static Future<Either<String, bool>> cancelOrder(List<String> orderIds) async {
    try {
      for (var orderId in orderIds) {
        await _firestore.collection("orders").doc(orderId).update({
          "status": "canceled",
        });
      }
      return right(true);
    } catch (e) {
      return left(e.toString());
    }
  }
}
