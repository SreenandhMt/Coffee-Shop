import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_app/features/home/models/shop_model.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

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

  static Future<String> getCurrentAddress() async {
    try {
      await Geolocator.requestPermission()
          .then((value) {})
          .onError((error, stackTrace) async {
        await Geolocator.requestPermission();
        log("ERROR$error");
      });
      final position = await Geolocator.getCurrentPosition();
      List<Placemark> placeMarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      return placeMarks.first.locality!;
    } catch (e) {
      log(e.toString());
      return "New York";
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
