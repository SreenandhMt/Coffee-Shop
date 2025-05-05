import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:coffee_app/features/buying/models/order_details_model.dart';
import 'package:coffee_app/features/checkout/services/checkout_service.dart';
import 'package:coffee_app/features/home/models/offer_model.dart';
import 'package:coffee_app/features/orders/models/order_model.dart';

import '../../address/models/address_model.dart';
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
  final AddressModel? selectedAddress;
  final Map<String, dynamic>? selectedDelivery;
  final List<OfferModel>? offers;
  final ShopModel? shopModel;
  final OrderModel? orderModel;
  final List<String>? orderIds;
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
    this.orderIds,
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
    AddressModel? selectedAddress,
    Map<String, dynamic>? selectedDelivery,
    List<OfferModel>? offers,
    ShopModel? shopModel,
    OrderModel? orderModel,
    List<String>? orderIds,
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
        orderModel: orderModel ?? this.orderModel,
        orderIds: orderIds ?? this.orderIds);
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
    response.fold((l) => debugPrint(l), (r) {
      getShopDetails(r.shopId);
      state = state.copyWith(
          orderModel: r,
          pickUpDate: r.pickUpDate,
          pickUpTime: r.pickupTime,
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
    final address = await CheckoutService.getInitAddress();
    address.fold((l) => debugPrint(l), (r) {
      state = state.copyWith(selectedAddress: r);
    });
    final response = await CheckoutService.getBasketProducts(shopID);
    response.fold((l) => debugPrint(l), (r) {
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
    response.fold((l) => debugPrint(l), (r) {
      state = state.copyWith(shopModel: r);
    });
    state = state.copyWith(isLoading: false);
  }

  void getOffers() async {
    final response = await CheckoutService.getVouchers();
    response.fold((l) => debugPrint(l), (r) {
      state = state.copyWith(offers: r);
    });
  }

  void pickupOrderConform() {
    List<String> orderIds = [];
    for (var element in state.orderModels) {
      final id = DateTime.now().microsecondsSinceEpoch.toString();
      orderIds.add(id);
      CheckoutService.pickupOrderConform(
        shop: state.shopModel!,
        product: element,
        offers: state.offers ?? [],
        pickupDate: state.pickUpDate ?? "",
        pickupTime: state.pickUpTime ?? "",
        isUsePoint: true,
        paymentMethod: state.paymentMethod!,
        id: id,
      );
    }
    state = state.copyWith(orderIds: orderIds);
  }

  void deliveryOrderConform() {
    List<String> orderIds = [];
    for (var element in state.orderModels) {
      final id = DateTime.now().microsecondsSinceEpoch.toString();
      orderIds.add(id);
      CheckoutService.deliveryOrderConform(
          shop: state.shopModel!,
          product: element,
          offers: state.offers ?? [],
          isUsePoint: true,
          paymentMethod: state.paymentMethod!,
          deliveryService: state.selectedDelivery ?? {},
          id: id,
          address: state.selectedAddress != null
              ? state.selectedAddress!.toJson()
              : {});
    }
    state = state.copyWith(orderIds: orderIds);
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

  selectAddress(AddressModel address) {
    state = state.copyWith(selectedAddress: address);
  }

  selectDeliveryService(Map<String, dynamic> delivery) {
    state = state.copyWith(selectedDelivery: delivery);
  }

  void addOrderModel(BasketProductModel value) {
    state = state.copyWith(orderModels: [...state.orderModels, value]);
  }
}
