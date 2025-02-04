import 'package:coffee_app/localization/locales.dart';
import 'package:flutter/material.dart';

import 'package:coffee_app/features/auth/views/profile_details_page.dart';
import 'package:coffee_app/features/auth/views/signin_page.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:go_router/go_router.dart';

import '../../../../components/auth/auth_text_form.dart';
import '../../../../core/app_colors.dart';

class EmailConformPage extends StatefulWidget {
  const EmailConformPage({super.key});

  @override
  State<EmailConformPage> createState() => _EmailConformPageState();
}

class _EmailConformPageState extends State<EmailConformPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(backgroundColor: Theme.of(context).scaffoldBackgroundColor),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                AuthHadingTexts(
                    title:
                        LocaleData.forgetPasswordEmailTitle.getString(context),
                    subtitle: LocaleData.forgetPasswordEmailSubTitle
                        .getString(context)),
                InputWithText(
                    controller: emailController,
                    hintText: "Email",
                    obscureText: false,
                    icon: Icons.email_rounded),
              ],
            ),
            AuthButton(
                text: LocaleData.continueButton.getString(context),
                onPressed: () {
                  context.push("/welcome/signin/resetPassword-step-2");
                })
          ],
        ),
      ),
    );
  }
}

class AuthButton extends StatefulWidget {
  const AuthButton({
    super.key,
    required this.text,
    required this.onPressed,
  });
  final String text;
  final void Function()? onPressed;

  @override
  State<AuthButton> createState() => _AuthButtonState();
}

class _AuthButtonState extends State<AuthButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              fixedSize: Size(MediaQuery.sizeOf(context).width * 0.9, 60),
            ),
            onPressed: widget.onPressed,
            child: Text(widget.text,
                style: const TextStyle(color: Colors.white, fontSize: 17)),
          ),
        ],
      ),
    );
  }
}
