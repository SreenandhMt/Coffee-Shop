import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:coffee_app/features/all_coffee_shops/services/coffee_shop_service.dart';
import 'package:coffee_app/features/home/models/shop_model.dart';

part 'coffee_shops_view_model.g.dart';

class CoffeeShopsStateModel {
  final bool isLoading;
  final List<ShopModel>? coffeeShops;
  final List<ShopModel> favoriteCoffeeShops;
  final List<ShopModel> searchedShops;
  final List<String> searchHistory;
  final String? userLocation;

  CoffeeShopsStateModel({
    required this.isLoading,
    this.coffeeShops,
    required this.favoriteCoffeeShops,
    required this.searchedShops,
    required this.searchHistory,
    this.userLocation,
  });

  factory CoffeeShopsStateModel.initial() {
    return CoffeeShopsStateModel(
      isLoading: false,
      favoriteCoffeeShops: [],
      searchedShops: [],
      searchHistory: [],
    );
  }

  CoffeeShopsStateModel copyWith({
    bool? isLoading,
    List<ShopModel>? coffeeShops,
    List<ShopModel>? favoriteCoffeeShops,
    List<ShopModel>? searchedShops,
    List<String>? searchHistory,
    String? userLocation,
  }) {
    return CoffeeShopsStateModel(
      isLoading: isLoading ?? this.isLoading,
      coffeeShops: coffeeShops ?? this.coffeeShops,
      favoriteCoffeeShops: favoriteCoffeeShops ?? this.favoriteCoffeeShops,
      searchedShops: searchedShops ?? this.searchedShops,
      searchHistory: searchHistory ?? this.searchHistory,
      userLocation: userLocation ?? this.userLocation,
    );
  }
}

@riverpod
class CoffeeShopsViewModel extends _$CoffeeShopsViewModel {
  @override
  CoffeeShopsStateModel build() {
    return CoffeeShopsStateModel.initial();
  }

  Future<String> searchShops(String query) async {
    state = state.copyWith(isLoading: true);
    List<ShopModel> shops = [];
    for (var shop in state.coffeeShops!) {
      if (shop.name.toLowerCase().contains(query.toLowerCase()) ||
          shop.types.contains(query)) {
        shops.add(shop);
      }
    }
    state = state.copyWith(isLoading: false, searchedShops: shops);
    return "";
  }

  void getUserCurrentLocation() {
    CoffeeShopsService.getCurrentAddress().then((value) {
      state = state.copyWith(userLocation: value);
    });
  }

  getAllShops() async {
    state = state.copyWith(isLoading: true);
    final favoriteShops = await CoffeeShopsService.getFavoriteCoffeeShops();
    favoriteShops.fold((l) => debugPrint(l), (shops) {
      state = state.copyWith(favoriteCoffeeShops: shops);
    });
    final allShops = await CoffeeShopsService.getAllShops();
    allShops.fold((l) => debugPrint(l), (shops) {
      state = state.copyWith(coffeeShops: shops);
    });
    getUserCurrentLocation();
    state = state.copyWith(isLoading: false);
  }

  getFavoriteShops() async {
    final favoriteShops = await CoffeeShopsService.getFavoriteCoffeeShops();
    favoriteShops.fold((l) => debugPrint(l), (shops) {
      state = state.copyWith(favoriteCoffeeShops: shops);
    });
  }

  getShops() async {
    final allShops = await CoffeeShopsService.getAllShops();
    allShops.fold((l) => debugPrint(l), (shops) {
      state = state.copyWith(coffeeShops: shops);
    });
  }
}
