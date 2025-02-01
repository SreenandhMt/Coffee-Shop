import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/app_colors.dart';
import '../../core/fonts.dart';
import '../../core/size.dart';
import '../../features/coffee_shop_details/view_models/coffee_shop_view_model.dart';
import '../../route/navigation_utils.dart';

class CheckoutButton extends ConsumerWidget {
  const CheckoutButton({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final viewModel = ref.watch(shopDetailsViewModelProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: InkWell(
        onTap: () {
          if (viewModel.selectedCoffeeIds.isNotEmpty) {
            NavigationUtils.checkoutPage(context, viewModel.shopModel!.id);
          }
        },
        child: Container(
          height: 80,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              width10,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  height5,
                  Text(
                    "Total ${viewModel.selectedCoffeeIds.length} item(s)",
                    style: const TextStyle(color: Colors.white),
                  ),
                  Text(
                    "\$${viewModel.totalPrice}",
                    style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                  const Spacer()
                ],
              ),
              const Spacer(),
              Text(
                "Checkout",
                style: subtitleFont(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
              width10,
              const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.white,
              ),
              width15
            ],
          ),
        ),
      ),
    );
  }
}
