import 'package:flutter/material.dart';

import '../models/coffee_model.dart';

class HomeViewModel extends ChangeNotifier {
  bool _loading = false;
  List<CoffeeModel> _popularCoffees = [];

  bool get loading => _loading;
  List<CoffeeModel> get popularCoffees => _popularCoffees;

  setLoading(bool loading)
  {
    _loading = loading;
    notifyListeners();
  }

  setPopularCoffees(List<CoffeeModel> coffees)
  {
    _popularCoffees = coffees;
  }

  getPopularCoffee()
  {
    final coffeeImages = [
    "assets/image1.png",
    "assets/image2.png",
    "assets/image3.png",
    "assets/image4.png",
    "assets/image5.png",
    "assets/image6.png",
  ];
    setLoading(true);
    final popularCoffeeList = [
      {
        "name": "Classic Brew",
        "price": "10.5",
        "imagePath": "assets/image1.png",
      },
      {
        "name": "Minty Fresh Brew",
        "price": "10.5",
        "imagePath": "assets/image2.png",
      },
      {
        "name": "Sunshine Brew",
        "price": "10.5",
        "imagePath": "assets/image3.png",
      },
      {
        "name": "Blueberry Brew",
        "price": "10.5",
        "imagePath": "assets/image4.png",
      }
      ,
      {
        "name": "Choco Brew",
        "price": "10.5",
        "imagePath": "assets/image5.png",
      }
      ,
      {
        "name": "Vanilla Brew",
        "price": "10.5",
        "imagePath": "assets/image6.png",
      }
    ];
    final List<CoffeeModel> _popularCoffees = [];
    popularCoffeeList.forEach((coffee) {
      _popularCoffees.add(CoffeeModel.fromJson(coffee));
    });
    setPopularCoffees(_popularCoffees);
    setLoading(false);
  }
}