import 'package:coffee_app/core/size.dart';
import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/assets.dart';

class AvailableTypeWidget extends StatelessWidget {
  const AvailableTypeWidget({
    super.key,
    this.selectedIndex,
    required this.onTap,
  });
  final int? selectedIndex;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Available in",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
        height15,
        Row(
          children: [
            ...List.generate(
              2,
              (index) => Padding(
                padding: const EdgeInsets.only(right: 10),
                child: InkWell(
                  onTap: () => onTap(index),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 23),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          width: selectedIndex == index ? 1.0 : 0.1,
                          color: selectedIndex == index
                              ? AppColors.primaryColor
                              : Colors.grey),
                      color: selectedIndex == index
                          ? AppColors.primaryColor.withOpacity(0.2)
                          : AppColors.secondaryColor(context),
                    ),
                    child: Column(
                      children: [
                        if (index == 0)
                          Image.asset(
                            AppAssets.hotCoffee(context),
                            width: 70,
                            height: 70,
                          )
                        else
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Image.asset(
                              AppAssets.iceCoffee(context),
                              width: 60,
                              height: 60,
                            ),
                          ),
                        height5,
                        Text(index == 0 ? "Hot" : "Iced",
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
