import 'package:dartz/dartz.dart';

import 'package:coffee_app/features/auth/service/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_view_model.g.dart';

enum AuthState {
  none,
  profileDetailsSuccess,
  success,
}

@riverpod
class AuthViewModel extends _$AuthViewModel {
  @override
  Either<AuthState, String> build() {
    return left(AuthState.none);
  }

  Future<void> signIn(String email, String password) async {
    try {
      await AuthServices.signInEmailAndPassword(
          email: email, password: password);
      state = left(AuthState.success);
    } catch (e) {
      state = right(e.toString());
    }
  }

  Future<void> signUp(String email, String password) async {
    try {
      await AuthServices.signUpEmailAndPassword(
          email: email, password: password);
      state = left(AuthState.success);
    } catch (e) {
      state = right(e.toString());
    }
  }

  Future<void> createProfile(
      String name, String phoneNumber, String birthDate) async {
    try {
      await AuthServices.createProfile(
          name: name, phoneNumber: phoneNumber, birthDate: birthDate);
      state = left(AuthState.profileDetailsSuccess);
    } catch (e) {
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
