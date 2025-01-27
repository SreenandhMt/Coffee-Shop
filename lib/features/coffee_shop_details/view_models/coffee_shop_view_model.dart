import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:coffee_app/features/buying/models/order_details_model.dart';
import 'package:coffee_app/features/coffee_shop_details/service/shop_details_service.dart';
import 'package:coffee_app/features/home/models/offer_model.dart';
import 'package:coffee_app/features/home/models/shop_model.dart';

import '../../home/models/coffee_model.dart';
import '../models/review_model.dart';

part 'coffee_shop_view_model.g.dart';

class ShopStateModel {
  final bool isLoading;
  final List<CoffeeModel>? coffeeModel;
  final ShopModel? shopModel;
  final List<BasketProductModel> selectedCoffeeIds;
  final double totalPrice;
  final List<ReviewModel>? sortedReview;
  final List<ReviewModel>? reviews;
  final List<OfferModel>? offers;
  final List<OfferModel>? selectedOffers;
  final double? selectedFilter;

  ShopStateModel({
    required this.isLoading,
    this.coffeeModel,
    this.shopModel,
    required this.selectedCoffeeIds,
    required this.totalPrice,
    this.sortedReview,
    this.reviews,
    this.offers,
    this.selectedOffers,
    this.selectedFilter,
  });

  factory ShopStateModel.initial() {
    return ShopStateModel(
        isLoading: false, selectedCoffeeIds: [], totalPrice: 0.0);
  }

  ShopStateModel copyWith({
    bool? isLoading,
    List<CoffeeModel>? coffeeModel,
    ShopModel? shopModel,
    List<BasketProductModel>? selectedCoffeeIds,
    double? totalPrice,
    List<ReviewModel>? reviews,
    List<ReviewModel>? sortedReview,
    double? selectedFilter,
    List<OfferModel>? offers,
    List<OfferModel>? selectedOffers,
  }) {
    return ShopStateModel(
        isLoading: isLoading ?? this.isLoading,
        coffeeModel: coffeeModel ?? this.coffeeModel,
        shopModel: shopModel ?? this.shopModel,
        selectedCoffeeIds: selectedCoffeeIds ?? this.selectedCoffeeIds,
        totalPrice: totalPrice ?? this.totalPrice,
        reviews: reviews ?? this.reviews,
        sortedReview: sortedReview ?? this.sortedReview,
        selectedFilter: selectedFilter ?? this.selectedFilter,
        offers: offers ?? this.offers,
        selectedOffers: selectedOffers ?? this.selectedOffers);
  }
}

@riverpod
class ShopDetailsViewModel extends _$ShopDetailsViewModel {
  @override
  ShopStateModel build() {
    return ShopStateModel.initial();
  }

  void getBasket(String shopId) async {
    // await ShopDetailsService.addReview();
    final response = await ShopDetailsService.getBasket(shopId);
    response.fold((l) => log(l), (r) {
      double totalPrice = 0;
      for (var element in r) {
        totalPrice += element.totalPrice;
      }
      state = state.copyWith(selectedCoffeeIds: r, totalPrice: totalPrice);
    });
  }

  void removeProductID(BasketProductModel orderModel) {
    ShopDetailsService.removeBasket(
        orderModel.productModel.id, orderModel.shopID);
    state = state.copyWith(
        selectedCoffeeIds: [...state.selectedCoffeeIds..remove(orderModel)],
        totalPrice: double.parse(
            (state.totalPrice - orderModel.totalPrice).toStringAsFixed(3)));
  }

  void addProductID(BasketProductModel orderModel) {
    ShopDetailsService.AddBasket(orderModel);
    state = state.copyWith(
        selectedCoffeeIds: [...state.selectedCoffeeIds, orderModel],
        totalPrice: (state.totalPrice + orderModel.totalPrice));
  }

  void clearValues() {
    state = ShopStateModel.initial();
  }

