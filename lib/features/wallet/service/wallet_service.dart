import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_app/features/wallet/model/wallet_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WalletService {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static Future<String> getWalletBalance() async {
    return await FirebaseFirestore.instance
        .collection("wallet")
        .doc(auth.currentUser!.uid)
        .get()
        .then(
          (value) =>
              value.data() == null ? "0" : value.data()!["balance"].toString(),
        );
  }

  static Future<List<TransactionHistoryModel>> getTransactionHistory() async {
    return await FirebaseFirestore.instance
        .collection("wallet")
        .doc(auth.currentUser!.uid)
        .collection("history")
        .orderBy("order")
        .get()
        .then((value) => value.docs
            .map((e) => TransactionHistoryModel.fromJson(e.data()))
            .toList());
  }
}
