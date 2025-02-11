import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:coffee_app/features/wallet/model/wallet_model.dart';
import 'package:coffee_app/features/wallet/service/wallet_service.dart';

part 'wallet_view_model.g.dart';

class WalletState {
  final String balance;
  final List<TransactionHistoryModel> historyModel;

  WalletState({
    required this.balance,
    required this.historyModel,
  });

  factory WalletState.initial() {
    return WalletState(balance: "0", historyModel: []);
  }

  WalletState copyWith({
    String? balance,
    List<TransactionHistoryModel>? historyModel,
  }) {
    return WalletState(
      balance: balance ?? this.balance,
      historyModel: historyModel ?? this.historyModel,
    );
  }
}

@riverpod
class WalletViewModel extends _$WalletViewModel {
  @override
  WalletState build() {
    return WalletState.initial();
  }

  void initWallets() async {
    try {
      final response = await WalletService.getWalletBalance();
      log(response.toString());
      final historyResponse = await WalletService.getTransactionHistory();
      state = state.copyWith(
        balance: response,
        historyModel: historyResponse,
      );
    } catch (e) {
      log(e.toString());
    }
  }
}
