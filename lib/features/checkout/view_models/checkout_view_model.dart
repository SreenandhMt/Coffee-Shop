import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:coffee_app/features/buying/models/order_details_model.dart';
import 'package:coffee_app/features/checkout/services/checkout_service.dart';
import 'package:coffee_app/features/home/models/offer_model.dart';
import 'package:coffee_app/features/orders/models/order_model.dart';

import '../../home/models/shop_model.dart';

part 'checkout_view_model.g.dart';

class CheckoutStateModel {
  final bool isLoading;
  final List<BasketProductModel> orderModels;
  final List<String> promos;
  final Map<String, dynamic>? paymentMethod;
  final String? pickUpTime;
  final String? pickUpDate;
  final double totalPrice;
  final Map<String, dynamic>? selectedAddress;
  final Map<String, dynamic>? selectedDelivery;
  final List<OfferModel>? offers;
  final ShopModel? shopModel;
  final OrderModel? orderModel;
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
    this.shopModel,
    this.orderModel,
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
    List<BasketProductModel>? orderModels,
    List<String>? promos,
    Map<String, dynamic>? paymentMethod,
    String? pickUpTime,
    String? pickUpDate,
    double? totalPrice,
    Map<String, dynamic>? selectedAddress,
    Map<String, dynamic>? selectedDelivery,
    List<OfferModel>? offers,
    ShopModel? shopModel,
    OrderModel? orderModel,
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
        shopModel: shopModel ?? this.shopModel,
        orderModel: orderModel ?? this.orderModel);
  }
}

@riverpod
class CheckoutViewModel extends _$CheckoutViewModel {
  @override
  CheckoutStateModel build() {
    return CheckoutStateModel.initial();
  }

  void loadOrderData(String orderId) async {
    state = state.copyWith(isLoading: true);
    final response = await CheckoutService.getOrderModels(orderId);
    response.fold((l) => log(l), (r) {
      getShopDetails(r.shopId);
      state = state.copyWith(
          orderModel: r,
          selectedAddress: r.address,
          selectedDelivery: r.deliveryService,
          paymentMethod: r.paymentMethod,
          promos: r.discounts,
          orderModels: [r.orderDetails],
          isLoading: false);
    });
  }

  void setOrderModels(String shopID) async {
    state = state.copyWith(isLoading: true);
    getOffers();
    getShopDetails(shopID);
    final response = await CheckoutService.getBasketProducts(shopID);
    response.fold((l) => log(l), (r) {
      double totalPrice = 0;
      for (var element in r) {
        totalPrice += element.totalPrice;
      }
      state = state.copyWith(
          orderModels: r, isLoading: false, totalPrice: totalPrice);
    });
  }

  void getShopDetails(String shopID) async {
    state = state.copyWith(isLoading: true);
    final response = await CheckoutService.getShopDetails(shopID);
    response.fold((l) => log(l), (r) {
      state = state.copyWith(shopModel: r);
    });
    state = state.copyWith(isLoading: false);
  }

  void getOffers() async {
    final response = await CheckoutService.getVouchers();
    response.fold((l) => log(l), (r) {
      state = state.copyWith(offers: r);
    });
  }

  void pickupOrderConform() {
    for (var element in state.orderModels) {
      CheckoutService.pickupOrderConform(
        shop: state.shopModel!,
        product: element,
        offers: state.offers ?? [],
        isUsePoint: true,
        paymentMethod: state.paymentMethod!,
      );
    }
  }

  void deliveryOrderConform() {
    for (var element in state.orderModels) {
      CheckoutService.deliveryOrderConform(
          shop: state.shopModel!,
          product: element,
          offers: state.offers ?? [],
          isUsePoint: true,
          paymentMethod: state.paymentMethod!,
          deliveryService: state.selectedDelivery ?? {},
          address: state.selectedAddress ?? {});
    }
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

  void setPaymentMethod(Map<String, dynamic> value) {
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

  void addOrderModel(BasketProductModel value) {
    state = state.copyWith(orderModels: [...state.orderModels, value]);
    log(state.orderModels.toString());
  }
}
