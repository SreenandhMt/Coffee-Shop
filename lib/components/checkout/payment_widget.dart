import 'package:coffee_app/core/size.dart';
import 'package:flutter/material.dart';

import '../../core/app_colors.dart';

class SelectedPaymentWidget extends StatefulWidget {
  const SelectedPaymentWidget({super.key, required this.paymentMethod});
  final String paymentMethod;

  @override
  State<SelectedPaymentWidget> createState() => _SelectedPaymentWidgetState();
}

class _SelectedPaymentWidgetState extends State<SelectedPaymentWidget> {
  final paymentMethods = [
    "Wallet",
    "PayPal",
    "Google Pay",
    "Apple Pay",
    ".... .... .... .... 4676",
    ".... .... .... .... 5567"
  ];
  final images = [
    "",
    "https://cdn-icons-png.flaticon.com/512/2504/2504802.png",
    "https://w7.pngwing.com/pngs/63/1016/png-transparent-google-logo-google-logo-g-suite-chrome-text-logo-chrome.png",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR2XR3uve98Zaune2n4CVHaAjR6ReZwmcwHYg&s",
    "https://static-00.iconduck.com/assets.00/mastercard-icon-2048x1286-s6y46dfh.png",
    "https://w7.pngwing.com/pngs/167/298/png-transparent-card-credit-logo-visa-logos-and-brands-icon-thumbnail.png"
  ];
  @override
  Widget build(BuildContext context) {
    if (widget.paymentMethod == "Wallet") {
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
      for (int i = 0; i < paymentMethods.length; i++) {
        if (paymentMethods[i] == widget.paymentMethod) {
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
                  backgroundImage: NetworkImage(images[i]),
                ),
                width20,
                Text(
                  paymentMethods[i],
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w700),
                ),
                const Spacer(),
                Icon(Icons.arrow_forward_ios_rounded,
                    color: Colors.grey.shade500)
              ],
            ),
          );
        }
      }
      return const SizedBox();
    }
  }
}
