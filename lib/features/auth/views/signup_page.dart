import 'dart:developer';

import 'package:coffee_app/core/fonts.dart';
import 'package:coffee_app/features/auth/view_models/auth_view_model.dart';
import 'package:coffee_app/features/auth/views/profile_details_page.dart';
import 'package:coffee_app/features/auth/views/signin_page.dart';
import 'package:coffee_app/localization/locales.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../components/auth/auth_text_form.dart';
import '../../../core/app_colors.dart';
import '../../../core/size.dart';

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({super.key});

  @override
  ConsumerState<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  bool snackBarOpened = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    ref.listen(authViewModelProvider, (previous, next) {
      next.fold((left) {
        if (left == AuthState.success) {
          context.push('/welcome/signup/profileDetails');
        }
      }, (right) {
        if (snackBarOpened) return;
        snackBarOpened = true;
        final snackBar = ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(right),
            showCloseIcon: true,
            backgroundColor: Colors.redAccent,
            behavior: SnackBarBehavior.floating,
          ),
        );
        snackBar.closed.then((value) => snackBarOpened = false);
      });
    });
    return Form(
      key: _key,
      child: Scaffold(
        appBar:
            AppBar(backgroundColor: Theme.of(context).scaffoldBackgroundColor),
        body: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AuthHadingTexts(
                          title: LocaleData.signupTitle.getString(context),
                          subtitle:
                              LocaleData.signupSubtitle.getString(context)),
                      InputWithText(
                        controller: emailController,
                        hintText: "Email",
                        icon: Icons.email,
                        obscureText: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your email";
                          }
                          if (!isValidEmail(value)) {
                            return "Please enter a valid email";
                          }
                          return null;
                        },
                      ),
                      height5,
                      InputWithText(
                        controller: passwordController,
                        hintText: "Password",
                        icon: Icons.lock,
                        obscureText: true,
                        validator: (password) => isValidPassword(password!),
                      ),
                      height5,
                      InputWithText(
                        controller: TextEditingController(),
                        hintText: "Referral Code (optional)",
                        obscureText: false,
                        validator: (p0) => null,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Row(
                          children: [
                            CupertinoCheckbox(
                                value: false,
                                onChanged: (value) {},
                                activeColor: AppColors.primaryColor,
                                fillColor:
                                    WidgetStateProperty.resolveWith<Color>(
                                        (Set<WidgetState> states) {
                                  if (states.contains(WidgetState.disabled)) {
                                    return CupertinoColors.white
                                        .withOpacity(0.5);
                                  }
                                  if (states.contains(WidgetState.selected)) {
                                    return AppColors.primaryColor;
                                  }
                                  return AppColors.primaryColor;
                                })),
                            width5,
                            Text("I agree to Caffely",
                                style: sharpLightFont(
                                    fontWeight: FontWeight.w600, fontSize: 16)),
                            width5,
                            Text("Terms & Conditions.",
                                style: sharpLightFont(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: AppColors.primaryColor)),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Divider(thickness: 0.1),
                      ),
                      height10,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            LocaleData.alreadyHaveAccount.getString(context),
                            style: sharpLightFont(fontSize: 15),
                          ),
                          width5,
                          InkWell(
                              onTap: () {
                                if (context.canPop()) context.pop();
                                context.push("/welcome/signin");
                              },
                              child: Text(
                                LocaleData.authSignin.getString(context),
                                style: sharpLightFont(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.w700),
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      fixedSize: Size(size.width * 0.9, 60),
                    ),
                    onPressed: () async {
                      //*validating
                      if (!_key.currentState!.validate()) return;
                      ref.read(authViewModelProvider.notifier).signUp(
                          emailController.text, passwordController.text);
                    },
                    child: Text(LocaleData.authSignup.getString(context),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 17)),
                  ),
                ],
              ),
              height15,
            ],
          ),
        ),
      ),
    );
  }

  bool isValidEmail(String email) {
    String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    return RegExp(emailPattern).hasMatch(email);
  }

  String? isValidPassword(String password) {
    if (password.length < 8) return "At least 8 characters";
    if (!password.contains(RegExp(r'[A-Z]'))) {
      return "At least one uppercase letter";
    }
    if (!password.contains(RegExp(r'[a-z]'))) {
      return "At least one lowercase letter";
    }
    if (!password.contains(RegExp(r'\d'))) return "At least one number";
    if (!password.contains(RegExp(r'[@$!%*?&]'))) {
      return "At least one special character (@\$!%*?&)";
    }
    return null;
  }
}
