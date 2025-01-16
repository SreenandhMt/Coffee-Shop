import 'package:coffee_app/core/fonts.dart';
import 'package:coffee_app/core/size.dart';
import 'package:coffee_app/features/auth/views/forgot_password/email_conform_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
        title: Text('Caffely Rewards', style: appBarTitleFont),
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
          const Text(
            "Get Free Coffee!",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
          ),
          const Text(
            "Get a free coffee discount voucher every time your friend joins via your referral code.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 17),
          ),
          Container(
            width: double.infinity,
            height: 350,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.secondaryColor(context)),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
          const Text(
            "Copy or share the referral code below",
            style: TextStyle(fontSize: 14),
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
          AuthButton(text: "Share Referral Code", onPressed: () {})
        ],
      ),
    );
  }
}
