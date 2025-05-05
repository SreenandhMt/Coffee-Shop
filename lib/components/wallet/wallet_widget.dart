import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

import '../../core/app_colors.dart';
import '../../core/fonts.dart';
import '../../core/size.dart';
import '../../localization/locales.dart';
import '../../route/navigation_utils.dart';

class WalletCardWidget extends StatelessWidget {
  const WalletCardWidget({
    super.key,
    required this.balance,
  });
  final String balance;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 210,
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            FirebaseAuth.instance.currentUser != null
                ? FirebaseAuth.instance.currentUser!.displayName ?? ""
                : "",
            style: subtitleFont(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 15.6,
            ),
          ),
          const Spacer(),
          Text(
            LocaleData.walletBalance.getString(context),
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          height5,
          Row(
            children: [
              Text(
                balance,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () => NavigationUtils.topUpPage(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.cloud_download_rounded,
                        color: Colors.black,
                      ),
                      width5,
                      Text(
                        LocaleData.walletAddMoney.getString(context),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          height5,
        ],
      ),
    );
  }
}
