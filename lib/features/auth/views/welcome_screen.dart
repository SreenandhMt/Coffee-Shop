import 'dart:developer';

import 'package:coffee_app/core/assets.dart';
import 'package:coffee_app/core/size.dart';
import 'package:coffee_app/features/auth/view_models/auth_view_model.dart';
import 'package:coffee_app/localization/locales.dart';
import 'package:coffee_app/route/check_navigation.dart';
import 'package:flutter/material.dart';

import 'package:coffee_app/core/app_colors.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../components/auth/continue_button.dart';

bool _snackBarOpened = false;

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final size = MediaQuery.sizeOf(context);
    ref.listen(authViewModelProvider, (previous, next) {
      next.fold((left) {
        if (left == AuthState.success) {
          checkAuthStatus(context, true);
        }
      }, (right) {
        if (_snackBarOpened) return;
        _snackBarOpened = true;
        final snackBar = ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(right),
            showCloseIcon: true,
            backgroundColor: Colors.redAccent,
            behavior: SnackBarBehavior.floating,
          ),
        );
        snackBar.closed.then((value) => _snackBarOpened = false);
      });
    });
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(
            flex: 2,
          ),
          Image.asset(AppAssets.logoWithText(context), height: 200),
          height10,
          Text(LocaleData.welcomePageTitle.getString(context)),
          height30,
          ContinueButton(
            name: "Google",
            imageLink: AppAssets.googleLogo,
            onTap: () async {
              ref.read(authViewModelProvider.notifier).signInWithGoogle();
            },
          ),
          ContinueButton(
            imageLink: AppAssets.githubLogo(context),
            name: "Github",
            onTap: () async {
              ref
                  .read(authViewModelProvider.notifier)
                  .signInWithGithub(context);
            },
          ),
          ContinueButton(
            imageLink: AppAssets.facebookLogo,
            name: "Facebook",
            onTap: () async {
              ref.read(authViewModelProvider.notifier).signInWithFacebook();
            },
          ),
          ContinueButton(
            imageLink: AppAssets.twitterLogo,
            name: "Twitter",
            onTap: () async {
              ref.read(authViewModelProvider.notifier).signInWithTwitter();
            },
          ),
          const Spacer(),
          ElevatedButton(
              onPressed: () {
                context.push("/welcome/signin");
              },
              style: ButtonStyle(
                  fixedSize:
                      WidgetStatePropertyAll(Size(size.width * 0.95, 66)),
                  shadowColor: WidgetStateColor.transparent,
                  backgroundColor:
                      const WidgetStatePropertyAll(AppColors.primaryColor)),
              child: Text(
                LocaleData.authSigninWithPasswordButton.getString(context),
                style: const TextStyle(color: Colors.white, fontSize: 18),
              )),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(LocaleData.haveAccount.getString(context)),
              width5,
              InkWell(
                onTap: () {
                  context.push("/welcome/signup");
                },
                child: Text(
                  LocaleData.authSignup.getString(context),
                  style: GoogleFonts.josefinSans(color: AppColors.primaryColor),
                ),
              )
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
