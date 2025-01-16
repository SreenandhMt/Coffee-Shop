import 'package:coffee_app/route/go_router.dart';
import 'package:coffee_app/route/navigation_utils.dart';
import 'package:flutter/material.dart';

import '../views/signin_page.dart';

class AuthViewModel extends ChangeNotifier {
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

  signin(
      String email, String password, BuildContext context, bool mounted) async {
    setLoading(true);
    await Future.delayed(const Duration(seconds: 2)); //TODO: add signin service
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
    setLoading(false);
  }

  signup(String email, String password) async {
    setLoading(true);
    await Future.delayed(const Duration(seconds: 2)); //TODO: add signup service
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
    NavigationUtils.showAuthSuccessPage(context);
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
