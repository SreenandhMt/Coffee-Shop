import 'package:coffee_app/core/fonts.dart';
import 'package:coffee_app/core/size.dart';
import 'package:coffee_app/localization/locales.dart';
import 'package:flutter/material.dart';

class TransactionHistory extends StatefulWidget {
  const TransactionHistory({super.key});

  @override
  State<TransactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  @override
  Widget build(BuildContext context) {
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
          itemBuilder: (context, index) => transactionWidget(),
          separatorBuilder: (context, index) => const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Divider(thickness: 0.2),
              ),
          itemCount: 15),
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
}
