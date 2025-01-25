import 'package:coffee_app/features/home/models/shop_model.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'coffee_shops_view_model.g.dart';

class CoffeeShopsStateModel {
  final bool isLoading;
  final List<ShopModel> coffeeShops;
  final List<ShopModel> favoriteCoffeeShops;

  CoffeeShopsStateModel({
    required this.isLoading,
    required this.coffeeShops,
    required this.favoriteCoffeeShops,
  });

  factory CoffeeShopsStateModel.initial() {
    return CoffeeShopsStateModel(
      isLoading: false,
      coffeeShops: [],
      favoriteCoffeeShops: [],
    );
  }
  CoffeeShopsStateModel copyWith({
    bool? isLoading,
    List<ShopModel>? coffeeShops,
    List<ShopModel>? favoriteCoffeeShops,
  }) {
    return CoffeeShopsStateModel(
      isLoading: isLoading ?? this.isLoading,
      coffeeShops: coffeeShops ?? this.coffeeShops,
      favoriteCoffeeShops: favoriteCoffeeShops ?? this.favoriteCoffeeShops,
    );
  }
}

@riverpod
class CoffeeShopsViewModel extends _$CoffeeShopsViewModel {
  @override
  CoffeeShopsStateModel build() {
    return CoffeeShopsStateModel.initial();
  }

  getAllShops() {
    state = state.copyWith(isLoading: true);

    final images = [
      "https://media.istockphoto.com/id/1428594094/photo/empty-coffee-shop-interior-with-wooden-tables-coffee-maker-pastries-and-pendant-lights.jpg?s=612x612&w=0&k=20&c=dMqeYCJDs3BeBP_jv93qHRISDt-54895SPoVc6_oJt4=",
      "https://images.pexels.com/photos/2159065/pexels-photo-2159065.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
      "https://www.barniescoffee.com/cdn/shop/articles/bar-1869656_1920.jpg?v=1660683986",
      "https://coffeebusiness.com/wp-content/uploads/2019/08/14tenents-pt2.jpg",
      "https://b.zmtcdn.com/data/collections/e7e6c3774795c754eac6c2bbeb0ba57a_1709896412.png?fit=around|562.5:360&crop=562.5:360;*,*",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSEBGzOS0ADSN2MRZHythXzbaj8s5oHNKzWAzwf4FgujpHwtgGjNoKnVxe1VgY-GB49BuI&usqp=CAU"
    ];
    final shopFullData = [
      {
        "name": "Caffely Astoria Aromas",
        "rating": "4.8",
        "reviews": [],
        "distance": "1.5 km",
        "image": images[0],
        "id": "111",
        "products": [
          "ids",
          "",
        ],
        "offers": [],
        "types": ["Coffee"],
        "about": {
          "about": "",
          "opening": [
            {"days": "Monday -Friday", "times": "9:00 AM - 22:00 PM"},
          ],
        },
        "address": "id"
      },
      {
        "name": "Caffely West Village Wake-Up",
        "rating": "4.6",
        "reviews": [],
        "distance": "2.5 km",
        "image": images[1],
        "id": "222",
        "products": [],
        "offers": [],
        "types": ["Coffee"],
        "about": {
          "about": "",
          "opening": [
            {"days": "Monday -Friday", "times": "9:00 AM - 22:00 PM"}
          ]
        },
        "address": "id"
      },
      {
        "name": "Caffely Upper East Espresso",
        "rating": "4.4",
        "reviews": [],
        "distance": "3.5 km",
        "image": images[2],
        "id": "333",
        "products": [],
        "offers": [],
        "types": ["Coffee"],
        "about": {
          "about": "",
          "opening": [
            {"days": "Monday -Friday", "times": "9:00 AM - 22:00 PM"}
          ]
        },
        "address": "id"
      },
      {
        "name": "Caffely Manhattan Morning",
        "rating": "4.5",
        "reviews": [],
        "distance": "4.5 km",
        "image": images[3],
        "id": "444",
        "products": [],
        "offers": [],
        "types": ["Coffee"],
        "about": {
          "about": "",
          "opening": [
            {"days": "Monday -Friday", "times": "9:00 AM - 22:00 PM"}
          ]
        },
        "address": "id"
      },
      {
        "name": "Caffely Wall Street",
        "rating": "4.7",
        "reviews": [],
        "distance": "4.5 km",
        "image": images[4],
        "id": "555",
        "products": [],
        "offers": [],
        "types": ["Coffee"],
        "about": {
          "about": "",
          "opening": [
            {"days": "Monday -Friday", "times": "9:00 AM - 22:00 PM"}
          ]
        },
        "address": "id"
      },
      {
        "name": "Caffely Queens",
        "rating": "4.8",
        "reviews": [],
        "distance": "4.5 km",
        "image": images[5],
        "id": "666",
        "products": [],
        "offers": [],
        "types": ["Coffee"],
        "about": {
          "about": "",
          "opening": [
            {"days": "Monday -Friday", "times": "9:00 AM - 22:00 PM"}
          ]
        },
        "address": "id"
      }
    ];

    final nearbyShopsList = shopFullData;
    List<ShopModel> shops = [];
    for (var shop in nearbyShopsList) {
      shops.add(ShopModel.fromJson(shop));
    }
    List<ShopModel> shuffledShop = shops;
    shuffledShop.shuffle();
    state = state.copyWith(
        coffeeShops: shops,
        favoriteCoffeeShops: shuffledShop,
        isLoading: false);
  }
}

// class CoffeeShopsViewModels extends ChangeNotifier {
//   bool _loading = false;
//   List<ShopModel> _coffeeShops = [];
//   final List<ShopModel> _favoriteCoffeeShops = [];

//   bool get loading => _loading;
//   List<ShopModel> get coffeeShops => _coffeeShops;
//   List<ShopModel> get favoriteCoffeeShops => _favoriteCoffeeShops;

//   setLoading(bool loading) {
//     _loading = loading;
//     notifyListeners();
//   }

//   setCoffeeShops(List<ShopModel> coffeeShops) {
//     _coffeeShops = coffeeShops;
//   }

//   setFavoriteCoffeeShops(List<ShopModel> favoriteCoffeeShops) {
//     _favoriteCoffeeShops.addAll(favoriteCoffeeShops);
//   }
// }
