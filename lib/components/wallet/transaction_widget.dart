import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/size.dart';
import '../../features/wallet/model/wallet_model.dart';

class TransactionHistoryWidget extends StatelessWidget {
  const TransactionHistoryWidget({
    super.key,
    required this.history,
  });
  final TransactionHistoryModel history;

  @override
  Widget build(BuildContext context) {
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
              Row(
                children: [
                  Text(DateFormat.yMMMd('en_US').format(
                      DateTime.tryParse(history.date.toString()) ??
                          DateTime.now())),
                  width10,
                  const Icon(
                    Icons.circle,
                    size: 4,
                  ),
                  width10,
                  Text(DateFormat.jms().format(
                      DateTime.tryParse(history.date.toString()) ??
                          DateTime.now())),
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
}
