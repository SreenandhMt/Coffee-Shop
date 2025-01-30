import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_app/features/buying/models/order_details_model.dart';
import 'package:coffee_app/features/orders/models/order_model.dart';
import 'package:dartz/dartz.dart';

import '../../home/models/coffee_model.dart';

class OrderService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static Future<Either<String, List<OrderModel>>> getOrderModels() async {
    try {
      return _firestore.collection("orders").get().then((value) async {
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

  static Future<Either<String, OrderModel>> getOrderModelById(String id) async {
    try {
      return _firestore.collection("orders").doc(id).get().then((value) async {
        final orderDetails =
            await _getBasketModel(value.data()!["order-details"]);
        final orderModel = OrderModel.fromJson(value.data()!, orderDetails);
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
}
