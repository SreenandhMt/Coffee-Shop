import 'package:coffee_app/core/fonts.dart';
import 'package:coffee_app/core/size.dart';
import 'package:coffee_app/features/auth/views/forgot_password/email_conform_page.dart';
import 'package:coffee_app/localization/locales.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/app_colors.dart';
import '../view_models/home_view_model.dart';

class OfferDetailsPage extends ConsumerWidget {
  const OfferDetailsPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final homeState = ref.watch(homeViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(LocaleData.offerPageAppBarTitle.getString(context),
            style: appBarTitleFont),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView(
              children: [
                Container(
                  width: double.infinity,
                  height: 200,
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.secondaryColor(context),
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: NetworkImage(homeState.selectedBanner!.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 5, bottom: 10),
                  child: Text(homeState.selectedBanner!.title,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w800)),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    homeState.selectedBanner!.description,
                    style:
                        subtitleFont(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(
                      left: 20, right: 20, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.secondaryColor(context)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SelectableText(
                        homeState.selectedBanner!.code,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.copy_rounded))
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 15, bottom: 15),
                  margin: const EdgeInsets.only(
                      left: 15, right: 15, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                          color: AppColors.themeColor(context), width: 0.3)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.access_time_filled_rounded,
                            color: AppColors.primaryColor,
                          ),
                          width10,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Valid unit",
                                style: subtitleFont(
                                    fontSize: 13, fontWeight: FontWeight.w400),
                              ),
                              height5,
                              Text(
                                homeState.selectedBanner!.validDate,
                                style: const TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w700),
                              )
                            ],
                          )
                        ],
                      ),
                      Container(
                          width: 0.5,
                          height: 30,
                          color: AppColors.themeColor(context)),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.payment_rounded,
                            color: AppColors.primaryColor,
                          ),
                          width10,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Min transaction",
                                style: subtitleFont(
                                    fontSize: 13, fontWeight: FontWeight.w400),
                              ),
                              height5,
                              Text(
                                "\$${homeState.selectedBanner!.minPrice}",
                                style: const TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w700),
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20, top: 5, bottom: 10),
                  child: Text("Terms and Conditions",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                ),
                ...List.generate(
                  homeState.selectedBanner!.termsAndCondition.length,
                  (index) => Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Text(
                              "${index + 1}.",
                              style: subtitleFont(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                      width10,
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              homeState
                                  .selectedBanner!.termsAndCondition[index],
                              style: subtitleFont(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      width10,
                    ],
                  ),
                ),
                height10,
              ],
            ),
          ),
          AuthButton(
              text: LocaleData.offerClaimButton.getString(context),
              onPressed: () {})
        ],
      ),
    );
  }
}
