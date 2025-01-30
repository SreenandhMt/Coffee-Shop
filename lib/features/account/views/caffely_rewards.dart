import 'package:coffee_app/core/fonts.dart';
import 'package:coffee_app/core/size.dart';
import 'package:coffee_app/features/auth/views/forgot_password/email_conform_page.dart';
import 'package:coffee_app/localization/locales.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

import '../../../core/app_colors.dart';

class CaffelyRewardsPage extends StatefulWidget {
  const CaffelyRewardsPage({super.key});

  @override
  State<CaffelyRewardsPage> createState() => _CaffelyRewardsPageState();
}

class _CaffelyRewardsPageState extends State<CaffelyRewardsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(LocaleData.accountRewardsTitle.getString(context),
            style: appBarTitleFont),
        actions: const [
          Icon(Icons.info_outline),
          width5,
        ],
      ),
      body: Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          height10,
          Text(
            LocaleData.caffelyRewardTitle.getString(context),
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
          ),
          Text(
            LocaleData.caffelyRewardSubtitle.getString(context),
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 17),
          ),
          Container(
            width: double.infinity,
            height: 350,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.secondaryColor(context)),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
          Text(
            LocaleData.caffelyShareNote.getString(context),
            style: const TextStyle(fontSize: 14),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            margin:
                const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.secondaryColor(context)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SelectableText(
                  "XM4LWP3",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.copy_rounded))
              ],
            ),
          ),
          const Spacer(),
          AuthButton(
              text: LocaleData.caffelyButton.getString(context),
              onPressed: () {})
        ],
      ),
    );
  }
}
