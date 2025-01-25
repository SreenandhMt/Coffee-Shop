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
      log("sss");
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
      log(e.toString());
      state = right(e.toString());
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      await AuthServices.signInWithGoogle();
      state = left(AuthState.success);
    } catch (e) {
      state = right(e.toString());
    }
  }

  Future<void> signInWithTwitter() async {
    try {
      await AuthServices.signInWithTwitter();
      state = left(AuthState.success);
    } catch (e) {
      state = right(e.toString());
    }
  }

  Future<void> signInWithGithub(BuildContext context) async {
    try {
      await AuthServices.signInWithGithub(context);
      state = left(AuthState.success);
    } catch (e) {
      state = right(e.toString());
    }
  }

  Future<void> signInWithFacebook() async {
    try {
      await AuthServices.signInWithFacebook();
      state = left(AuthState.success);
    } catch (e) {
      state = right(e.toString());
    }
  }
}
