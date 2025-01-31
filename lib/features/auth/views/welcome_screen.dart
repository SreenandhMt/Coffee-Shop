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

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final size = MediaQuery.sizeOf(context);
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
              await ref.read(authViewModelProvider.notifier).signInWithGoogle();
              final currentValue = ref.read(authViewModelProvider);
              currentValue.fold((left) {
                log(left.toString());
                checkAuthStatus(context, true);
              }, (right) {
                log(right);
              });
            },
          ),
          ContinueButton(
            imageLink: AppAssets.githubLogo(context),
            name: "Github",
            onTap: () async {
              await ref
                  .read(authViewModelProvider.notifier)
                  .signInWithGithub(context);
              final response = ref.read(authViewModelProvider);
              response.fold((left) {
                log(left.toString());
                checkAuthStatus(context, true);
              }, (right) {
                log(right);
              });
            },
          ),
          ContinueButton(
            imageLink: AppAssets.facebookLogo,
            name: "Facebook",
            onTap: () async {
              await ref
                  .read(authViewModelProvider.notifier)
                  .signInWithFacebook();
              final response = ref.read(authViewModelProvider);
              response.fold((left) {
                log(left.toString());
                checkAuthStatus(context, true);
              }, (right) {
                log(right);
              });
            },
          ),
          ContinueButton(
            imageLink: AppAssets.twitterLogo,
            name: "Twitter",
            onTap: () async {
              await ref
                  .read(authViewModelProvider.notifier)
                  .signInWithTwitter();
              final response = ref.read(authViewModelProvider);
              response.fold((left) {
                log(left.toString());
                checkAuthStatus(context, true);
              }, (right) {
                log(right);
              });
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

class ContinueButton extends ConsumerStatefulWidget {
  const ContinueButton({
    super.key,
    required this.imageLink,
    required this.name,
    this.onTap,
  });
  final String imageLink;
  final String name;
  final void Function()? onTap;

  @override
  ConsumerState<ContinueButton> createState() => _ContinueButtonState();
}

class _ContinueButtonState extends ConsumerState<ContinueButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 10),
        height: 60,
        decoration: BoxDecoration(
            color: AppColors.secondaryColor(context),
            borderRadius: BorderRadius.circular(50),
            border: Border.all(width: 0.2, color: Colors.grey)),
        child: Row(
          children: [
            width20,
            Image.asset(widget.imageLink, height: 30, width: 30),
            const Spacer(),
            Text(
              context.formatString(
                  LocaleData.authSocialSigninButton, [widget.name]),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const Spacer(),
            width30,
          ],
        ),
      ),
    );
  }
}
