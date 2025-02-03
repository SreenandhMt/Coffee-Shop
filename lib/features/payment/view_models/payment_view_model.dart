// ignore_for_file: use_build_context_synchronously

import 'package:coffee_app/core/app_colors.dart';
import 'package:coffee_app/features/home/models/shop_model.dart';
import 'package:coffee_app/features/payment/service/payment_service.dart';
import 'package:coffee_app/route/navigation_utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../components/checkout/pick_up_widget.dart';
import '../../auth/views/signin_page.dart';
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

  void payOnTopUp(BuildContext context, int amount, String currency,
      Map<String, dynamic> paymentMethod) async {
    final response =
        await PaymentService.makePayment(amount, "usd", "Caffely Wallet");
    if (response) {
      showDialog(
        context: context,
        builder: (context) => DialogBox(
          icon: Icons.check_box_rounded,
          title: "Top Up Successful!",
          subtitle: "The amount of \$100 hs been added to your wallet",
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    fixedSize: const Size(double.infinity, 60),
                  ),
                  onPressed: () {
                    if (context.canPop()) context.pop();
                    if (context.canPop()) context.pop();
                    if (context.canPop()) context.pop();
                  },
                  child: const Text("OK",
                      style: TextStyle(color: Colors.white, fontSize: 17)),
                ),
              ),
            ],
          ),
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
