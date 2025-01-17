import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:coffee_app/features/home/models/shop_model.dart';

import '../models/coffee_model.dart';

part 'home_view_model.g.dart';

class HomeStateModel {
  final bool loading;
  final List<CoffeeModel> popularCoffees;
  final List<ShopModel> nearbyShops;

  HomeStateModel({
    required this.loading,
    required this.popularCoffees,
    required this.nearbyShops,
  });

  factory HomeStateModel.initial() {
    return HomeStateModel(
      loading: true,
      popularCoffees: [],
      nearbyShops: [],
    );
  }

  HomeStateModel copyWith({
    bool? loading,
    List<CoffeeModel>? popularCoffees,
    List<ShopModel>? nearbyShops,
  }) {
    return HomeStateModel(
      loading: loading ?? this.loading,
      popularCoffees: popularCoffees ?? this.popularCoffees,
      nearbyShops: nearbyShops ?? this.nearbyShops,
    );
  }
}

@riverpod
class HomeViewModel extends _$HomeViewModel {
  @override
  HomeStateModel build() {
    return HomeStateModel.initial();
  }

  Future<void> getAllData() async {
    getNearbyShops();
    getPopularCoffees();
  }

  Future<void> getNearbyShops() async {
    state = state.copyWith(loading: true);
    final images = [
      "https://media.istockphoto.com/id/1428594094/photo/empty-coffee-shop-interior-with-wooden-tables-coffee-maker-pastries-and-pendant-lights.jpg?s=612x612&w=0&k=20&c=dMqeYCJDs3BeBP_jv93qHRISDt-54895SPoVc6_oJt4=",
      "https://images.pexels.com/photos/2159065/pexels-photo-2159065.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
      "https://www.barniescoffee.com/cdn/shop/articles/bar-1869656_1920.jpg?v=1660683986",
      "https://coffeebusiness.com/wp-content/uploads/2019/08/14tenents-pt2.jpg",
      "https://b.zmtcdn.com/data/collections/e7e6c3774795c754eac6c2bbeb0ba57a_1709896412.png?fit=around|562.5:360&crop=562.5:360;*,*",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSEBGzOS0ADSN2MRZHythXzbaj8s5oHNKzWAzwf4FgujpHwtgGjNoKnVxe1VgY-GB49BuI&usqp=CAU"
    ];
    final nearbyShopsList = [
      {
        "name": "Caffely Astoria Aromas",
        "rating": "4.8",
        "distance": "1.5 km",
        "image": images[0],
        "id": "111",
      },
      {
        "name": "Caffely West Village Wake-Up",
        "rating": "4.6",
        "distance": "2.5 km",
        "image": images[1],
        "id": "222",
      },
      {
        "name": "Caffely Upper East Espresso",
        "rating": "4.4",
        "distance": "3.5 km",
        "image": images[2],
        "id": "333",
      },
      {
        "name": "Caffely Manhattan Morning",
        "rating": "4.5",
        "distance": "4.5 km",
        "image": images[3],
        "id": "444",
      },
      {
        "name": "Caffely Wall Street",
        "rating": "4.7",
        "distance": "4.5 km",
        "image": images[4],
        "id": "555",
      },
      {
        "name": "Caffely Queens",
        "rating": "4.8",
        "distance": "4.5 km",
        "image": images[5],
        "id": "666",
      }
    ];
    final List<ShopModel> shops = [];
    for (var shop in nearbyShopsList) {
      shops.add(ShopModel.fromJson(shop));
    }

    state = state.copyWith(nearbyShops: shops, loading: false);
  }

  Future<void> getPopularCoffees() async {
    state = state.copyWith(loading: true);
    final popularCoffeeList = [
      {
        "name": "Classic Brew",
        "price": "3.50",
        "imagePath": "assets/image1.png",
        "id": "111",
      },
      {
        "name": "Minty Fresh Brew",
        "price": "4.50",
        "imagePath": "assets/image2.png",
        "id": "222",
      },
      {
        "name": "Sunshine Brew",
        "price": "5.50",
        "imagePath": "assets/image3.png",
        "id": "333",
      },
      {
        "name": "Blueberry Brew",
        "price": "4.00",
        "imagePath": "assets/image4.png",
        "id": "444",
      },
      {
        "name": "Choco Brew",
        "price": "5.50",
        "imagePath": "assets/image5.png",
        "id": "555",
      },
      {
        "name": "Vanilla Brew",
        "price": "6.00",
        "imagePath": "assets/image6.png",
        "id": "666",
      }
    ];
    final List<CoffeeModel> popularCoffees = [];
    for (var coffee in popularCoffeeList) {
      popularCoffees.add(CoffeeModel.fromJson(coffee));
    }
    state = state.copyWith(popularCoffees: popularCoffees);
  }
}

class HomeViewModeld extends ChangeNotifier {
  bool _loading = false;
  List<CoffeeModel> _popularCoffees = [];
  List<ShopModel> _nearbyShops = [];

  bool get loading => _loading;
  List<CoffeeModel> get popularCoffees => _popularCoffees;
  List<ShopModel> get nearbyShops => _nearbyShops;

  setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  setPopularCoffees(List<CoffeeModel> coffees) {
    _popularCoffees = coffees;
  }

  setNearbyShops(List<ShopModel> shops) {
    _nearbyShops = shops;
  }

  homeInitFunction() {
    getPopularCoffee();
    getNearbyShops();
  }

  getNearbyShops() {
    // setNearbyShops(shops);
    // log(shops.toString());
    setLoading(false);
  }

  getPopularCoffee() {
    setLoading(true);

    // setPopularCoffees(popularCoffees);
    setLoading(false);
  }
}
