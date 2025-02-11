import 'package:coffee_app/features/wallet/model/wallet_model.dart';
import 'package:coffee_app/features/wallet/view_models/wallet_view_model.dart';
import 'package:coffee_app/localization/locales.dart';
import 'package:coffee_app/route/navigation_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/app_colors.dart';
import '../../../core/assets.dart';
import '../../../core/fonts.dart';
import '../../../core/size.dart';

//TODO add service and viewmodel and add user real value with payment history and balance and also show on the checkout page and if user dont have cash show failed order masssage

class WalletPage extends ConsumerStatefulWidget {
  const WalletPage({super.key});

  @override
  ConsumerState<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends ConsumerState<WalletPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) =>
        ref.read(walletViewModelProvider.notifier).initWallets());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final walletModel = ref.watch(walletViewModelProvider);
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
            Text(LocaleData.wallet.getString(context), style: appBarTitleFont),
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
          _walletCardWidget(walletModel.balance),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Text(
                  LocaleData.walletTransactionHistory.getString(context),
                  style: const TextStyle(
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
              itemBuilder: (context, index) =>
                  transactionWidget(walletModel.historyModel[index]),
              separatorBuilder: (context, index) => const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Divider(thickness: 0.2),
                  ),
              itemCount: walletModel.historyModel.length)
        ],
      ),
    );
  }

  Widget transactionWidget(TransactionHistoryModel history) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        children: [
          Column(
            spacing: 5,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                history.name,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Row(
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
          const Spacer(),
          Column(
            spacing: 5,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                history.amount,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(history.paymentMethod),
            ],
          )
        ],
      ),
    );
  }

  Widget _walletCardWidget(String balance) {
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
