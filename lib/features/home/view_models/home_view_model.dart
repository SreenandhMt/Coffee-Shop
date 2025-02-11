import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:coffee_app/features/home/models/shop_model.dart';
import 'package:coffee_app/features/home/service/home_service.dart';

import '../models/coffee_model.dart';
import '../models/offer_model.dart';

part 'home_view_model.g.dart';

class HomeStateModel {
  final bool loading;
  final List<CoffeeModel> popularCoffees;
  final List<ShopModel> nearbyShops;
  final List<OfferModel> banners;
  final OfferModel? selectedBanner;

  HomeStateModel({
    required this.loading,
    required this.popularCoffees,
    required this.nearbyShops,
    required this.banners,
    this.selectedBanner,
  });

  factory HomeStateModel.initial() {
    return HomeStateModel(
        loading: true, popularCoffees: [], nearbyShops: [], banners: []);
  }

  HomeStateModel copyWith({
    bool? loading,
    List<CoffeeModel>? popularCoffees,
    List<ShopModel>? nearbyShops,
    List<OfferModel>? banners,
    OfferModel? selectedBanner,
  }) {
    return HomeStateModel(
      loading: loading ?? this.loading,
      popularCoffees: popularCoffees ?? this.popularCoffees,
      nearbyShops: nearbyShops ?? this.nearbyShops,
      banners: banners ?? this.banners,
      selectedBanner: selectedBanner ?? this.selectedBanner,
    );
  }
}

@riverpod
class HomeViewModel extends _$HomeViewModel {
  @override
  HomeStateModel build() {
    return HomeStateModel.initial();
  }

  Future<void> getAllData({bool isLoading = true}) async {
    state = state.copyWith(loading: isLoading);
    getNearbyShops();
    getPopularCoffees();
    getBanners();
    await Future.delayed(const Duration(seconds: 1));
    state = state.copyWith(loading: false);
  }

  Future<void> getNearbyShops() async {
    final response = await HomeService.getNearbyShops();
    response.fold((left) {}, (right) {
      final List<ShopModel> shops = [];
      for (var shop in right) {
        shops.add(shop);
      }
      state = state.copyWith(nearbyShops: shops);
    });
  }

  void getBanners() async {
    final response = await HomeService.getBanners();
    response.fold((left) {}, (right) {
      state = state.copyWith(banners: right);
    });
  }

  void selectBanner(OfferModel offer) async {
    state = state.copyWith(selectedBanner: offer);
  }

