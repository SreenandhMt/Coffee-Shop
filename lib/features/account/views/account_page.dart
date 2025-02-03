import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:coffee_app/route/navigation_utils.dart';

import '../../../components/account/account_option_widget.dart';
import '../../../core/app_colors.dart';
import '../../../core/assets.dart';
import '../../../core/fonts.dart';
import '../../../core/size.dart';
import '../../../localization/locales.dart';

class AccountPage extends ConsumerStatefulWidget {
  const AccountPage({super.key});

  @override
  ConsumerState<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends ConsumerState<AccountPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
            margin: const EdgeInsets.only(left: 20),
            width: 20,
            height: 20,
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(AppAssets.logo)))),
        centerTitle: true,
        title:
            Text(LocaleData.account.getString(context), style: appBarTitleFont),
      ),
      body: ListView(
        children: [
          const ListTile(
            leading: CircleAvatar(
              radius: 35,
              backgroundColor: Colors.black,
            ),
            title: Text(
              "Andrew Ainsley",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            subtitle: Text("andrew.ainsley@yourdomain.com"),
            trailing: Icon(Icons.qr_code_rounded),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
            child: Divider(
              thickness: 0.2,
            ),
          ),
          AccountOptionsWidget(
            title: LocaleData.accountVouchersTitle.getString(context),
            icon: Icons.discount_outlined,
            onTap: () => NavigationUtils.vouchersAndDiscountPage(context),
          ),
          AccountOptionsWidget(
            title: LocaleData.accountPointsTitle.getString(context),
            icon: Icons.monetization_on_outlined,
            onTap: () => NavigationUtils.caffelyPointsPage(context),
          ),
          AccountOptionsWidget(
            title: LocaleData.accountRewardsTitle.getString(context),
            icon: Icons.card_giftcard_outlined,
            onTap: () => NavigationUtils.navigateRewardPage(context),
          ),
          AccountOptionsWidget(
            title: LocaleData.accountFavoriteCoffeeTitle.getString(context),
            icon: Icons.coffee_outlined,
            onTap: () => NavigationUtils.navigateFavoriteCoffeePage(context),
          ),
          AccountOptionsWidget(
            title: LocaleData.accountAddressTitle.getString(context),
            icon: Icons.location_on_outlined,
            onTap: () => NavigationUtils.navigateManageAddressPage(context),
          ),
          AccountOptionsWidget(
            title: LocaleData.accountPaymentTitle.getString(context),
            icon: Icons.payment_outlined,
            onTap: () => NavigationUtils.managePaymentsPage(context),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  LocaleData.accountCategoryGeneral.getString(context),
                  style: TextStyle(color: AppColors.themeTextColor(context)),
                ),
                width15,
                Expanded(
                  child: Container(
                    height: 1,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(50)),
                  ),
                ),
                width10,
              ],
            ),
          ),
          AccountOptionsWidget(
            title: LocaleData.accountPersonalInfoTitle.getString(context),
            icon: CupertinoIcons.person,
            onTap: () => NavigationUtils.personalInfoPage(context),
          ),
          AccountOptionsWidget(
            title: LocaleData.accountNotificationTitle.getString(context),
            icon: Icons.notifications_outlined,
            onTap: () => NavigationUtils.notificationSettingPage(context),
          ),
          AccountOptionsWidget(
            title: LocaleData.accountSecurityTitle.getString(context),
            icon: Icons.shield_outlined,
            onTap: () => NavigationUtils.securitySettingsPage(context),
          ),
          AccountOptionsWidget(
            title: LocaleData.accountLanguageTitle.getString(context),
            icon: Icons.text_format_rounded,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "English (US)",
                  style: TextStyle(fontSize: 16),
                ),
                width10,
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 23,
                  color: AppColors.themeTextColor(context),
                )
              ],
            ),
            onTap: () => NavigationUtils.languageSettingPage(context),
          ),
          AccountOptionsWidget(
              title: LocaleData.accountDarkModeText.getString(context),
              icon: Icons.dark_mode_outlined,
              child: CupertinoSwitch(
                value: true,
                onChanged: (value) {},
                activeTrackColor: AppColors.primaryColor,
              )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  LocaleData.accountCategoryAbout.getString(context),
                  style: TextStyle(color: AppColors.themeTextColor(context)),
                ),
                width15,
                Expanded(
                  child: Container(
                    height: 1,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(50)),
                  ),
                ),
                width10,
              ],
            ),
          ),
          AccountOptionsWidget(
            title: LocaleData.accountHelpCenterTitle.getString(context),
            icon: CupertinoIcons.doc_text,
            onTap: () => NavigationUtils.helpCenterPage(context),
          ),
          AccountOptionsWidget(
            title: LocaleData.accountAboutCaffelyTitle.getString(context),
            icon: Icons.info_outlined,
            onTap: () => NavigationUtils.aboutCaffelyPage(context),
          ),
          AccountOptionsWidget(
            title: LocaleData.accountLogOutText.getString(context),
            icon: Icons.logout,
            color: Colors.red,
            onTap: () => showModalBottomSheet(
              context: context,
              builder: (context) => SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    height20,
                    Text(
                      LocaleData.accountLogOutText.getString(context),
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.red),
                    ),
                    height35,
                    Text(
                      LocaleData.logoutConfirmationMessage.getString(context),
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w600),
                    ),
                    height35,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                AppColors.primaryColor.withOpacity(0.2),
                            shadowColor: Colors.transparent,
                            fixedSize: Size(
                                (MediaQuery.sizeOf(context).width / 2) * 0.9,
                                60),
                          ),
                          onPressed: () {
                            context.pop();
                          },
                          child: Text(
                              LocaleData.cancelButton.getString(context),
                              style: const TextStyle(
                                  color: AppColors.primaryColor, fontSize: 17)),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            fixedSize: Size(
                                (MediaQuery.sizeOf(context).width / 2) * 0.9,
                                60),
                          ),
                          onPressed: () {
                            FirebaseAuth.instance.signOut();
                            context.go("/splash");
                          },
                          child: Text(
                              LocaleData.logoutConfirmationButton
                                  .getString(context),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 17)),
                        ),
                      ],
                    ),
                    height10,
                  ],
                ),
              ),
            ),
            child: const SizedBox(),
          ),
        ],
      ),
    );
  }
}
