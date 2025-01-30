import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:coffee_app/features/account/services/account_service.dart';
import 'package:coffee_app/features/home/models/coffee_model.dart';

part 'account_view_model.g.dart';

class AccountState {
  final List<CoffeeModel> favoriteCoffees;
  final bool isLoading;
  final Map<String, dynamic> userData;

  AccountState({
    required this.favoriteCoffees,
    required this.isLoading,
    required this.userData,
  });

  factory AccountState.initial() {
    return AccountState(favoriteCoffees: [], isLoading: false, userData: {});
  }

  AccountState copyWith({
    List<CoffeeModel>? favoriteCoffees,
    bool? isLoading,
    Map<String, dynamic>? userData,
  }) {
    return AccountState(
        favoriteCoffees: favoriteCoffees ?? this.favoriteCoffees,
        isLoading: isLoading ?? this.isLoading,
        userData: userData ?? this.userData);
  }
}

@riverpod
class AccountViewModel extends _$AccountViewModel {
  @override
  AccountState build() {
    return AccountState.initial();
  }

  void getFavoriteCoffees() async {
    state = state.copyWith(isLoading: true);
    final favoriteCoffees = await AccountService.getFavoriteCoffees();
    state = state.copyWith(
      favoriteCoffees: favoriteCoffees,
      isLoading: false,
    );
  }

  Future<void> getUserData() async {
    final userData = await AccountService.getUserData();
    state = state.copyWith(userData: userData);
  }
}
