import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_app/features/home/models/coffee_model.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  static Future<void> addToFavorite(CoffeeModel coffeeModel) async {
    await _firestore
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("favorite")
        .doc(coffeeModel.id)
        .set(coffeeModel.map);
  }

  static Future<void> removeToFavorite(CoffeeModel coffeeModel) async {
    await _firestore
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("favorite")
        .doc(coffeeModel.id)
        .delete();
  }

  static Future<bool> getFavoriteStatus(String id) async {
    return await _firestore
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("favorite")
        .doc(id)
        .get()
        .then((value) => value.exists);
  }
}
