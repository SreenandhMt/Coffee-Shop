import 'dart:developer';

import 'package:coffee_app/features/coffee_shop_details/view_models/coffee_shop_view_model.dart';
import 'package:coffee_app/features/home/models/coffee_model.dart';
import 'package:flutter/material.dart';

class BuyingViewModel extends ChangeNotifier {
  bool _isLoading = false;
  CoffeeModel? _coffeeModel;
  //
  int _quantity = 1;
  double _totalPrice = 0;
  //
  int? _selectedSizeIndex;
  int? _selectedTypeIndex;
  String _selectedMilk = "";
  String _selectedSyrup = "";
  String _selectedTopping = "";
  //
  final List<String> _selectedProductsIDs = [];

  bool get isLoading => _isLoading;
  CoffeeModel? get coffeeModel => _coffeeModel;
  int get quantity => _quantity;
  double get totalPrice => _totalPrice;
  int? get selectedSizeIndex => _selectedSizeIndex;
  int? get selectedTypeIndex => _selectedTypeIndex;
  String get selectedMilk => _selectedMilk;
  String get selectedSyrup => _selectedSyrup;
  String get selectedTopping => _selectedTopping;
  List<String> get selectedProductsIDs => _selectedProductsIDs;

  setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  setCoffeeModel(CoffeeModel value) {
    _coffeeModel = value;
    _totalPrice = double.parse(_coffeeModel!.price);
  }

  addProductID(String id) {
    _selectedProductsIDs.add(id);
  }

  selectSyrup(String value, double price, double? oldPrice) {
    _selectedSyrup = value * _quantity;
    _totalPrice = _totalPrice + price;
    if (oldPrice != null) _totalPrice = _totalPrice - (oldPrice * _quantity);
    notifyListeners();
  }

  selectToppings(String value, double price, double? oldPrice) {
    _selectedTopping = value;
    _totalPrice = _totalPrice + price;
    if (oldPrice != null) _totalPrice = _totalPrice - (oldPrice * _quantity);
    notifyListeners();
  }

  selectTypeIndex(int index) {
    _selectedTypeIndex = index;
    notifyListeners();
  }

  selectSizeIndex(int index, double price, double? oldPrice) {
    _selectedSizeIndex = index;
    _totalPrice = _totalPrice + price;
    if (oldPrice != null) _totalPrice = _totalPrice - (oldPrice * _quantity);
    notifyListeners();
  }

  selectMilk(String value, double price, double? oldPrice) {
    _selectedMilk = value;
    _totalPrice = _totalPrice + price;
    if (oldPrice != null) _totalPrice = _totalPrice - (oldPrice * _quantity);
    notifyListeners();
  }

  addQuantity() {
    _quantity++;
    _totalPrice = _totalPrice + double.parse(_coffeeModel!.price);
    notifyListeners();
  }

  removeQuantity() {
    if (_quantity > 1) {
      _quantity--;
      _totalPrice = _totalPrice - double.parse(_coffeeModel!.price);
      notifyListeners();
    }
  }

  clearValues() {
    _quantity = 1;
    _totalPrice = 0;
    _selectedSizeIndex = null;
    _selectedTypeIndex = null;
    _selectedMilk = "";
    _selectedSyrup = "";
    _selectedTopping = "";
    notifyListeners();
  }

  getCoffeeModel(String id) {
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
    clearValues();
    setLoading(true);
    for (var coffee in popularCoffeeList) {
      if (coffee["id"] == id) {
        setCoffeeModel(CoffeeModel.fromJson(coffee));
        break;
      }
    }
    setLoading(false);
  }
}
