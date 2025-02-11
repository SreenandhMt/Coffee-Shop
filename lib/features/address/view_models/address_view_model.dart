import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:coffee_app/features/address/models/address_model.dart';
import 'package:coffee_app/features/address/services/address_service.dart';

part 'address_view_model.g.dart';

class AddressState {
  final List<AddressModel> addresses;
  final AddressModel? selectedAddress;
  final bool isLoading;
  final String state;
  final String userAddress;

  AddressState(
      {required this.addresses,
      this.selectedAddress,
      required this.isLoading,
      required this.state,
      required this.userAddress});

  factory AddressState.initial() {
    return AddressState(
        state: "", addresses: [], isLoading: false, userAddress: "");
  }

  AddressState copyWith(
      {List<AddressModel>? addresses,
      bool? isLoading,
      String? userAddress,
      AddressModel? selectedAddress,
      String? state}) {
    return AddressState(
      state: state ?? this.state,
      addresses: addresses ?? this.addresses,
      isLoading: isLoading ?? this.isLoading,
      userAddress: userAddress ?? this.userAddress,
      selectedAddress: selectedAddress ?? this.selectedAddress,
    );
  }
}

@riverpod
class AddressViewModel extends _$AddressViewModel {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  AddressState build() {
    return AddressState.initial();
  }

  void getAddresses() async {
    state = state.copyWith(isLoading: true);
    final addresses = await AddressService.getAddresses();
    addresses.fold((l) => debugPrint(l),
        (r) => state = state.copyWith(addresses: r, isLoading: false));
  }

  void setUserCurrentAddress(String address, String states) {
    if (state.selectedAddress != null) {
      AddressModel userAddress = state.selectedAddress!;
      userAddress = userAddress.copyWith(address: address);
      state = state.copyWith(selectedAddress: userAddress);
    }
    state = state.copyWith(userAddress: address, state: states);
  }

  void removeAddress(String id) async {
    state = state.copyWith(
        addresses:
            state.addresses.where((element) => element.id != id).toList());
    await AddressService.deleteAddress(id);
  }

  void selectAddress(id) {
    removeSelectedValues(id: id);
  }

  void saveAddress(
      {required String title,
      required String name,
      String? note,
      required String number,
      bool isSelected = false}) async {
    AddressModel? address = state.selectedAddress;
    if (address != null) {
      address = address.copyWith(
        isSelected: isSelected,
        name: name,
        phoneNumber: number,
        title: title,
      );
      await AddressService.changeAddress(address);
    }
  }

  void changeAddress(AddressModel address) {
    state = state.copyWith(selectedAddress: address);
  }

  Future<void> removeSelectedValues({String? id}) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    state = state.copyWith(
      addresses: state.addresses
          .map((a) => a.id == id
              ? a.copyWith(isSelected: true)
              : a.copyWith(isSelected: false))
          .toList(),
    );

    await firestore
        .collection('users')
        .doc(userId)
        .collection('address')
        .get()
        .then(
      (value) async {
        final addressRef =
            firestore.collection('users').doc(userId).collection('address');

        for (var doc in value.docs) {
          if (doc.exists && doc["id"] != id && doc["isSelected"] == true) {
            if (doc["id"] != id) {
              await addressRef.doc(doc["id"]).update({"isSelected": false});
            }
          }
        }
        if (id != null) {
          await addressRef.doc(id).update({"isSelected": true});
        }
      },
    );
  }

  Future<void> addAddress({
    required String title,
    required String userName,
    String? note,
    required String number,
    required bool isSelected,
  }) async {
    state = state.copyWith(isLoading: true);
    if (isSelected) {
      await removeSelectedValues();
    }
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    final address = AddressModel(
        title: title,
        name: userName,
        note: note,
        id: id,
        phoneNumber: number,
        isSelected: isSelected,
        uid: FirebaseAuth.instance.currentUser!.uid,
        address: state.userAddress);
    await AddressService.addAddresses(address.toJson());
    final list = state.addresses;
    list.add(address);
    state = state.copyWith(addresses: list, isLoading: false);
  }
}
