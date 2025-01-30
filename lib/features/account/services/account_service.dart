import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_app/features/home/models/coffee_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AccountService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<List<CoffeeModel>> getFavoriteCoffees() async {
    return await _firestore
        .collection("users")
        .doc(_auth.currentUser!.uid)
        .collection("favorite")
        .get()
        .then((value) => value.docs
            .map(
              (e) => CoffeeModel.fromJson(e.data()),
            )
            .toList());
  }

  static Future<Map<String, dynamic>> getUserData() async {
    return await _firestore
        .collection("users")
        .doc(_auth.currentUser!.uid)
        .get()
        .then((value) => value.data()!);
  }
}
