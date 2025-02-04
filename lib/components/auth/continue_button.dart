import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

import '../../core/app_colors.dart';
import '../../core/size.dart';
import '../../localization/locales.dart';

class ContinueButton extends StatelessWidget {
  const ContinueButton({
    super.key,
    required this.imageLink,
    required this.name,
    this.onTap,
  });
  final String imageLink;
  final String name;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 10),
        height: 60,
        decoration: BoxDecoration(
            color: AppColors.secondaryColor(context),
            borderRadius: BorderRadius.circular(50),
            border: Border.all(width: 0.2, color: Colors.grey)),
        child: Row(
          children: [
            width20,
            Image.asset(imageLink, height: 30, width: 30),
            const Spacer(),
            Text(
              context.formatString(LocaleData.authSocialSigninButton, [name]),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const Spacer(),
            width30,
          ],
        ),
      ),
    );
  }
}
