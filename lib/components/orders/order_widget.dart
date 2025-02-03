import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/fonts.dart';
import '../../core/size.dart';

class OrderWidget extends StatelessWidget {
  const OrderWidget({
    super.key,
    required this.index,
  });
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        spacing: 10,
        children: [
          width10,
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: AppColors.secondaryColor(context),
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage("assets/image${6 - index}.png"),
              ),
            ),
          ),
          width5,
          Column(
            spacing: 5,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Classic Brew",
                maxLines: 1,
                style: titleFonts(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              const Row(
                spacing: 4,
                children: [
                  Icon(Icons.add_business_rounded, size: 17),
                  Text("Caffely Astoria Aromas")
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.primaryColor, width: 2),
                    borderRadius: BorderRadius.circular(5)),
                child: const Text(
                  "Pick Up",
                  style: TextStyle(color: AppColors.primaryColor),
                ),
              )
            ],
          ),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios_rounded),
          width10,
        ],
      ),
    );
  }
}
