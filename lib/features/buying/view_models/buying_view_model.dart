import 'dart:developer';

import 'package:coffee_app/features/buying/service/buying_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:coffee_app/features/home/models/coffee_model.dart';

part 'buying_view_model.g.dart';

class BuyingStateModel {
  final bool isLoading;
  final CoffeeModel? coffeeModel;
  final int quantity;
  final double totalPrice;
  final int? selectedSizeIndex;
  final int? selectedTypeIndex;
  final List<Map<String, dynamic>> selectedOption;
  final String selectedSyrup;
  final String selectedTopping;

  BuyingStateModel({
    required this.isLoading,
    this.coffeeModel,
    required this.quantity,
    required this.totalPrice,
    this.selectedSizeIndex,
    this.selectedTypeIndex,
    required this.selectedOption,
    required this.selectedSyrup,
    required this.selectedTopping,
  });

  factory BuyingStateModel.initial() {
    return BuyingStateModel(
      isLoading: false,
      quantity: 1,
      totalPrice: 0,
      selectedOption: [],
      selectedSyrup: "",
      selectedTopping: "",
    );
  }

  BuyingStateModel copyWith({
    bool? isLoading,
    CoffeeModel? coffeeModel,
    int? quantity,
    double? totalPrice,
    int? selectedSizeIndex,
    int? selectedTypeIndex,
    List<Map<String, dynamic>>? selectedOption,
    String? selectedSyrup,
    String? selectedTopping,
  }) {
    return BuyingStateModel(
      isLoading: isLoading ?? this.isLoading,
      coffeeModel: coffeeModel ?? this.coffeeModel,
      quantity: quantity ?? this.quantity,
      totalPrice: totalPrice ?? this.totalPrice,
      selectedSizeIndex: selectedSizeIndex ?? this.selectedSizeIndex,
      selectedTypeIndex: selectedTypeIndex ?? this.selectedTypeIndex,
      selectedOption: selectedOption ?? this.selectedOption,
      selectedSyrup: selectedSyrup ?? this.selectedSyrup,
      selectedTopping: selectedTopping ?? this.selectedTopping,
    );
  }
}

@riverpod
class BuyingViewModel extends _$BuyingViewModel {
  @override
  BuyingStateModel build() {
    return BuyingStateModel.initial();
  }

  Future<void> selectSyrup(String value, double price, double? oldPrice) async {
    state = state.copyWith(
        selectedSyrup: (value * state.quantity),
        totalPrice: (state.totalPrice + price));
    if (oldPrice != null) {
      state = state.copyWith(
          totalPrice: state.totalPrice - (oldPrice * state.quantity));
    }
  }

  selectToppings(String value, double price, double? oldPrice) {
    state = state.copyWith(
        selectedTopping: (value * state.quantity),
        totalPrice: (state.totalPrice + price));
    if (oldPrice != null) {
      state = state.copyWith(
          totalPrice: state.totalPrice - (oldPrice * state.quantity));
    }
  }

  selectTypeIndex(int index) {
    state = state.copyWith(selectedTypeIndex: index);
  }

  selectSizeIndex(int index, double price, double? oldPrice) {
    state = state.copyWith(
        selectedSizeIndex: index, totalPrice: (state.totalPrice + price));
    if (oldPrice != null) {
      state = state.copyWith(
          totalPrice: state.totalPrice - (oldPrice * state.quantity));
    }
  }

  selectOption(
      Map<String, dynamic> value, int index, double price, double? oldPrice) {
    List<Map<String, dynamic>> currentList = [];
    if (index >= 0 && index < state.selectedOption.length) {
      currentList = [
        ...state.selectedOption.sublist(0, index),
        value,
        ...state.selectedOption.sublist(index + 1),
      ];
    } else {
      currentList = [...state.selectedOption, value];
    }
    log("$price $oldPrice");
    if (oldPrice != null) {
      state = state = state.copyWith(
          selectedOption: currentList,
          totalPrice: double.parse(
              ((state.totalPrice + price) - oldPrice).toStringAsFixed(3)));
    } else {
      state = state = state.copyWith(
          selectedOption: currentList,
          totalPrice:
              double.parse((state.totalPrice + price).toStringAsFixed(3)));
    }
  }

  addQuantity() {
    if (state.quantity > 10) return;
    state = state.copyWith(
        quantity: state.quantity + 1,
        totalPrice: state.totalPrice + double.parse(state.coffeeModel!.price));
  }

  removeQuantity() {
    if (state.quantity < 1) return;
    state = state.copyWith(
        quantity: state.quantity - 1,
        totalPrice: state.totalPrice - double.parse(state.coffeeModel!.price));
  }

  clearValues() {
    state = BuyingStateModel.initial();
  }

  getCoffeeModel(String id) async {
    state.copyWith(isLoading: true);
    final coffeeDetails = await BuyingService.getCoffeeDetails(id);
    clearValues();
    coffeeDetails.fold(
      (left) {
        log(left.toString());
      },
      (right) {
        log(right.optionList.toString());
        state = state.copyWith(
            coffeeModel: right,
            isLoading: false,
            totalPrice: double.parse(right.price));
      },
    );
  }
}

// class BuyingViewModesls extends ChangeNotifier {
//   bool _isLoading = false;
//   CoffeeModel? _coffeeModel;
//   //
//   final int _quantity = 1;
//   double _totalPrice = 0;
//   //
//   int? _selectedSizeIndex;
//   int? _selectedTypeIndex;
//   final String _selectedMilk = "";
//   final String _selectedSyrup = "";
//   final String _selectedTopping = "";
//   //
//   final List<String> _selectedProductsIDs = [];

//   bool get isLoading => _isLoading;
//   CoffeeModel? get coffeeModel => _coffeeModel;
//   int get quantity => _quantity;
//   double get totalPrice => _totalPrice;
//   int? get selectedSizeIndex => _selectedSizeIndex;
//   int? get selectedTypeIndex => _selectedTypeIndex;
//   String get selectedMilk => _selectedMilk;
//   String get selectedSyrup => _selectedSyrup;
//   String get selectedTopping => _selectedTopping;
//   List<String> get selectedProductsIDs => _selectedProductsIDs;

//   setLoading(bool value) {
//     _isLoading = value;
//     notifyListeners();
//   }

//   setCoffeeModel(CoffeeModel value) {
//     _coffeeModel = value;
//     _totalPrice = double.parse(_coffeeModel!.price);
//   }
// }
