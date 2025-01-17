import 'package:flutter/material.dart';

import 'package:coffee_app/features/buying/models/order_details_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'checkout_view_model.g.dart';

class CheckoutStateModel {
  final bool isLoading;
  final List<OrderDetailsModel> orderModels;
  final List<String> promos;
  final String? paymentMethod;
  final String? pickUpTime;
  final String? pickUpDate;
  final Map<String, dynamic>? selectedAddress;
  final Map<String, dynamic>? selectedDelivery;

  CheckoutStateModel({
    required this.isLoading,
    required this.orderModels,
    required this.promos,
    this.paymentMethod,
    this.pickUpTime,
    this.pickUpDate,
    this.selectedAddress,
    this.selectedDelivery,
  });

  factory CheckoutStateModel.initial() {
    return CheckoutStateModel(
      isLoading: false,
      orderModels: [],
      promos: [],
    );
  }

  CheckoutStateModel copyWith({
    bool? isLoading,
    List<OrderDetailsModel>? orderModels,
    List<String>? promos,
    String? paymentMethod,
    String? pickUpTime,
    String? pickUpDate,
    Map<String, dynamic>? selectedAddress,
    Map<String, dynamic>? selectedDelivery,
  }) {
    return CheckoutStateModel(
      isLoading: isLoading ?? this.isLoading,
      orderModels: orderModels ?? this.orderModels,
      promos: promos ?? this.promos,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      pickUpTime: pickUpTime ?? this.pickUpTime,
      pickUpDate: pickUpDate ?? this.pickUpDate,
      selectedAddress: selectedAddress ?? this.selectedAddress,
      selectedDelivery: selectedDelivery ?? this.selectedDelivery,
    );
  }
}

@riverpod
class CheckoutViewModel extends _$CheckoutViewModel {
  @override
  CheckoutStateModel build() {
    return CheckoutStateModel.initial();
  }

  void setOrderModels(List<OrderDetailsModel> value) {
    state = state.copyWith(orderModels: value);
  }

  void addPromos(String value) {
    state = state.copyWith(promos: [...state.promos, value]);
  }

  void removePromos(String value) {
    state =
        state.copyWith(promos: state.promos.where((e) => e != value).toList());
  }

  void setPaymentMethod(String value) {
    state = state.copyWith(paymentMethod: value);
  }

  void setPickUpTime(String time, String date) {
    state = state.copyWith(pickUpTime: time, pickUpDate: date);
  }

  selectAddress(Map<String, dynamic> address) {
    state = state.copyWith(selectedAddress: address);
  }

  selectDeliveryService(Map<String, dynamic> delivery) {
    state.copyWith(selectedDelivery: delivery);
  }

  void addOrderModel(OrderDetailsModel value) {
    state = state.copyWith(orderModels: [...state.orderModels, value]);
  }
}

class CheckoutViewModelss extends ChangeNotifier {
  bool _isLoading = false;
  final List<OrderDetailsModel> _orderModels = [];
  final List<String> _promos = [];
  String? _paymentMethod;
  String? _pickUpTime;
  String? _pickUpDate;
  Map<String, dynamic>? _selectedAddress;
  Map<String, dynamic>? _selectedDelivery;
  int currentPage = 0;

  bool get isLoading => _isLoading;
  List<OrderDetailsModel> get orderModel => _orderModels;
  List<String> get promos => _promos;
  String? get paymentMethod => _paymentMethod;
  String? get pickUpTime => _pickUpTime;
  String? get pickUpDate => _pickUpDate;
  Map<String, dynamic>? get selectedAddress => _selectedAddress;
  Map<String, dynamic>? get selectedDelivery => _selectedDelivery;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
