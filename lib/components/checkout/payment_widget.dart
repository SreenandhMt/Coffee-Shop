import 'package:coffee_app/core/size.dart';
import 'package:flutter/material.dart';

import '../../core/app_colors.dart';

class SelectedPaymentWidget extends StatefulWidget {
  const SelectedPaymentWidget({super.key, required this.paymentMethod});
  final Map<String, dynamic> paymentMethod;

  @override
  State<SelectedPaymentWidget> createState() => _SelectedPaymentWidgetState();
}

class _SelectedPaymentWidgetState extends State<SelectedPaymentWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.paymentMethod["name"] == "Wallet") {
      return Container(
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
                color: AppColors.secondaryColor(context), width: 0.1)),
        child: Row(
          children: [
            const Icon(
              Icons.wallet,
              size: 55,
              color: AppColors.primaryColor,
            ),
            width10,
            const Text(
              "My Wallet",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            const Spacer(),
            const Text("\$948.50",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            width5,
            Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey.shade500)
          ],
        ),
      );
    } else {
      return Container(
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: AppColors.secondaryColor(context), width: 0.1)),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage(widget.paymentMethod["image"]!),
            ),
            width20,
            Text(
              widget.paymentMethod["name"]!,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            const Spacer(),
            Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey.shade500)
          ],
        ),
      );
    }
  }
}
