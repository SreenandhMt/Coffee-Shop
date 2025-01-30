import 'package:coffee_app/core/assets.dart';
import 'package:coffee_app/core/size.dart';
import 'package:coffee_app/features/auth/views/forgot_password/email_conform_page.dart';
import 'package:coffee_app/localization/locales.dart';
import 'package:coffee_app/route/navigation_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

class PointRewardPage extends StatelessWidget {
  const PointRewardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppAssets.rewardedImage),
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                ),
              ),
            ],
          ),
          height20,
          Text(
            LocaleData.orderRewardTitle.getString(context),
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
          ),
          height10,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              LocaleData.orderRewardSubtitle.getString(context),
              style: const TextStyle(),
              textAlign: TextAlign.center,
            ),
          ),
          const Spacer(),
          AuthButton(
            text: LocaleData.orderRewardButton.getString(context),
            onPressed: () {
              NavigationUtils.userResponsePage(context);
            },
          )
        ],
      ),
    );
  }
}
