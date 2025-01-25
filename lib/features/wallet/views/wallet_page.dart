import 'package:coffee_app/route/navigation_utils.dart';
import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';
import '../../../core/assets.dart';
import '../../../core/fonts.dart';
import '../../../core/size.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
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
        title: Text("Wallet", style: appBarTitleFont),
        actions: const [
          Icon(
            Icons.search_rounded,
            size: 30,
          ),
          width10,
        ],
      ),
      body: ListView(
        children: [
          _walletCardWidget(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                const Text(
                  "Transaction History",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () => NavigationUtils.transactionHistoryPage(context),
                  child: const Row(
                    children: [
                      Text(
                        "See All",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      width5,
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: AppColors.primaryColor,
                        size: 20,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          height10,
          ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => transactionWidget(),
              separatorBuilder: (context, index) => const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Divider(thickness: 0.2),
                  ),
              itemCount: 5)
        ],
      ),
    );
  }

  Widget transactionWidget() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        children: [
          Column(
            spacing: 5,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Classic Brew",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Row(
                children: [
                  Text("Dec 22, 2023"),
                  width10,
                  Icon(
                    Icons.circle,
                    size: 4,
                  ),
                  width10,
                  Text("09:41:20 AM"),
                ],
              )
            ],
          ),
          Spacer(),
          Column(
            spacing: 5,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "-\$4.20",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text("Caffely Wallet"),
            ],
          )
        ],
      ),
    );
  }

  Widget _walletCardWidget() {
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
            "Anrew Ainsley",
            style: subtitleFont(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 15.6,
            ),
          ),
          const Spacer(),
          const Text(
            "Your Balance",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          height5,
          Row(
            children: [
              const Text(
                "\$948.50",
                style: TextStyle(
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
                  child: const Row(
                    children: [
                      Icon(Icons.cloud_download_rounded),
                      width5,
                      Text("Top Up",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600))
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
