import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:coffee_app/features/buying/models/order_details_model.dart';
import 'package:coffee_app/features/home/models/shop_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../home/models/coffee_model.dart';

part 'coffee_shop_view_model.g.dart';

class ShopStateModel {
  final bool isLoading;
  final List<CoffeeModel>? coffeeModel;
  final ShopModel? shopModel;
  final List<OrderDetailsModel> selectedCoffeeIds;
  final double totalPrice;

  ShopStateModel(
      {required this.isLoading,
      this.coffeeModel,
      this.shopModel,
      required this.selectedCoffeeIds,
      required this.totalPrice});

  factory ShopStateModel.initial() {
    return ShopStateModel(
        isLoading: false, selectedCoffeeIds: [], totalPrice: 0.0);
  }

  ShopStateModel copyWith({
    bool? isLoading,
    List<CoffeeModel>? coffeeModel,
    ShopModel? shopModel,
    List<OrderDetailsModel>? selectedCoffeeIds,
    double? totalPrice,
  }) {
    return ShopStateModel(
      isLoading: isLoading ?? this.isLoading,
      coffeeModel: coffeeModel ?? this.coffeeModel,
      shopModel: shopModel ?? this.shopModel,
      selectedCoffeeIds: selectedCoffeeIds ?? this.selectedCoffeeIds,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }
}

@riverpod
class ShopDetailsViewModel extends _$ShopDetailsViewModel {
  @override
  ShopStateModel build() {
    return ShopStateModel.initial();
  }

  void addProductID(OrderDetailsModel orderModel) {
    state = state.copyWith(
        selectedCoffeeIds: [...state.selectedCoffeeIds, orderModel],
        totalPrice: (state.totalPrice + orderModel.totalPrice));
  }

  void clearValues() {
    state = ShopStateModel.initial();
  }

  void getShopDetails(String shopId) {
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
    final allCoffees = [
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
    for (var element in nearbyShopsList) {
      if (element["id"] == shopId) {
        state = state.copyWith(shopModel: ShopModel.fromJson(element));
      }
    }
    final coffeeModels =
        allCoffees.map((e) => CoffeeModel.fromJson(e)).toList();
    state = state.copyWith(coffeeModel: coffeeModels, isLoading: false);
  }
}

class CoffeeShopDetailsViewModelsss extends ChangeNotifier {
  bool _isLoading = false;
  List<CoffeeModel>? _coffeeModel;
  ShopModel? _shopModel;
  final List<OrderDetailsModel> _selectedCoffeeIds = [];
  final double _totalPrice = 0.0;

  bool get isLoading => _isLoading;
  List<CoffeeModel>? get coffeeModel => _coffeeModel;
  ShopModel? get shopModel => _shopModel;
  List<OrderDetailsModel> get selectedCoffeeIds => _selectedCoffeeIds;
  double get totalPrice => _totalPrice;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setCoffeeModel(List<CoffeeModel> value) {
    _coffeeModel = value;
  }

  void setShopModel(ShopModel value) {
    _shopModel = value;
  }
}
