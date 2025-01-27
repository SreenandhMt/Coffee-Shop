import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NotificationService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<Either<String, List<Map<String, dynamic>>>>
      getNotifications() async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        return left('User not logged in');
      }
      final snapshot = await _firestore.collection('notifications').get();

      ///add the where("uid",isEqualTo: _auth.currentUser.uid) to get only user notification
      final notifications = snapshot.docs.map((doc) => doc.data()).toList();
      return right(notifications);
    } catch (e) {
      return left(e.toString());
    }
  }
}
