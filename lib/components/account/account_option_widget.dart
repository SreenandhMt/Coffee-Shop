import 'package:coffee_app/core/size.dart';
import 'package:flutter/material.dart';

import '../../core/app_colors.dart';

class AccountOptionsWidget extends StatelessWidget {
  const AccountOptionsWidget({
    super.key,
    required this.title,
    required this.icon,
    this.child,
    this.color,
    this.onTap,
  });
  final String title;
  final IconData icon;
  final Widget? child;
  final Color? color;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
      child: InkWell(
        onTap: onTap,
        child: Row(children: [
          Icon(
            icon,
            color: color,
          ),
          width20,
          Text(title,
              style: TextStyle(
                  fontSize: 19, fontWeight: FontWeight.w600, color: color)),
          const Spacer(),
          child ??
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 23,
                color: color ?? AppColors.themeTextColor(context),
              )
        ]),
      ),
    );
  }
}
