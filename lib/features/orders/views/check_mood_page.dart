import 'package:coffee_app/core/app_colors.dart';
import 'package:coffee_app/core/assets.dart';
import 'package:coffee_app/core/size.dart';
import 'package:coffee_app/localization/locales.dart';
import 'package:coffee_app/route/navigation_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

class CheckUserMoodPage extends StatelessWidget {
  const CheckUserMoodPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text(
            LocaleData.userMoodTitle.getString(context),
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
          ),
          Text(LocaleData.userMoodSubtitle.getString(context)),
          height20,
          Expanded(
            child: SingleChildScrollView(
              child: Wrap(
                runSpacing: 10,
                spacing: 15,
                alignment: WrapAlignment.spaceBetween,
                children: List.generate(
                  12,
                  (index) => Padding(
                    padding: const EdgeInsets.only(bottom: 15, top: 10),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: index != 1
                              ? null
                              : Border.all(
                                  width: 4, color: AppColors.primaryColor),
                          borderRadius: BorderRadius.circular(20)),
                      child: Image.asset(AppAssets.emoji(context, index + 1),
                          width: (size.width / 2) * 0.5),
                    ),
                  ),
                ),
              ),
            ),
          ),
          height10,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor.withOpacity(0.2),
                  shadowColor: Colors.transparent,
                  fixedSize:
                      Size((MediaQuery.sizeOf(context).width / 2) * 0.9, 60),
                ),
                onPressed: () {
                  NavigationUtils.ratingDriverPage(context);
                },
                child: Text(LocaleData.cancelButton.getString(context),
                    style: const TextStyle(
                        color: AppColors.primaryColor, fontSize: 17)),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  fixedSize:
                      Size((MediaQuery.sizeOf(context).width / 2) * 0.9, 60),
                ),
                onPressed: () {
                  NavigationUtils.ratingDriverPage(context);
                },
                child: Text(LocaleData.submitButton.getString(context),
                    style: const TextStyle(color: Colors.white, fontSize: 17)),
              ),
            ],
          ),
          height10,
        ],
      ),
    );
  }
}
