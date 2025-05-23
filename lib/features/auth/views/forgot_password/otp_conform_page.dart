import 'package:coffee_app/core/app_colors.dart';
import 'package:coffee_app/core/size.dart';
import 'package:coffee_app/features/auth/views/profile_details_page.dart';
import 'package:coffee_app/features/auth/views/signin_page.dart';
import 'package:coffee_app/localization/locales.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

class OTPConformPage extends StatefulWidget {
  const OTPConformPage({super.key});

  @override
  State<OTPConformPage> createState() => _OTPConformPageState();
}

class _OTPConformPageState extends State<OTPConformPage> {
  String email = "";

  @override
  void initState() {
    final splitEmail = emailController.text.split("@");
    if (splitEmail.length == 2) {
      for (int i = 0; i < splitEmail[0].length; i++) {
        if (i > splitEmail[0].length - 4) {
          email += splitEmail[0][i];
        } else {
          email += "*";
        }
      }
      email += '@${splitEmail[1]}';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    // final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar:
          AppBar(backgroundColor: Theme.of(context).scaffoldBackgroundColor),
      body: Column(
        children: [
          AuthHadingTexts(
              title: LocaleData.forgetPasswordOTPTitle.getString(context),
              subtitle: context
                  .formatString(LocaleData.forgetPasswordOTPSubTitle, [email])),
          height20,
          Form(
            key: formKey,
            child: Column(
              children: [
                Pinput(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter OTP code";
                    }
                    if (value.length < 4) {
                      return "Please enter valid OTP code";
                    }
                    return null;
                  },
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onCompleted: (value) async {
                    if (formKey.currentState!.validate()) {
                      context.push("/welcome/signin/resetPassword-step-3");
                    }
                  },
                )
              ],
            ),
          ),
          const Spacer(flex: 2),
          const Text(
            "Didn't resive email?",
            style: TextStyle(fontSize: 17),
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("You can reset code in", style: TextStyle(fontSize: 17)),
              width5,
              Text("52 s",
                  style: TextStyle(color: AppColors.primaryColor, fontSize: 17))
            ],
          ),
          const Spacer()
        ],
      ),
    );
  }
}
