import 'package:coffee_app/features/buying/models/order_details_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:coffee_app/features/buying/service/buying_service.dart';
import 'package:coffee_app/features/home/models/coffee_model.dart';

part 'buying_view_model.g.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class BuyingStateModel {
  final bool isLoading;
  final CoffeeModel? coffeeModel;
  final int quantity;
  final double totalPrice;
  final int? selectedSizeIndex;
  final int? selectedTypeIndex;
  final List<Map<String, dynamic>> selectedOption;
  final bool isFavorite;

  BuyingStateModel({
    required this.isLoading,
    this.coffeeModel,
    required this.quantity,
    required this.totalPrice,
    this.selectedSizeIndex,
    this.selectedTypeIndex,
    required this.selectedOption,
    required this.isFavorite,
  });

  factory BuyingStateModel.initial() {
    return BuyingStateModel(
        isLoading: false,
        quantity: 1,
        totalPrice: 0,
        selectedOption: [],
        isFavorite: false);
  }

  BuyingStateModel copyWith({
    bool? isLoading,
    CoffeeModel? coffeeModel,
    int? quantity,
    double? totalPrice,
    int? selectedSizeIndex,
    int? selectedTypeIndex,
    List<Map<String, dynamic>>? selectedOption,
    bool? isFavorite,
  }) {
    return BuyingStateModel(
        isLoading: isLoading ?? this.isLoading,
        coffeeModel: coffeeModel ?? this.coffeeModel,
        quantity: quantity ?? this.quantity,
        totalPrice: totalPrice ?? this.totalPrice,
        selectedSizeIndex: selectedSizeIndex ?? this.selectedSizeIndex,
        selectedTypeIndex: selectedTypeIndex ?? this.selectedTypeIndex,
        selectedOption: selectedOption ?? this.selectedOption,
        isFavorite: isFavorite ?? this.isFavorite);
  }
}

@riverpod
class BuyingViewModel extends _$BuyingViewModel {
  @override
  BuyingStateModel build() {
    return BuyingStateModel.initial();
  }

  selectTypeIndex(int index) {
    state = state.copyWith(selectedTypeIndex: index);
  }

  getFavoriteStatus(String id) async {
    final isFavorite = await BuyingService.getFavoriteStatus(id);
    state = state.copyWith(isFavorite: isFavorite);
  }

  void toggleFavorite() async {
    if (state.isFavorite) {
      state = state.copyWith(isFavorite: false);
      await BuyingService.removeToFavorite(state.coffeeModel!);
    } else {
      state = state.copyWith(isFavorite: true);
      await BuyingService.addToFavorite(state.coffeeModel!);
    }
  }

  BasketProductModel getProducts() {
    final sizes = [
      {"title": "Toll", "price": 0.0},
      {"title": "Grande", "price": 0.50},
      {"title": "Venti", "price": 1.00},
    ];
    final orderModel = BasketProductModel.fromJson({
      "uid": _auth.currentUser!.uid,
      "quantity": state.quantity,
      "sizePrice": sizes[state.selectedSizeIndex ?? 0]["price"],
      "sizeName": sizes[state.selectedSizeIndex ?? 0]["title"],
      "type": state.selectedTypeIndex == 0 ? "Hot" : "Iced",
      if (state.selectedOption.isNotEmpty) "option": state.selectedOption,
      "notes": "",
      "product-id": state.coffeeModel!.id,
      "basePrice": double.parse(state.coffeeModel!.price),
      "totalPrice": state.totalPrice,
    }, state.coffeeModel!);
    return orderModel;
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
    getFavoriteStatus(id);
    final coffeeDetails = await BuyingService.getCoffeeDetails(id);
    clearValues();
    coffeeDetails.fold(
      (left) {},
      (right) {
        state = state.copyWith(
            coffeeModel: right,
            isLoading: false,
            totalPrice: double.parse(right.price));
      },
    );
  }
}
