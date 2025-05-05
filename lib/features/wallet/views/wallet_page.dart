import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:coffee_app/features/wallet/model/wallet_model.dart';
import 'package:coffee_app/features/wallet/view_models/wallet_view_model.dart';
import 'package:coffee_app/features/wallet/views/wallet_loading.dart';
import 'package:coffee_app/localization/locales.dart';
import 'package:coffee_app/route/navigation_utils.dart';

import '../../../components/wallet/transaction_widget.dart';
import '../../../components/wallet/wallet_widget.dart';
import '../../../core/app_colors.dart';
import '../../../core/assets.dart';
import '../../../core/fonts.dart';
import '../../../core/size.dart';

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
      body: walletModel.isLoading
          ? const WalletLoadingPage()
          : ListView(
              children: [
                WalletCardWidget(balance: walletModel.balance),
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
                        onTap: () =>
                            NavigationUtils.transactionHistoryPage(context),
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
                    itemBuilder: (context, index) => TransactionHistoryWidget(
                        history: walletModel.historyModel[index]),
                    separatorBuilder: (context, index) => const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Divider(thickness: 0.2),
                        ),
                    itemCount: walletModel.historyModel.length)
              ],
            ),
    );
  }
}
