import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:coffee_app/features/home/models/shop_model.dart';
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
  final List<String>? orderIds;

  OrderStateModel({
    required this.activeOrderModels,
    required this.completedOrderModels,
    required this.canceledOrderModels,
    required this.isLoading,
    this.selectedOrder,
    this.shopModel,
    this.orderIds,
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
    List<String>? orderIds,
  }) {
    return OrderStateModel(
      activeOrderModels: activeOrderModels ?? this.activeOrderModels,
      completedOrderModels: completedOrderModels ?? this.completedOrderModels,
      canceledOrderModels: canceledOrderModels ?? this.canceledOrderModels,
      isLoading: isLoading ?? this.isLoading,
      selectedOrder: selectedOrder ?? this.selectedOrder,
      shopModel: shopModel ?? this.shopModel,
      orderIds: orderIds ?? this.orderIds,
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

  void setOrderIds(List<String> orderIds) {
    state = state.copyWith(orderIds: orderIds);
  }

  void getShopModel() async {
    final response = ref.read(checkoutViewModelProvider).shopModel!;
    state = state.copyWith(
      shopModel: response,
    );
  }

  Future<void> cancelOrder({List<String>? orderIds}) async {
    state = state.copyWith(isLoading: true);
    if (orderIds == null && state.orderIds == null) {
      state = state.copyWith(isLoading: false);
      return;
    }
    final response =
        await OrderService.cancelOrder(orderIds ?? state.orderIds!);
    response.fold((l) => debugPrint(l), (r) {
      getOrders();
    });
    state = state.copyWith(isLoading: false);
  }

  Future<void> getOrders({bool loading = true}) async {
    state = state.copyWith(isLoading: loading);
    final activeOrderRes = await OrderService.getActiveOrderModels();
    final completedOrderRes = await OrderService.getCompletedOrderModels();
    final canceledOrderRes = await OrderService.getCanceledOrderModels();
    activeOrderRes.fold((l) => debugPrint(l), (r) {
      state = state.copyWith(
        activeOrderModels: r,
      );
    });
    completedOrderRes.fold((l) => debugPrint(l), (r) {
      state = state.copyWith(
        completedOrderModels: r,
      );
    });
    canceledOrderRes.fold((l) => debugPrint(l), (r) {
      state = state.copyWith(
        canceledOrderModels: r,
      );
    });
    state = state.copyWith(isLoading: false);
  }
}
