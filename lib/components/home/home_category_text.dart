import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

import '../../core/app_colors.dart';
import '../../core/size.dart';
import '../../localization/locales.dart';

class HomeCategoryText extends StatelessWidget {
  const HomeCategoryText({
    super.key,
    required this.text,
    required this.onTap,
  });
  final String text;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        width20,
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
          ),
        ),
        InkWell(
          onTap: onTap,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                LocaleData.viewAll.getString(context),
                style: const TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              width10,
              const Icon(Icons.arrow_forward_ios,
                  size: 15, color: AppColors.primaryColor),
            ],
          ),
        ),
        width20,
      ],
    );
  }
}