  void getAllData(String shopId) {
    state = state.copyWith(isLoading: true);
    getShopDetails(shopId);
    getBasket(shopId);
    getReviews(shopId);
    // ShopDetailsService.addOffers(shopId);
    getOffers(shopId);
    state = state.copyWith(isLoading: false);
  }

  void claimOffer(OfferModel offer) {
    if (state.selectedOffers == null ||
        !state.selectedOffers!.contains(offer)) {
      state = state
          .copyWith(selectedOffers: [...state.selectedOffers ?? [], offer]);
    } else {
      state = state.copyWith(
        selectedOffers:
            state.selectedOffers!.where((element) => element != offer).toList(),
      );
    }
  }

  void getOffers(String shopid) async {
    final response = await ShopDetailsService.getOffers(shopid);
    response.fold((l) => log(l), (r) => state = state.copyWith(offers: r));
  }

  void getReviews(String shopid) async {
    final response = await ShopDetailsService.getReviews(shopid);
    response.fold((l) => log(l),
        (r) => state = state.copyWith(reviews: r, sortedReview: r));
  }

  void reviewSort(double rating) {
    List<ReviewModel> sortedReview = [];
    final review = state.reviews;
    for (var element in review!) {
      if (element.rating >= rating && element.rating < rating + 1) {
        log(element.rating.toString());
        sortedReview.add(element);
      }
    }
    state = state.copyWith(sortedReview: sortedReview, selectedFilter: rating);
  }

  void clearFilter() {
    state = state.copyWith(sortedReview: state.reviews, selectedFilter: 10);
  }

