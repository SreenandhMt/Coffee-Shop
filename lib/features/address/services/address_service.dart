import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/address_model.dart';

class AddressService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<void> deleteAddress(String id) async {
    await _firestore.collection('address').doc(id).delete();
  }

  static Future<Either<String, List<AddressModel>>> getAddresses() async {
    try {
      return await _firestore.collection("address").get().then(
        //TODO: .where("uid", isEqualTo: _auth.currentUser!.uid) add this to find only user address
        (value) {
          List<AddressModel> address = [];
          for (var element in value.docs) {
            address.add(AddressModel.fromJson(element.data()));
          }
          return right(address);
        },
      );
    } catch (e) {
      return left(e.toString());
    }
  }
}
