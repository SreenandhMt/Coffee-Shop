import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_app/features/home/models/shop_model.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CoffeeShopsService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<Either<String, List<ShopModel>>> getAllShops() async {
    try {
      return await _firestore.collection("shops").get().then((value) {
        List<ShopModel> shops = [];
        for (var element in value.docs) {
          shops.add(ShopModel.fromJson(element.data()));
        }
        return right(shops);
      });
    } catch (e) {
      return left(e.toString());
    }
  }

  static Future<Either<String, List<ShopModel>>>
      getFavoriteCoffeeShops() async {
    try {
      final favoriteShops = await _firestore
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("favorite-coffee")
          .get()
          .then(
            (value) => value.docs
                .map(
                  (e) => ShopModel.fromJson(e.data()),
                )
                .toList(),
          );
      return right(favoriteShops);
    } catch (e) {
      return left(e.toString());
    }
  }
}