  Future<void> getShopDetails(String shopId) async {
    final images = [
      "https://firebasestorage.googleapis.com/v0/b/flipshopdata.appspot.com/o/products%2Fimage1.png?alt=media&token=be657265-9a71-4fde-82bd-af6f48e17bce",
      "https://firebasestorage.googleapis.com/v0/b/flipshopdata.appspot.com/o/products%2Fimage2.png?alt=media&token=e39eedac-0ba6-494d-9f0e-3b04f7a9a653",
      "https://firebasestorage.googleapis.com/v0/b/flipshopdata.appspot.com/o/products%2Fimage3.png?alt=media&token=302c21e3-ae3b-4a13-beee-5a2e9a6e5d60",
      "https://firebasestorage.googleapis.com/v0/b/flipshopdata.appspot.com/o/products%2Fimage4.png?alt=media&token=b61f4334-1da6-4cfe-bd7e-751c17c96acf",
      "https://firebasestorage.googleapis.com/v0/b/flipshopdata.appspot.com/o/products%2Fimage5.png?alt=media&token=6de1f9b7-2090-461e-b6c4-6411005de00d",
      "https://firebasestorage.googleapis.com/v0/b/flipshopdata.appspot.com/o/products%2Fimage6.png?alt=media&token=f1c0c965-4b11-4fc2-8b42-1d5a3bcbda8a",
    ];
    final productFullData = [
      {
        "name": "Classic Brew",
        "price": "3.50",
        "image-url": images[0],
        "id": "111",
        "shop-id": "11",
        "Type": "Coffee",
        "custom-size": true,
        "custom-coffee": true,
        "options": [
          {
            "name": "Milk",
            "options": [
              {
                "name": "Almond Milk",
                "price": "0.50",
                "id": "111",
              },
              {
                "name": "Soya Milk",
                "price": "0.30",
                "id": "111",
              }
            ]
          },
          {
            "name": "Toppings",
            "options": [
              {
                "name": "Cinnamon",
                "price": "0.10",
                "id": "111",
              },
              {
                "name": "Cocoa Powder",
                "price": "0.30",
                "id": "111",
              }
            ]
          }
        ]
      },
      {
        "name": "Minty Fresh Brew",
        "price": "4.30",
        "image-url": images[1],
        "id": "222",
        "shop-id": "11",
        "Type": "Coffee",
        "custom-size": true,
        "custom-coffee": true,
        "options": [
          {
            "name": "Milk",
            "options": [
              {
                "name": "Almond Milk",
                "price": "0.50",
                "id": "111",
              },
              {
                "name": "Soya Milk",
                "price": "0.30",
                "id": "111",
              }
            ]
          },
          {
            "name": "Toppings",
            "options": [
              {
                "name": "Cinnamon",
                "price": "0.10",
                "id": "111",
              },
              {
                "name": "Cocoa Powder",
                "price": "0.30",
                "id": "111",
              }
            ]
          }
        ]
      },
      {
        "name": "Sunshine Brew",
        "price": "5.50",
        "image-url": images[2],
        "id": "333",
        "shop-id": "11",
        "Type": "Coffee",
        "custom-size": true,
        "custom-coffee": true,
        "options": [
          {
            "name": "Milk",
            "options": [
              {
                "name": "Almond Milk",
                "price": "0.50",
                "id": "111",
              },
              {
                "name": "Soya Milk",
                "price": "0.30",
                "id": "111",
              }
            ]
          },
          {
            "name": "Toppings",
            "options": [
              {
                "name": "Cinnamon",
                "price": "0.10",
                "id": "111",
              },
              {
                "name": "Cocoa Powder",
                "price": "0.30",
                "id": "111",
              }
            ]
          },
        ]
      },
      {
        "name": "Blueberry Brew",
        "price": "4.00",
        "image-url": images[3],
        "id": "444",
        "shop-id": "11",
        "Type": "Coffee",
        "custom-size": true,
        "custom-coffee": true,
        "options": [
          {
            "name": "Milk",
            "options": [
              {
                "name": "Almond Milk",
                "price": "0.50",
                "id": "111",
              },
              {
                "name": "Soya Milk",
                "price": "0.30",
                "id": "111",
              }
            ]
          },
          {
            "name": "Toppings",
            "options": [
              {
                "name": "Cinnamon",
                "price": "0.10",
                "id": "111",
              },
              {
                "name": "Cocoa Powder",
                "price": "0.30",
                "id": "111",
              }
            ]
          }
        ]
      },
      {
        "name": "Choco Brew",
        "price": "5.50",
        "image-url": images[4],
        "id": "555",
        "shop-id": "11",
        "Type": "Coffee",
        "custom-size": true,
        "custom-coffee": true,
        "options": [
          {
            "name": "Milk",
            "options": [
              {
                "name": "Almond Milk",
                "price": "0.50",
                "id": "111",
              },
              {
                "name": "Soya Milk",
                "price": "0.30",
                "id": "111",
              }
            ]
          },
          {
            "name": "Toppings",
            "options": [
              {
                "name": "Cinnamon",
                "price": "0.10",
                "id": "111",
              },
              {
                "name": "Cocoa Powder",
                "price": "0.30",
                "id": "111",
              }
            ]
          }
        ]
      },
      {
        "name": "Vanilla Brew",
        "price": "6.00",
        "image-url": images[5],
        "id": "666",
        "shop-id": "11",
        "Type": "Coffee",
        "custom-size": true,
        "custom-coffee": true,
        "options": [
          {
            "name": "Milk",
            "options": [
              {
                "name": "Almond Milk",
                "price": "0.50",
                "id": "111",
              },
              {
                "name": "Soya Milk",
                "price": "0.30",
                "id": "111",
              }
            ]
          },
          {
            "name": "Toppings",
            "options": [
              {
                "name": "Cinnamon",
                "price": "0.10",
                "id": "111",
              },
              {
                "name": "Cocoa Powder",
                "price": "0.30",
                "id": "111",
              }
            ]
          }
        ]
      }
    ];
    final response = await ShopDetailsService.getShopDetails(shopId);
    response.fold((left) {
      log(left);
    }, (right) {
      state = state.copyWith(shopModel: right);
    });
    final productResponse = await ShopDetailsService.getProducts(shopId);
    productResponse.fold((left) {
      log(left);
    }, (right) {
      state = state.copyWith(coffeeModel: right);
    });
    // final coffeeModels =
    //     productFullData.map((e) => CoffeeModel.fromJson(e)).toList();
    // state = state.copyWith(coffeeModel: coffeeModels, isLoading: false);
  }
}
