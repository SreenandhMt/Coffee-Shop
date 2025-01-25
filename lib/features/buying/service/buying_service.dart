import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_app/features/home/models/coffee_model.dart';
import 'package:dartz/dartz.dart';

class BuyingService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static Future<Either<dynamic, CoffeeModel>> getCoffeeDetails(
      String id) async {
    try {
      return await _firestore.collection("products").doc(id).get().then(
        (value) {
          final CoffeeModel coffeeModel = CoffeeModel.fromJson(value.data()!);
          return right(coffeeModel);
        },
      ).onError(
        (error, stackTrace) {
          return left(error.toString());
        },
      );
    } catch (e) {
      return left(e.toString());
    }
  }
}
