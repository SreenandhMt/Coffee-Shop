// ignore_for_file: use_build_context_synchronously

import 'package:coffee_app/core/app_colors.dart';
import 'package:coffee_app/features/home/models/shop_model.dart';
import 'package:coffee_app/features/payment/service/payment_service.dart';
import 'package:coffee_app/route/navigation_utils.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../components/checkout/pick_up_widget.dart';
import '../../checkout/view_models/checkout_view_model.dart';

part 'payment_view_model.g.dart';

class PaymentState {
  PaymentState();
}

@riverpod
class PaymentViewModel extends _$PaymentViewModel {
  @override
  PaymentState build() {
    return PaymentState();
  }

  void pickUpPayment(BuildContext context, int amount, String currency,
      ShopModel shopModel, Map<String, dynamic> paymentMethod) async {
    final response =
        await PaymentService.makePayment(amount, "usd", shopModel.name);
    if (response) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: AppColors.primaryColor,
          content: Text('Payment Successful'),
        ),
      );
      await Future.delayed(const Duration(seconds: 1));
      ref.read(checkoutViewModelProvider.notifier).pickupOrderConform();
      showDialog(
          context: context, builder: (context) => const PickUpSuccessDialog());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Payment Failed'),
        ),
      );
    }
  }

  void pay(BuildContext context, int amount, String currency,
      ShopModel shopModel, Map<String, dynamic> paymentMethod) async {
    final response =
        await PaymentService.makePayment(amount, "usd", shopModel.name);
    if (response) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: AppColors.primaryColor,
          content: Text('Payment Successful'),
        ),
      );
      await Future.delayed(const Duration(seconds: 1));
      ref.read(checkoutViewModelProvider.notifier).deliveryOrderConform();
      NavigationUtils.searchingDriverPage(context, shopModel.id);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Payment Failed'),
        ),
      );
    }
  }
}
