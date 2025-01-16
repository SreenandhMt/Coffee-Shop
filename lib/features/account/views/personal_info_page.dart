import 'package:coffee_app/core/app_colors.dart';
import 'package:coffee_app/core/size.dart';
import 'package:coffee_app/features/payment/views/add_payment_method_page.dart';
import 'package:coffee_app/features/auth/views/forgot_password/email_conform_page.dart';
import 'package:coffee_app/features/auth/views/profile_details_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/fonts.dart';
import '../../auth/views/signin_page.dart';

class PersonalInfoPage extends StatefulWidget {
  const PersonalInfoPage({super.key});

  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  TextEditingController fullNameController = TextEditingController(),
      phoneNumberController = TextEditingController(),
      birthDateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Personal Info", style: appBarTitleFont),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
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
                        child: Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(4)),
                            child: Icon(
                              Icons.edit,
                              color: AppColors.themeColor(context),
                            )),
                      )
                    ],
                  ),
                ),
              ],
            ),
            InputWithText(
              controller: fullNameController,
              hintText: "Full Name",
              obscureText: false,
            ),
            InputWithText(
                controller: emailController,
                hintText: "Email",
                icon: Icons.email,
                obscureText: false),
            PhoneNumberInputBox(controller: phoneNumberController),
            DateInputBox(
                controller: birthDateController, hintText: "Date of Birth"),
            const Spacer(),
            AuthButton(text: "Save", onPressed: () {})
          ],
        ),
      ),
    );
  }
}
