
import 'package:flutter/material.dart';

class AuthViewModel extends ChangeNotifier {
  bool _loading = false;
  int? _otp;

  bool get loading => _loading;
  int? get otp => _otp;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  setOTP(int otp)
  {
    _otp = otp;
  }

  signin(String email, String password)async
  {
    setLoading(true);
    await Future.delayed(const Duration(seconds: 2)); //TODO: add signin service 
    setLoading(false);
  }

  signup(String email, String password)async
  {
    setLoading(true);
    await Future.delayed(const Duration(seconds: 2)); //TODO: add signup service 
    setLoading(false);
  }

  sendOTP(String email)async
  {
    setLoading(true);
    await Future.delayed(const Duration(seconds: 2)); //TODO: add send otp service 
    setOTP(1234);
    setLoading(false);
  }

  reSendOTP(String email)async
  {
    setLoading(true);
    await Future.delayed(const Duration(seconds: 2)); //TODO: add resend otp service 
    setOTP(1235);
    setLoading(false);
  }

  createNewPassword(String email, String password)async
  {
    setLoading(true);
    await Future.delayed(const Duration(seconds: 2)); //TODO: add create new password service 
    await signin(email, password); //TODO: also add signin using this email and password
    setLoading(false);
  }

  /// add validators
  /// 
  
}