  Future<void> getPopularCoffees() async {
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
                "name": "Whole Milk",
                "price": "0.50",
              },
              {
                "name": "Skim Milk",
                "price": "0.30",
              },
              {
                "name": "Soya Milk",
                "price": "0.30",
              },
              {
                "name": "Almond Milk",
                "price": "0.30",
              },
            ]
          },
          {
            "name": "Syrup",
            "options": [
              {
                "name": "Aren",
                "price": "1.00",
              },
              {
                "name": "Caramel",
                "price": "0.90",
              },
              {
                "name": "Hazelnut",
                "price": "1.00",
              },
              {
                "name": "Pecan",
                "price": "1.00",
              },
              {
                "name": "Manuka Honey",
                "price": "0.50",
              },
              {
                "name": "Vanilla",
                "price": "1.00",
              },
            ]
          },
          {
            "name": "Toppings",
            "options": [
              {
                "name": "Cinnamon",
                "price": "0.50",
              },
              {
                "name": "Nutmeg",
                "price": "0.40",
              },
              {
                "name": "Cocoa Powder",
                "price": "0.30",
              },
              {
                "name": "Crumble",
                "price": "0.35",
              },
              {
                "name": "Sa Salt Cream",
                "price": "0.50",
              },
              {
                "name": "Milo Powder",
                "price": "0.50",
              },
              {
                "name": "Caramel Sauce",
                "price": "0.30",
              },
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
                "name": "Whole Milk",
                "price": "0.50",
              },
              {
                "name": "Skim Milk",
                "price": "0.30",
              },
              {
                "name": "Soya Milk",
                "price": "0.30",
              },
              {
                "name": "Almond Milk",
                "price": "0.30",
              },
            ]
          },
          {
            "name": "Syrup",
            "options": [
              {
                "name": "Aren",
                "price": "1.00",
              },
              {
                "name": "Caramel",
                "price": "0.90",
              },
              {
                "name": "Hazelnut",
                "price": "1.00",
              },
              {
                "name": "Pecan",
                "price": "1.00",
              },
              {
                "name": "Manuka Honey",
                "price": "0.50",
              },
              {
                "name": "Vanilla",
                "price": "1.00",
              },
            ]
          },
          {
            "name": "Toppings",
            "options": [
              {
                "name": "Cinnamon",
                "price": "0.50",
              },
              {
                "name": "Nutmeg",
                "price": "0.40",
              },
              {
                "name": "Cocoa Powder",
                "price": "0.30",
              },
              {
                "name": "Crumble",
                "price": "0.35",
              },
              {
                "name": "Sa Salt Cream",
                "price": "0.50",
              },
              {
                "name": "Milo Powder",
                "price": "0.50",
              },
              {
                "name": "Caramel Sauce",
                "price": "0.30",
              },
            ]
          }
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
                "name": "Whole Milk",
                "price": "0.50",
              },
              {
                "name": "Skim Milk",
                "price": "0.30",
              },
              {
                "name": "Soya Milk",
                "price": "0.30",
              },
              {
                "name": "Almond Milk",
                "price": "0.30",
              },
            ]
          },
          {
            "name": "Syrup",
            "options": [
              {
                "name": "Aren",
                "price": "1.00",
              },
              {
                "name": "Caramel",
                "price": "0.90",
              },
              {
                "name": "Hazelnut",
                "price": "1.00",
              },
              {
                "name": "Pecan",
                "price": "1.00",
              },
              {
                "name": "Manuka Honey",
                "price": "0.50",
              },
              {
                "name": "Vanilla",
                "price": "1.00",
              },
            ]
          },
          {
            "name": "Toppings",
            "options": [
              {
                "name": "Cinnamon",
                "price": "0.50",
              },
              {
                "name": "Nutmeg",
                "price": "0.40",
              },
              {
                "name": "Cocoa Powder",
                "price": "0.30",
              },
              {
                "name": "Crumble",
                "price": "0.35",
              },
              {
                "name": "Sa Salt Cream",
                "price": "0.50",
              },
              {
                "name": "Milo Powder",
                "price": "0.50",
              },
              {
                "name": "Caramel Sauce",
                "price": "0.30",
              },
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
                "name": "Whole Milk",
                "price": "0.50",
              },
              {
                "name": "Skim Milk",
                "price": "0.30",
              },
              {
                "name": "Soya Milk",
                "price": "0.40",
              },
              {
                "name": "Almond Milk",
                "price": "1.00",
              },
            ]
          },
          {
            "name": "Syrup",
            "options": [
              {
                "name": "Aren",
                "price": "1.00",
              },
              {
                "name": "Caramel",
                "price": "0.90",
              },
              {
                "name": "Hazelnut",
                "price": "1.00",
              },
              {
                "name": "Pecan",
                "price": "0.50",
              },
              {
                "name": "Manuka Honey",
                "price": "0.50",
              },
              {
                "name": "Vanilla",
                "price": "1.00",
              },
            ]
          },
          {
            "name": "Toppings",
            "options": [
              {
                "name": "Cinnamon",
                "price": "0.50",
              },
              {
                "name": "Nutmeg",
                "price": "0.40",
              },
              {
                "name": "Cocoa Powder",
                "price": "0.30",
              },
              {
                "name": "Crumble",
                "price": "0.35",
              },
              {
                "name": "Sa Salt Cream",
                "price": "0.50",
              },
              {
                "name": "Milo Powder",
                "price": "0.50",
              },
              {
                "name": "Caramel Sauce",
                "price": "0.30",
              },
            ]
          }
        ]
      }
    ];
    final response = await HomeService.getPopularMenu();
    response.fold((l) => debugPrint(l), (r) {
      state = state.copyWith(popularCoffees: r);
    });
    // final popularCoffeeList = productFullData;
    // final List<CoffeeModel> popularCoffees = [];
    // for (var coffee in popularCoffeeList) {
    //   // final id = DateTime.now().microsecondsSinceEpoch.toString();
    //   // coffee["shop-id"] = "1737348240198464";
    //   // coffee["id"] = id;
    //   // FirebaseFirestore.instance.collection("products").doc(id).set(coffee);
    //   popularCoffees.add(CoffeeModel.fromJson(coffee));
    // }
    // state = state.copyWith(popularCoffees: popularCoffees);
  }
}
