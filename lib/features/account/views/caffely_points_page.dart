import 'package:coffee_app/core/app_colors.dart';
import 'package:coffee_app/core/fonts.dart';
import 'package:coffee_app/core/size.dart';
import 'package:coffee_app/localization/locales.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

import '../../../components/account/caffely_point_widget.dart';

class CaffelyPointsPage extends StatefulWidget {
  const CaffelyPointsPage({super.key});

  @override
  State<CaffelyPointsPage> createState() => _CaffelyPointsPageState();
}

class _CaffelyPointsPageState extends State<CaffelyPointsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(LocaleData.accountPointsTitle.getString(context),
            style: appBarTitleFont),
        actions: const [
          Icon(Icons.info_outlined),
          width5,
        ],
      ),
      body: ListView(
        children: [
          Container(
            width: double.infinity,
            height: 150,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: AppColors.primaryColor,
            ),
            child: Column(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      LocaleData.totalPointText.getString(context),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.document_scanner_outlined,
                      color: Colors.white,
                    )
                  ],
                ),
                const Text(
                  "25",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Text(
                  LocaleData.pointValueText.getString(context),
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Text(
                  LocaleData.pointHistoryTitle.getString(context),
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w800),
                ),
                const Spacer(),
                Text(
                  LocaleData.viewAll.getString(context),
                  style: const TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                width10,
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 23,
                  color: AppColors.primaryColor,
                )
              ],
            ),
          ),
          height10,
          ...List.generate(
            10,
            (index) => const PointHistoryWidget(),
          )
        ],
      ),
    );
  }
}
