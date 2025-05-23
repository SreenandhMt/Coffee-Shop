import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:coffee_app/core/fonts.dart';
import 'package:coffee_app/core/size.dart';

import '../../core/app_colors.dart';

class TileWidget extends StatelessWidget {
  const TileWidget({
    super.key,
    required this.startIcon,
    required this.title,
    required this.subtitle,
    this.endIcon,
    this.border,
    this.onTap,
  });
  final IconData startIcon;
  final String title;
  final String subtitle;
  final IconData? endIcon;
  final Border? border;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), border: border),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              width10,
              CircleAvatar(
                  backgroundColor: AppColors.secondaryColor(context),
                  child: Icon(
                    startIcon,
                    color: AppColors.themeColor(context),
                  )),
              width15,
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 4,
                  children: [
                    Text(title,
                        maxLines: 2,
                        style: subtitleFont(
                            fontSize: 18, fontWeight: FontWeight.w800)),
                    Text(subtitle, maxLines: 3),
                  ],
                ),
              ),
              if (endIcon == null)
                CupertinoSwitch(
                  value: false,
                  onChanged: (value) {},
                )
              else
                Icon(endIcon)
            ],
          ),
        ),
      ),
    );
  }
}
