import 'package:coffee_app/core/size.dart';
import 'package:coffee_app/features/account/views/notification_settings_page.dart';
import 'package:coffee_app/localization/locales.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

import '../../../core/app_colors.dart';
import '../../../core/fonts.dart';

class SecuritySettingsPage extends StatefulWidget {
  const SecuritySettingsPage({super.key});

  @override
  State<SecuritySettingsPage> createState() => _SecuritySettingsPageState();
}

class _SecuritySettingsPageState extends State<SecuritySettingsPage> {
  List<String> securitySettings = [
    "Remember me",
    "Biometric ID",
    "Face ID",
    "Password",
    "SMS Authenticator",
    "Google Authenticator"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(LocaleData.accountSecurityTitle.getString(context),
            style: appBarTitleFont),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            ...List.generate(
              securitySettings.length,
              (index) => TextWithSwitch(text: securitySettings[index]),
            ),
            height5,
            const Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Device Management",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
                  ),
                  Spacer(),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 25,
                  ),
                  width5,
                ],
              ),
            ),
            height20,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shadowColor: Colors.transparent,
                    backgroundColor: AppColors.primaryColor.withOpacity(0.2),
                    fixedSize: Size(MediaQuery.sizeOf(context).width * 0.9, 60),
                  ),
                  onPressed: () {},
                  child: const Text("Change Password",
                      style: TextStyle(
                          color: AppColors.primaryColor, fontSize: 17)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
