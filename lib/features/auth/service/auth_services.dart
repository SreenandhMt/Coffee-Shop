import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:github_sign_in/github_sign_in.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:twitter_login/twitter_login.dart';

class AuthServices {
  static FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String apiKey = "MaqcGRRf6aKW3inupVOiHfPmk";
  static const String secretKey =
      "bnk1T6JM6P4jdhqXEuOwBH1CTfS6QgRNY7pqd2ReZ87WPSX7qU";

  static final twitterLogin = TwitterLogin(
    apiKey: apiKey,
    apiSecretKey: secretKey,
    redirectURI: 'twittersdk://',
  );

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

  static Future<UserCredential> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      rethrow;
    }
  }

  static Future<UserCredential> signInWithFacebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);

      return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  static Future<UserCredential> signInWithTwitter() async {
    try {
      final authResult = await twitterLogin.login();

      final twitterAuthCredential = TwitterAuthProvider.credential(
        accessToken: authResult.authToken!,
        secret: authResult.authTokenSecret!,
      );

      return await FirebaseAuth.instance
          .signInWithCredential(twitterAuthCredential);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  static Future<UserCredential> signInWithGithub(BuildContext context) async {
    try {
      final GitHubSignIn gitHubSignIn = GitHubSignIn(
          clientId: "Ov23liKqOv5estXy8kZD",
          clientSecret: "ef97584f6a3ff915c82878e5e828466cad82a068",
          redirectUrl: 'https://flipshopdata.firebaseapp.com/__/auth/handler');

      final result = await gitHubSignIn.signIn(context);

      final githubAuthCredential = GithubAuthProvider.credential(result.token!);

      return await FirebaseAuth.instance
          .signInWithCredential(githubAuthCredential);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  static Future<void> createProfile(
      {required String name,
      required String phoneNumber,
      required String birthDate}) async {
    try {
      _auth = FirebaseAuth.instance;
      _auth.currentUser!.updateDisplayName(name);
      await _firestore.collection("users").doc(_auth.currentUser!.uid).set({
        "email": _auth.currentUser!.email,
        "name": name,
        "phoneNumber": phoneNumber,
        "birthDate": birthDate,
        "profileImage": "",
        "createdAt": FieldValue.serverTimestamp(),
        "uid": _auth.currentUser!.uid,
      });
    } catch (e) {
      rethrow;
    }
  }
}
