import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:coffee_app/features/orders/services/order_service.dart';

import '/features/orders/models/order_model.dart';

part 'order_view_model.g.dart';

class OrderStateModel {
  final List<OrderModel> activeOrderModels;
  final List<OrderModel> completedOrderModels;
  final List<OrderModel> canceledOrderModels;
  final bool isLoading;
  final OrderModel? selectedOrder;
  final OrderModel? currentOrder;

  OrderStateModel({
    required this.activeOrderModels,
    required this.completedOrderModels,
    required this.canceledOrderModels,
    required this.isLoading,
    this.selectedOrder,
    this.currentOrder,
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
    OrderModel? currentOrder,
  }) {
    return OrderStateModel(
      activeOrderModels: activeOrderModels ?? this.activeOrderModels,
      completedOrderModels: completedOrderModels ?? this.completedOrderModels,
      canceledOrderModels: canceledOrderModels ?? this.canceledOrderModels,
      isLoading: isLoading ?? this.isLoading,
      selectedOrder: selectedOrder ?? this.selectedOrder,
      currentOrder: currentOrder ?? this.currentOrder,
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

  void getCurrentOrder(String id) async {
    state = state.copyWith(isLoading: true);
    final response = await OrderService.getOrderModelById(id);
    response.fold((l) => log(l), (r) {
      state = state.copyWith(
        currentOrder: r,
      );
    });
    state = state.copyWith(isLoading: false);
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
