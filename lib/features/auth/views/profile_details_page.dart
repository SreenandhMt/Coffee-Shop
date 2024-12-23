import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import 'package:coffee_app/core/fonts.dart';
import 'package:coffee_app/core/size.dart';
import 'package:coffee_app/features/auth/views/signin_page.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../core/app_colors.dart';
import 'forgot_password/email_conform_page.dart';

class ProfileDetailsPage extends StatefulWidget {
  const ProfileDetailsPage({super.key});

  @override
  State<ProfileDetailsPage> createState() => _ProfileDetailsPageState();
}

class _ProfileDetailsPageState extends State<ProfileDetailsPage> {
  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar:
          AppBar(backgroundColor: Theme.of(context).scaffoldBackgroundColor,surfaceTintColor: Theme.of(context).scaffoldBackgroundColor),
      body: Padding(
        padding: const EdgeInsets.only(left: 10,right: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //top
              const AuthHadingTexts(
                title: "Complete Your Profile 👤",
                subtitle:
                    "Add the finishing touches to your profile. Lets make your coffee experience more social!",
              ),
              //center
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.grey.shade300,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Container(padding: EdgeInsets.all(3),decoration: BoxDecoration(color: AppColors.primaryColor,borderRadius: BorderRadius.circular(4)),child: Icon(Icons.edit,color: AppColors.themeColor(context),)),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  InputWithText(
                    controller: TextEditingController(),
                    hintText: "Full Name",
                    obscureText: false,
                  ),
                  const PhoneNumberInputBox(),
                  DateInputBox(
                    controller: TextEditingController(),
                    hintText: "Date of Birth"
                  ),
                ],
              ),
              //button
              AuthButton(
                text: "Finish",
                onPressed: () {
                  // if (context.canPop()) context.pop();
                  context.go("/signupSuccess");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PhoneNumberInputBox extends StatefulWidget {
  const PhoneNumberInputBox({super.key});

  @override
  State<PhoneNumberInputBox> createState() => _PhoneNumberInputBoxState();
}

class _PhoneNumberInputBoxState extends State<PhoneNumberInputBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text(
            "Phone Number",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: IntlPhoneField(
              showDropdownIcon: true,
              initialCountryCode: "IN",
              disableLengthCheck: true,
              showCountryFlag: true,
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.secondaryColor(context),
                hintText: "Phone number",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (phone) {
                print(phone.completeNumber);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class AuthHadingTexts extends StatefulWidget {
  const AuthHadingTexts({
    super.key,
    required this.title,
    required this.subtitle,
  });
  final String title;
  final String subtitle;

  @override
  State<AuthHadingTexts> createState() => _AuthHadingTextsState();
}

class _AuthHadingTextsState extends State<AuthHadingTexts> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
          ),
          height10,
          Padding(
            padding: const EdgeInsets.all(4),
            child: Text(
              widget.subtitle,
              style: subtitleFont(fontSize: 16),
            ),
          ),
          height20
        ],
      ),
    );
  }
}