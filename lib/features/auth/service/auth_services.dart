import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<UserCredential> signInEmailAndPassword(
      {required String email, required String password}) async {
    try {
      AuthCredential credential =
          EmailAuthProvider.credential(email: email, password: password);

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      return userCredential;
    } catch (e) {
      rethrow;
    }
  }

  static Future<UserCredential> signUpEmailAndPassword(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> createProfile(
      {required String name,
      required String phoneNumber,
      required String birthDate}) async {
    try {
      await _firestore.collection("users").doc(_auth.currentUser!.uid).set({
        "email": _auth.currentUser!.email,
        "name": name,
        "phoneNumber": phoneNumber,
        "birthDate": birthDate,
        "createdAt": FieldValue.serverTimestamp(),
        "uid": _auth.currentUser!.uid,
      });
    } catch (e) {
      rethrow;
    }
  }
}
