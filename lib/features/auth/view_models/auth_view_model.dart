import 'dart:developer';
import 'package:dartz/dartz.dart';

import 'package:coffee_app/features/auth/service/auth_services.dart';
import 'package:coffee_app/route/navigation_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import "package:cloud_firestore/cloud_firestore.dart";

import '../views/signin_page.dart';

part 'auth_view_model.g.dart';

enum AuthState {
  welcome,
  signin,
  signup,
  profileDetails,
  success,
}

@riverpod
class AuthViewModel extends _$AuthViewModel {
  @override
  Either<AuthState, String> build() {
    return left(AuthState.welcome);
  }

  Future<void> signIn(String email, String password) async {
    try {
      state = left(AuthState.signin);
      await AuthServices.signInEmailAndPassword(
          email: email, password: password);
      state = left(AuthState.success);
    } catch (e) {
      state = right(e.toString());
    }
  }

  Future<void> signUp(String email, String password) async {
    try {
      state = left(AuthState.signup);
      await AuthServices.signUpEmailAndPassword(
          email: email, password: password);
      state = left(AuthState.profileDetails);
    } catch (e) {
      state = right(e.toString());
    }
  }

  Future<void> createProfile(
      String name, String phoneNumber, String birthDate) async {
    try {
      state = left(AuthState.profileDetails);
      await AuthServices.createProfile(
          name: name, phoneNumber: phoneNumber, birthDate: birthDate);
      state = left(AuthState.success);
    } catch (e) {
      state = right(e.toString());
    }
  }
}

class AuthViewModeld extends ChangeNotifier {
  bool _loading = false;
  int? _otp;

  bool get loading => _loading;
  int? get otp => _otp;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  setOTP(int otp) {
    _otp = otp;
  }

  Future<void> signin(
      String email, String password, BuildContext context, bool mounted) async {
    setLoading(true);
    try {
      if (!mounted) {
        setLoading(false);
        return;
      }
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => DialogBox(
              autoFunction: () {
                if (!mounted) return;
                NavigationUtils.replaceHomePage(context);
              },
              icon: Icons.person,
              title: "Sign in Successful!",
              subtitle:
                  "Please wait... \n Your will be directed to the home page."));
    } on FirebaseException catch (error) {
      log(error.toString());
    } catch (e) {
      log(e.toString());
    }
    setLoading(false);
  }

  Future<void> signup(
      String email, String password, BuildContext context, bool mounted) async {
    setLoading(true);
    try {
      await AuthServices.signUpEmailAndPassword(
          email: email, password: password);
      if (!mounted) {
        setLoading(false);
        return;
      }
      context.push('/welcome/signup/profileDetails');
    } catch (e) {
      log(e.toString());
    }
    setLoading(false);
  }

  createProfile(String name, String phoneNumber, String birthDate,
      BuildContext context, bool mounted) async {
    setLoading(true);
    await Future.delayed(
        const Duration(seconds: 2)); //TODO: add create profile service
    if (!mounted) {
      setLoading(false);
      return;
    }
    setLoading(false);
  }

  sendOTP(String email) async {
    setLoading(true);
    await Future.delayed(
        const Duration(seconds: 2)); //TODO: add send otp service
    setOTP(1234);
    setLoading(false);
  }

  reSendOTP(String email) async {
    setLoading(true);
    await Future.delayed(
        const Duration(seconds: 2)); //TODO: add resend otp service
    setOTP(1235);
    setLoading(false);
  }

  createNewPassword(
      String email, String password, BuildContext context, bool mounted) async {
    setLoading(true);
    await Future.delayed(
        const Duration(seconds: 2)); //TODO: add create new password service
    if (!mounted) {
      setLoading(false);
      return;
    }
    await signin(email, password, context, mounted);
    setLoading(false);
  }

  /// add validators
  ///
}
