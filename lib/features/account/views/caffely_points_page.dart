import 'package:coffee_app/core/app_colors.dart';
import 'package:coffee_app/core/fonts.dart';
import 'package:coffee_app/core/size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
        title: Text("Caffely Points", style: appBarTitleFont),
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
            child: const Column(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Total Caffely Points",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.document_scanner_outlined,
                      color: Colors.white,
                    )
                  ],
                ),
                Text(
                  "25",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Text(
                  "100 points = \$1.00. You can use these points as payment.",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                )
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Text(
                  "Points History",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                ),
                Spacer(),
                Text(
                  "View All",
                  style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                width10,
                Icon(
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
            (index) => _pointHistoryWidget(),
          )
        ],
      ),
    );
  }

  Widget _pointHistoryWidget() {
    return const Padding(
      padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 10),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Your Earn Points",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
              ),
              Spacer(),
              Text(
                "+ 25",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
              ),
            ],
          ),
          height5,
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Dec 22, 2023"),
              width5,
              Icon(
                Icons.circle,
                size: 5,
              ),
              width5,
              Text("09:41:23 AM"),
            ],
          ),
          height10,
          Divider(
            thickness: 0.1,
          )
        ],
      ),
    );
  }
}
