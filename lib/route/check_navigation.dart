// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_app/route/navigation_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

Future<void> checkAuthStatus(BuildContext context, bool mounted) async {
  if (FirebaseAuth.instance.currentUser != null) {
    navigateToHome(context, mounted);
  } else {
    if (!mounted) return;
    navigateToAuthScreen(context, mounted);
  }
}

void navigateToAuthScreen(BuildContext context, bool mounted) async {
  final prefs = await SharedPreferences.getInstance();
  final isFirstTime = prefs.getBool('isFirstTime');
  if (isFirstTime == null || isFirstTime == true) {
    if (!mounted) return;
    NavigationUtils.introductionPage(context);
  } else {
    if (!mounted) return;
    context.go('/welcome');
  }
}

void navigateToHome(BuildContext context, bool mounted) async {
  final hasProfile = await _firestore
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .get()
      .then((value) => value.exists);
  if (hasProfile) {
    if (!mounted) return;
    NavigationUtils.replaceHomePage(context);
  } else {
    if (!mounted) return;
    context.go('/welcome/signup/profileDetails');
  }
}
