import 'dart:developer';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_app/features/buying/models/order_details_model.dart';
import 'package:coffee_app/features/home/models/coffee_model.dart';
import 'package:coffee_app/features/home/models/offer_model.dart';
import 'package:coffee_app/features/home/models/shop_model.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/review_model.dart';

class ShopDetailsService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static Future<Either<String, ShopModel>> getShopDetails(String shopId) async {
    try {
      return await _firestore
          .collection('shops')
          .doc(shopId)
          .get()
          .then((value) {
        ShopModel shopModel = ShopModel.fromJson(value.data()!);
        return right(shopModel);
      });
    } catch (e) {
      return left(e.toString());
    }
  }

  static Future<bool> getFavoriteStatus(String shopId) async {
    return await _firestore
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("favorite-coffee")
        .doc(shopId)
        .get()
        .then((value) => value.exists);
  }

  static Future<Either<String, List<CoffeeModel>>> getProducts(
      String shopId) async {
    try {
      return await _firestore
          .collection('products')
          .where("shop-id", isEqualTo: shopId)
          .get()
          .then((value) {
        final productsList =
            value.docs.map((e) => CoffeeModel.fromJson(e.data())).toList();
        return right(productsList);
      });
    } catch (e) {
      return left(e.toString());
    }
  }

  static Future<void> removeBasket(String id, String shopID) async {
    try {
      await _firestore
          .collection('shops')
          .doc(shopID)
          .collection("basket")
          .doc(id)
          .delete();
    } catch (e) {
      rethrow;
    }
  }

  static Future<Either<String, List<BasketProductModel>>> getBasket(
      String shopId) async {
    try {
      final response = await _firestore
          .collection('shops')
          .doc(shopId)
          .collection("basket")
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
      log(orderDetailsList.toString());
      return right(orderDetailsList);
    } catch (e) {
      return left(e.toString());
    }
  }

  static Future<void> addFavoriteList(ShopModel shopModel) async {
    try {
      await _firestore
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("favorite-coffee")
          .doc(shopModel.id)
          .set(shopModel.map);
    } catch (e) {}
  }

  static Future<void> removeFavoriteList(ShopModel shopModel) async {
    try {
      await _firestore
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("favorite-coffee")
          .doc(shopModel.id)
          .delete();
    } catch (e) {}
  }

  static Future<void> AddBasket(BasketProductModel orderModel) async {
    try {
      await _firestore
          .collection('shops')
          .doc(orderModel.shopID)
          .collection("basket")
          .doc(orderModel.productModel.id)
          .set(orderModel.map);
    } catch (e) {
      rethrow;
    }
  }

  static Future<Either<String, List<ReviewModel>>> getReviews(
      String shopId) async {
    try {
      return await _firestore
          .collection('reviews')
          .where("shop-id", isEqualTo: shopId)
          .get()
          .then((value) {
        final reviewsList =
            value.docs.map((e) => ReviewModel.fromJson(e.data())).toList();
        return right(reviewsList);
      });
    } catch (e) {
      return left(e.toString());
    }
  }

  static Future<Either<String, List<OfferModel>>> getOffers(
      String shopid) async {
    try {
      final response = await _firestore
          .collection("shops")
          .doc(shopid)
          .collection("offers")
          .get()
          .then((value) =>
              value.docs.map((e) => OfferModel.fromJson(e.data())).toList());
      return right(response);
    } catch (e) {
      return left(e.toString());
    }
  }

  static void addOffers(String shopid) {
    List<Map<String, dynamic>> offers = [
      {
        "offer": 50,
        "image": "",
        "terms-condition": [
          "Promotion Period: The FlipShop 50% discount promotion is valid from February 1, 2025, to February 14, 2025. All eligible orders must be placed within this period to avail of the discount.",
          "Eligibility: The promotion is valid for orders above \$10 only and is open to all registered customers."
        ],
        "code": "SAVE50NOW",
        "isBanner": false,
        "subtitle":
            "Celebrate love and savings! Grab a massive 50% discount on all items during our Valentine's Sale!",
        "min-price": 10.0,
        "valid-date": "14-02-2025",
        "title": "50% Off - Valentine's Special!"
      },
      {
        "offer": 40,
        "image": "",
        "terms-condition": [
          "Promotion Period: The FlipShop 40% discount is valid from March 1, 2025, to March 10, 2025. Orders must be placed within this period.",
          "Eligibility: The discount applies to orders over \$15. Available for all customers."
        ],
        "code": "MARCH40DEAL",
        "isBanner": false,
        "subtitle":
            "March into savings! Enjoy 40% off on your favorite products.",
        "min-price": 15.0,
        "valid-date": "10-03-2025",
        "title": "40% Off - March Deal!"
      },
      {
        "offer": 25,
        "image": "",
        "terms-condition": [
          "Promotion Period: The FlipShop 25% discount promotion is valid from April 1, 2025, to April 7, 2025. Orders must be placed within this time frame.",
          "Eligibility: Discount available for orders above \$20. Open to all customers."
        ],
        "code": "APRIL25OFF",
        "isBanner": false,
        "subtitle":
            "Spring into action! Grab 25% off on your purchases this April.",
        "min-price": 20.0,
        "valid-date": "07-04-2025",
        "title": "25% Off - Spring Special!"
      },
      {
        "offer": 60,
        "image":
            "https://firebasestorage.googleapis.com/v0/b/flipshopdata.appspot.com/o/banners%2F0x300a0a0.png?alt=media&token=12271655-f998-4f1f-b1d0-0498fe069c6c",
        "terms-condition": [
          "Promotion Period: The FlipShop 60% discount promotion is valid from May 10, 2025, to May 15, 2025. Orders must be placed during this period.",
          "Eligibility: The discount is applicable for orders exceeding \$30. Open to all users."
        ],
        "code": "MAY60SALE",
        "isBanner": false,
        "subtitle":
            "Massive 60% discount for one week only! Don't miss out on our May Sale.",
        "min-price": 30.0,
        "valid-date": "15-05-2025",
        "title": "60% Off - May Mega Sale!"
      }
    ];

    for (var element in offers) {
      _firestore
          .collection("shops")
          .doc(shopid)
          .collection("offers")
          .add(element);
    }
  }

  static Future<void> addReview() async {
    List<Map<String, dynamic>> initReview = [
      {
        "image":
            "https://firebasestorage.googleapis.com/v0/b/flipshopdata.appspot.com/o/profile%2Fistockphoto-1347005975-612x612.jpg?alt=media&token=90a60edd-a483-44c2-ad95-b6349a8b642c",
        "username": "AvaRoberts",
        "rating": 4.5,
        "date": "2025-01-23",
        "shop-id": "1737348240198464",
        "review":
            "Great experience! The items arrived quickly, and they were exactly as described. Will definitely shop here again."
      },
      {
        "image": "",
        "username": "OliverMartinez",
        "rating": 3.8,
        "date": "2025-01-22",
        "shop-id": "1737348240198464",
        "review":
            "The products were good, but one of my items was slightly damaged during shipping."
      },
      {
        "image":
            "https://firebasestorage.googleapis.com/v0/b/flipshopdata.appspot.com/o/profile%2Fistockphoto-1485052530-612x612.jpg?alt=media&token=16f25189-d1e5-4396-8770-1d5b617b67cd",
        "username": "MiaHernandez",
        "rating": 5.0,
        "date": "2025-01-21",
        "shop-id": "1737348240198464",
        "review":
            "I’m in love with my purchase! The quality is top-notch, and the customer service was exceptional."
      },
      {
        "username": "LucasGreen",
        "rating": 2.5,
        "date": "2025-01-20",
        "shop-id": "1737348240198464",
        "review":
            "Had a hard time getting the right size. The website could use better filtering options."
      },
      {
        "username": "SophiaBennett",
        "rating": 4.2,
        "date": "2025-01-19",
        "shop-id": "1737348240198464",
        "review": "Good service, but the delivery was delayed by two days."
      },
      {
        "image":
            "https://firebasestorage.googleapis.com/v0/b/flipshopdata.appspot.com/o/profile%2Fistockphoto-155125905-612x612.jpg?alt=media&token=991681e5-1f78-4e6c-9457-9b1cc2bcc774",
        "username": "JacksonPerez",
        "rating": 4.8,
        "date": "2025-01-18",
        "shop-id": "1737348240198464",
        "review":
            "Perfect purchase! Everything arrived well-packaged, and the quality was even better than expected."
      }
    ];

    const shopId = "1737348240198464";
    final shopReviews = initReview;

    double totalRating = 0.0;

    for (var review in shopReviews) {
      totalRating += review["rating"];

      await _firestore.collection('reviews').add(review).then((value) async {
        await _firestore.collection("shops").doc(review["shop-id"]).update({
          "reviews": FieldValue.arrayUnion([value.id]),
        });
      });
    }

    final averageRating = totalRating / shopReviews.length;

    await _firestore.collection("shops").doc(shopId).update({
      "rating": averageRating,
    });
  }
}
