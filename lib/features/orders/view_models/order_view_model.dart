import 'dart:developer';

import 'package:coffee_app/features/home/models/shop_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:coffee_app/features/orders/services/order_service.dart';

import '../../checkout/view_models/checkout_view_model.dart';
import '/features/orders/models/order_model.dart';

part 'order_view_model.g.dart';

class OrderStateModel {
  final List<OrderModel> activeOrderModels;
  final List<OrderModel> completedOrderModels;
  final List<OrderModel> canceledOrderModels;
  final bool isLoading;
  final OrderModel? selectedOrder;
  final ShopModel? shopModel;

  OrderStateModel({
    required this.activeOrderModels,
    required this.completedOrderModels,
    required this.canceledOrderModels,
    required this.isLoading,
    this.selectedOrder,
    this.shopModel,
  });

  factory OrderStateModel.initial() {
    return OrderStateModel(
      activeOrderModels: [],
      completedOrderModels: [],
      canceledOrderModels: [],
      isLoading: false,
    );
  }

  OrderStateModel copyWith({
    List<OrderModel>? activeOrderModels,
    List<OrderModel>? completedOrderModels,
    List<OrderModel>? canceledOrderModels,
    bool? isLoading,
    OrderModel? selectedOrder,
    ShopModel? shopModel,
  }) {
    return OrderStateModel(
      activeOrderModels: activeOrderModels ?? this.activeOrderModels,
      completedOrderModels: completedOrderModels ?? this.completedOrderModels,
      canceledOrderModels: canceledOrderModels ?? this.canceledOrderModels,
      isLoading: isLoading ?? this.isLoading,
      selectedOrder: selectedOrder ?? this.selectedOrder,
      shopModel: shopModel ?? this.shopModel,
    );
  }
}

@riverpod
class OrderViewModel extends _$OrderViewModel {
  @override
  OrderStateModel build() {
    return OrderStateModel.initial();
  }

  void selectOrderModel(OrderModel orderModel) {
    state = state.copyWith(selectedOrder: orderModel);
  }

  void rateAndReviewShop(double rating, String review) {
    OrderService.rateAndReviewShop(
      rating,
      review,
      state.selectedOrder!.shopId,
    );
  }

  void initOrderDetails() {
    state = state.copyWith(isLoading: true);
    getShopModel();
    state = state.copyWith(isLoading: false);
  }

  void getShopModel() async {
    final response = ref.read(checkoutViewModelProvider).shopModel!;
    state = state.copyWith(
      shopModel: response,
    );
  }

  Future<void> getOrders({bool loading = true}) async {
    state = state.copyWith(isLoading: loading);
    final response = await OrderService.getOrderModels();
    response.fold((l) => log(l), (r) {
      state = state.copyWith(
        activeOrderModels: r,
      );
    });
    state = state.copyWith(isLoading: false);
  }
}
