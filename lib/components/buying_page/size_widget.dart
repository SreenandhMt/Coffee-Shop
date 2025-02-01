import 'package:coffee_app/core/app_colors.dart';
import 'package:coffee_app/core/assets.dart';
import 'package:flutter/material.dart';

import '../../core/size.dart';

class AvailableSizeWidget extends StatelessWidget {
  const AvailableSizeWidget({
    super.key,
    this.selectedIndex,
    required this.onTap,
  });
  final int? selectedIndex;
  final Function(int, double, double?) onTap;

  @override
  Widget build(BuildContext context) {
    final sizes = [
      {"title": "Toll", "price": "Free"},
      {"title": "Grande", "price": "0.50"},
      {"title": "Venti", "price": "1.00"},
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Size",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
        height15,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            sizes.length,
            (index) => Padding(
              padding: const EdgeInsets.only(right: 2),
              child: InkWell(
                onTap: () => onTap(
                    index,
                    sizes[index]["price"] == "Free"
                        ? 0.00
                        : double.tryParse(sizes[index]["price"]!)!,
                    selectedIndex == null
                        ? null
                        : sizes[selectedIndex!]['price'] == "Free"
                            ? 0.00
                            : double.tryParse(sizes[selectedIndex!]['price']!)),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 23),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: index == selectedIndex
                            ? AppColors.primaryColor
                            : Colors.grey,
                        width: index == selectedIndex ? 1.0 : 0.1),
                    color: index == selectedIndex
                        ? AppColors.primaryColor.withOpacity(0.2)
                        : AppColors.secondaryColor(context),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(15 - (index * 5)),
                        child: Image.asset(
                          AppAssets.hotCoffee(context),
                          width: (40 + ((index) * 10)),
                          height: (40 + ((index) * 10)),
                        ),
                      ),
                      height5,
                      Text(sizes[index]["title"] ?? "",
                          style: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w700)),
                      height5,
                      Text(
                          "${sizes[index]["price"] == "Free" ? "" : "+ "}${sizes[index]["price"]}",
                          style: const TextStyle(fontSize: 15))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
