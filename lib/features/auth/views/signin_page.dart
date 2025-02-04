import 'dart:developer';

import 'package:coffee_app/localization/locales.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:coffee_app/core/app_colors.dart';
import 'package:coffee_app/core/size.dart';
import 'package:coffee_app/features/auth/view_models/auth_view_model.dart';
import 'package:coffee_app/features/auth/views/profile_details_page.dart';

import '../../../components/auth/auth_text_form.dart';
import '../../../components/auth/dialog_box.dart';
import '../../../route/navigation_utils.dart';

final emailController = TextEditingController();

class SigninPage extends ConsumerStatefulWidget {
  const SigninPage({super.key});

  @override
  ConsumerState<SigninPage> createState() => SigninPageState();
}

class SigninPageState extends ConsumerState<SigninPage> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final authState = ref.watch(authViewModelProvider);
    final size = MediaQuery.sizeOf(context);
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
                          title: LocaleData.signinWelcomeMessage
                              .getString(context),
                          subtitle:
                              LocaleData.signinSubtitle.getString(context)),
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
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your password";
                          }
                          if (value.length <= 8) {
                            return "Password must be at least 8 characters";
                          }
                          return null;
                        },
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Divider(thickness: 0.1),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
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
                                        .withOpacity(0.4);
                                  }
                                  if (states.contains(WidgetState.selected)) {
                                    return AppColors.primaryColor;
                                  }
                                  return AppColors.primaryColor;
                                })),
                            width5,
                            const Text("Remember me",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 16)),
                            const Spacer(),
                            InkWell(
                                onTap: () => context.push(
                                    "/welcome/signin/resetPassword-step-1"),
                                child: const Text("Forget password?",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                        color: AppColors.primaryColor))),
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
                            LocaleData.haveAccount.getString(context),
                            style: const TextStyle(fontSize: 15),
                          ),
                          width5,
                          InkWell(
                              onTap: () {
                                if (context.canPop()) context.pop();
                                context.push("/welcome/signup");
                              },
                              child: Text(
                                LocaleData.authSignup.getString(context),
                                style: const TextStyle(
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

                      //*function calling
                      await ref.read(authViewModelProvider.notifier).signIn(
                          emailController.text, passwordController.text);

                      //*mounted checking
                      if (!mounted) return;
                      final currentState = ref.read(authViewModelProvider);
                      //*response
                      currentState.fold((left) {
                        //*success message
                        if (left == AuthState.success) {
                          _showDialogBox();
                        }
                      }, (right) {
                        //*error massage
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(right),
                            backgroundColor: Colors.redAccent,
                            behavior: SnackBarBehavior.floating,
                            width: 200,
                          ),
                        );
                      });
                    },
                    child: Text(LocaleData.authSignin.getString(context),
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

  void _showDialogBox() {
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
  }

  bool isValidEmail(String email) {
    String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regex = RegExp(emailPattern);
    return regex.hasMatch(email);
  }
}
