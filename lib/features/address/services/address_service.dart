import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/address_model.dart';

//TODO save user coordinates and add change address and shear address

class AddressService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<void> deleteAddress(String id) async {
    await _firestore
        .collection("users")
        .doc(_auth.currentUser!.uid)
        .collection("address")
        .doc(id)
        .delete();
  }

  static Future<Either<String, List<AddressModel>>> getAddresses() async {
    try {
      return await _firestore
          .collection("users")
          .doc(_auth.currentUser!.uid)
          .collection("address")
          .limit(5)
          .get()
          .then(
        (value) {
          log(value.toString());
          List<AddressModel> address = [];
          for (var element in value.docs) {
            address.add(AddressModel.fromJson(element.data()));
          }
          return right(address);
        },
      );
    } catch (e) {
      log(e.toString());
      return left(e.toString());
    }
  }

  static Future<void> addAddresses(Map<String, dynamic> map) async {
    try {
      map.addEntries({"date": DateTime.now().microsecondsSinceEpoch}.entries);
      await _firestore
          .collection("users")
          .doc(_auth.currentUser!.uid)
          .collection("address")
          .doc(map["id"])
          .set(map)
          .onError(
            (error, stackTrace) => log(error.toString()),
          );
      log(map["id"].toString());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  static Future<void> changeAddress(AddressModel address) async {
    await _firestore
        .collection("users")
        .doc(_auth.currentUser!.uid)
        .collection("address")
        .doc(address.id)
        .update(address.toJson());
  }
}
