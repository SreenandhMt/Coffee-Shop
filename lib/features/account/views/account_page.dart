import 'package:coffee_app/route/navigation_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/app_colors.dart';
import '../../../core/assets.dart';
import '../../../core/fonts.dart';
import '../../../core/size.dart';
import '../../../localization/locales.dart';
import '../view_models/account_view_model.dart';

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
          _accountOptionWidget(
            LocaleData.accountVouchersTitle.getString(context),
            Icons.discount_outlined,
            onTap: () => NavigationUtils.vouchersAndDiscountPage(context),
          ),
          _accountOptionWidget(
            LocaleData.accountPointsTitle.getString(context),
            Icons.monetization_on_outlined,
            onTap: () => NavigationUtils.caffelyPointsPage(context),
          ),
          _accountOptionWidget(
            LocaleData.accountRewardsTitle.getString(context),
            Icons.card_giftcard_outlined,
            onTap: () => NavigationUtils.navigateRewardPage(context),
          ),
          _accountOptionWidget(
            LocaleData.accountFavoriteCoffeeTitle.getString(context),
            Icons.coffee_outlined,
            onTap: () => NavigationUtils.navigateFavoriteCoffeePage(context),
          ),
          _accountOptionWidget(
            LocaleData.accountAddressTitle.getString(context),
            Icons.location_on_outlined,
            onTap: () => NavigationUtils.navigateManageAddressPage(context),
          ),
          _accountOptionWidget(
            LocaleData.accountPaymentTitle.getString(context),
            Icons.payment_outlined,
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
          _accountOptionWidget(
            LocaleData.accountPersonalInfoTitle.getString(context),
            CupertinoIcons.person,
            onTap: () => NavigationUtils.personalInfoPage(context),
          ),
          _accountOptionWidget(
            LocaleData.accountNotificationTitle.getString(context),
            Icons.notifications_outlined,
            onTap: () => NavigationUtils.notificationSettingPage(context),
          ),
          _accountOptionWidget(
            LocaleData.accountSecurityTitle.getString(context),
            Icons.shield_outlined,
            onTap: () => NavigationUtils.securitySettingsPage(context),
          ),
          _accountOptionWidget(
            LocaleData.accountLanguageTitle.getString(context),
            Icons.text_format_rounded,
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "English (US)",
                  style: TextStyle(fontSize: 16),
                ),
                width10,
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 23,
                  color: Colors.black54,
                )
              ],
            ),
            onTap: () => NavigationUtils.languageSettingPage(context),
          ),
          _accountOptionWidget(
              LocaleData.accountDarkModeText.getString(context),
              Icons.dark_mode_outlined,
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
          _accountOptionWidget(
            LocaleData.accountHelpCenterTitle.getString(context),
            CupertinoIcons.doc_text,
            onTap: () => NavigationUtils.helpCenterPage(context),
          ),
          _accountOptionWidget(
            LocaleData.accountAboutCaffelyTitle.getString(context),
            Icons.info_outlined,
            onTap: () => NavigationUtils.aboutCaffelyPage(context),
          ),
          _accountOptionWidget(
            LocaleData.accountLogOutText.getString(context),
            Icons.logout,
            child: const SizedBox(),
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
          ),
        ],
      ),
    );
  }

  Widget _accountOptionWidget(String title, IconData icon,
      {Widget? child, Color? color, void Function()? onTap}) {
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
