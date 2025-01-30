import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

import '../../core/app_colors.dart';
import '../../core/fonts.dart';
import '../../core/size.dart';
import '../../features/home/models/coffee_model.dart';
import '../../localization/locales.dart';
import '../../route/navigation_utils.dart';

class CoffeeCard extends StatelessWidget {
  const CoffeeCard({
    super.key,
    required this.model,
    this.selected = false,
    this.isShopPage = false,
    this.onLongPress,
  });

  final CoffeeModel model;
  final bool selected;
  final bool isShopPage;
  final void Function()? onLongPress;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return InkWell(
      onLongPress: onLongPress,
      onTap: () => NavigationUtils.buyingPage(context, model.id, isShopPage),
      child: Column(
        children: [
          Container(
            width: (size.width / 2) * 0.9,
            height: size.width * 0.45,
            decoration: BoxDecoration(
              color: AppColors.secondaryColor(context),
              border: selected
                  ? Border.all(
                      width: 2.5,
                      color: AppColors.primaryColor,
                    )
                  : null,
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(model.imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 8.0),
            child: SizedBox(
              width: size.width * 0.4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    style: subtitleFont(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: selected ? AppColors.primaryColor : null),
                    maxLines: 2,
                  ),
                  Text("\$${model.price}",
                      style: const TextStyle(
                          fontSize: 15, color: AppColors.primaryColor))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
