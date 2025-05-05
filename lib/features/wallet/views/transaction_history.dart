import 'package:coffee_app/core/fonts.dart';
import 'package:coffee_app/core/size.dart';
import 'package:coffee_app/localization/locales.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../components/wallet/transaction_widget.dart';
import '../model/wallet_model.dart';
import '../view_models/wallet_view_model.dart';

class TransactionHistory extends ConsumerStatefulWidget {
  const TransactionHistory({super.key});

  @override
  ConsumerState<TransactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends ConsumerState<TransactionHistory> {
  @override
  Widget build(BuildContext context) {
    final walletModel = ref.watch(walletViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          LocaleData.walletTransactionHistory,
          style: appBarTitleFont,
        ),
        actions: const [
          Icon(Icons.search_rounded, size: 30),
          width5,
        ],
      ),
      body: ListView.separated(
          itemBuilder: (context, index) => TransactionHistoryWidget(
              history: walletModel.historyModel[index]),
          separatorBuilder: (context, index) => const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Divider(thickness: 0.2),
              ),
          itemCount: walletModel.historyModel.length),
    );
  }
}
