import 'dart:developer';

import 'package:coffee_app/features/buying/models/order_details_model.dart';
import 'package:flutter/material.dart';

class CheckoutViewModel extends ChangeNotifier {
  bool _isLoading = false;
  List<OrderDetailsModel> _orderModels = [];

  bool get isLoading => _isLoading;
  List<OrderDetailsModel> get orderModel => _orderModels;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setOrderModels(List<OrderDetailsModel> value) {
    _orderModels = value;
    log(value.toString());
  }

  void addOrderModel(OrderDetailsModel value) {
    _orderModels.add(value);
  }
}
