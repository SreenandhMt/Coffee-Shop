import 'dart:developer';

import 'package:coffee_app/features/address/models/address_model.dart';
import 'package:coffee_app/features/address/services/address_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'address_view_model.g.dart';

class AddressState {
  final List<AddressModel> addresses;
  final bool isLoading;

  AddressState({required this.addresses, required this.isLoading});

  factory AddressState.initial() {
    return AddressState(addresses: [], isLoading: false);
  }

  AddressState copyWith({
    List<AddressModel>? addresses,
    bool? isLoading,
  }) {
    return AddressState(
      addresses: addresses ?? this.addresses,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

@riverpod
class AddressViewModel extends _$AddressViewModel {
  @override
  AddressState build() {
    return AddressState.initial();
  }

  void getAddresses() async {
    state = state.copyWith(isLoading: true);
    final addresses = await AddressService.getAddresses();
    addresses.fold((l) => log(l),
        (r) => state = state.copyWith(addresses: r, isLoading: false));
  }
}
