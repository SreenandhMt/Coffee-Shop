import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_app/features/home/models/offer_model.dart';
import 'package:coffee_app/features/home/models/shop_model.dart';
import 'package:dartz/dartz.dart';

import '../models/coffee_model.dart';

class HomeService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static Future<Either<String, List<ShopModel>>> getNearbyShops() async {
    try {
      return await _firestore.collection('shops').limit(8).get().then((value) {
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

  static Future<Either<String, List<CoffeeModel>>> getPopularMenu() async {
    try {
      return await _firestore
          .collection('products')
          .where("rating", isGreaterThan: 3)
          .limit(6)
          .get()
          .then((value) {
        List<CoffeeModel> shops = [];
        for (var element in value.docs) {
          shops.add(CoffeeModel.fromJson(element.data()));
        }
        return right(shops);
      });
    } catch (e) {
      return left(e.toString());
    }
  }

  static Future<Either<String, List<OfferModel>>> getBanners() async {
    try {
      return await _firestore
          .collection('offers')
          .where("isBanner", isEqualTo: true)
          .get()
          .then((value) {
        final offers =
            value.docs.map((e) => OfferModel.fromJson(e.data())).toList();
        return right(offers);
      });
    } catch (e) {
      return left(e.toString());
    }
  }
}
