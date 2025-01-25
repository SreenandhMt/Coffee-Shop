import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:coffee_app/features/buying/models/order_details_model.dart';
import 'package:coffee_app/features/checkout/services/checkout_service.dart';
import 'package:coffee_app/features/home/models/offer_model.dart';

part 'checkout_view_model.g.dart';

class CheckoutStateModel {
  final bool isLoading;
  final List<OrderDetailsModel> orderModels;
  final List<String> promos;
  final String? paymentMethod;
  final String? pickUpTime;
  final String? pickUpDate;
  final double totalPrice;
  final Map<String, dynamic>? selectedAddress;
  final Map<String, dynamic>? selectedDelivery;
  final List<OfferModel>? offers;

  CheckoutStateModel({
    required this.isLoading,
    required this.orderModels,
    required this.promos,
    this.paymentMethod,
    this.pickUpTime,
    this.pickUpDate,
    required this.totalPrice,
    this.selectedAddress,
    this.selectedDelivery,
    this.offers,
  });

  factory CheckoutStateModel.initial() {
    return CheckoutStateModel(
      isLoading: false,
      totalPrice: 0.0,
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
    double? totalPrice,
    Map<String, dynamic>? selectedAddress,
    Map<String, dynamic>? selectedDelivery,
    List<OfferModel>? offers,
  }) {
    return CheckoutStateModel(
      isLoading: isLoading ?? this.isLoading,
      orderModels: orderModels ?? this.orderModels,
      promos: promos ?? this.promos,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      pickUpTime: pickUpTime ?? this.pickUpTime,
      pickUpDate: pickUpDate ?? this.pickUpDate,
      totalPrice: totalPrice ?? this.totalPrice,
      selectedAddress: selectedAddress ?? this.selectedAddress,
      selectedDelivery: selectedDelivery ?? this.selectedDelivery,
      offers: offers ?? this.offers,
    );
  }
}

@riverpod
class CheckoutViewModel extends _$CheckoutViewModel {
  @override
  CheckoutStateModel build() {
    return CheckoutStateModel.initial();
  }

  void setOrderModels(String shopID) async {
    state = state.copyWith(isLoading: true);
    getOffers();
    final response = await CheckoutService.getCheckouts(shopID);
    response.fold((l) => log(l), (r) {
      double totalPrice = 0;
      for (var element in r) {
        totalPrice += element.totalPrice;
      }
      state = state.copyWith(
          orderModels: r, isLoading: false, totalPrice: totalPrice);
    });
  }

  void getOffers() async {
    final response = await CheckoutService.getVouchers();
    response.fold((l) => log(l), (r) {
      state = state.copyWith(offers: r);
    });
  }

  void addPromos(String value) {
    if (state.promos.contains(value)) {
      state = state.copyWith(
          promos: state.promos.where((e) => e != value).toList());
    } else {
      state = state.copyWith(promos: [...state.promos, value]);
    }
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
    state = state.copyWith(selectedDelivery: delivery);
  }

  void addOrderModel(OrderDetailsModel value) {
    state = state.copyWith(orderModels: [...state.orderModels, value]);
  }
}
