import 'package:coffee_app/features/buying/models/order_details_model.dart';
import 'package:flutter/material.dart';

class CheckoutViewModel extends ChangeNotifier {
  bool _isLoading = false;
  List<OrderDetailsModel> _orderModels = [];
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

  void setOrderModels(List<OrderDetailsModel> value) {
    _orderModels = value;
  }

  void addPromos(String value) {
    _promos.add(value);
    notifyListeners();
  }

  void removePromos(String value) {
    _promos.remove(value);
    notifyListeners();
  }

  void setPaymentMethod(String value) {
    _paymentMethod = value;
    notifyListeners();
  }

  void setPickUpTime(String time, String date) {
    _pickUpTime = time;
    _pickUpDate = date;
    setLoading(false);
  }

  selectAddress(Map<String, dynamic> address) {
    _selectedAddress = address;
    notifyListeners();
  }

  selectDeliveryService(Map<String, dynamic> delivery) {
    _selectedDelivery = delivery;
    notifyListeners();
  }

  void addOrderModel(OrderDetailsModel value) {
    _orderModels.add(value);
  }
}
