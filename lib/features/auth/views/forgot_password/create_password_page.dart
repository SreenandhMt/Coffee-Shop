import 'package:coffee_app/core/size.dart';
import 'package:coffee_app/features/auth/views/forgot_password/email_conform_page.dart';
import 'package:coffee_app/features/auth/views/profile_details_page.dart';
import 'package:coffee_app/features/auth/views/signin_page.dart';
import 'package:coffee_app/localization/locales.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:go_router/go_router.dart';

class CreatePasswordPage extends StatefulWidget {
  const CreatePasswordPage({super.key});

  @override
  State<CreatePasswordPage> createState() => _CreatePasswordPageState();
}

class _CreatePasswordPageState extends State<CreatePasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(backgroundColor: Theme.of(context).scaffoldBackgroundColor),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                AuthHadingTexts(
                    title: LocaleData.forgetPasswordNewPasswordTitle
                        .getString(context),
                    subtitle: LocaleData.forgetPasswordNewPasswordSubTitle
                        .getString(context)),
                height30,
                InputWithText(
                    controller: TextEditingController(),
                    hintText: "New Password",
                    obscureText: true,
                    icon: Icons.lock),
                InputWithText(
                    controller: TextEditingController(),
                    hintText: "Conform New Password",
                    obscureText: true,
                    icon: Icons.lock),
              ],
            ),
          ),
          AuthButton(
              text: LocaleData.continueButton.getString(context),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => showSuccessDialog(context));
              })
        ],
      ),
    );
  }

  Widget showSuccessDialog(BuildContext context) {
    return DialogBox(
        autoFunction: () {
          if (context.canPop()) context.pop();
          if (context.canPop()) context.pop();
          context.go("/");
        },
        icon: Icons.person,
        title: "Reset Password Successful!",
        subtitle: "Please wait... \n Your will be directed to the home page.");
  }
}
