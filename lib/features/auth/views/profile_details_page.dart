import 'dart:async';
import 'dart:developer';

import 'package:coffee_app/features/auth/view_models/auth_view_model.dart';
import 'package:flutter/material.dart';

import 'package:coffee_app/core/fonts.dart';
import 'package:coffee_app/core/size.dart';
import 'package:coffee_app/features/auth/views/signin_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

import '../../../core/app_colors.dart';
import '../../../route/navigation_utils.dart';
import 'forgot_password/email_conform_page.dart';

class ProfileDetailsPage extends ConsumerStatefulWidget {
  const ProfileDetailsPage({super.key});

  @override
  ConsumerState<ProfileDetailsPage> createState() => _ProfileDetailsPageState();
}

class _ProfileDetailsPageState extends ConsumerState<ProfileDetailsPage> {
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  TextEditingController fullNameController = TextEditingController(),
      phoneNumberController = TextEditingController(text: ""),
      birthDateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.sizeOf(context);
    return Form(
      key: key,
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            surfaceTintColor: Theme.of(context).scaffoldBackgroundColor),
        body: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: [
              Expanded(
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
                                      child: Container(
                                          padding: const EdgeInsets.all(3),
                                          decoration: BoxDecoration(
                                              color: AppColors.primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(4)),
                                          child: Icon(
                                            Icons.edit,
                                            color:
                                                AppColors.themeColor(context),
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
                          PhoneNumberInputBox(
                              controller: phoneNumberController,
                              validator: (value) {
                                log(value.toString());
                                if (value == null || value.number.isEmpty) {
                                  return 'Please enter your mobile number';
                                }
                                //TODO: Regular expression for mobile number validation
                                if (!RegExp(r'^[0-9]{10}$')
                                    .hasMatch(value.number)) {
                                  return 'Please enter a valid 10-digit mobile number';
                                }
                                return null;
                              }),
                          DateInputBox(
                              controller: birthDateController,
                              hintText: "Date of Birth"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              AuthButton(
                text: "Finish",
                onPressed: () async {
                  //validating
                  if (!key.currentState!.validate() ||
                      phoneNumberController.text.isEmpty ||
                      phoneNumberController.text.length != 10) {
                    return;
                  }
                  //function calling
                  await ref.read(authViewModelProvider.notifier).createProfile(
                      fullNameController.text,
                      phoneNumberController.text,
                      birthDateController.text);
                  //mounted checking
                  if (!mounted) return;

                  //response user
                  final authState = ref.read(authViewModelProvider);
                  authState.fold((left) {
                    NavigationUtils.showAuthSuccessPage(context);
                  }, (right) {
                    log(right);
                  });
                },
              ),
              height15,
            ],
          ),
        ),
      ),
    );
  }
}

class PhoneNumberInputBox extends StatefulWidget {
  const PhoneNumberInputBox(
      {super.key, required this.controller, this.validator});
  final TextEditingController controller;
  final String? Function(PhoneNumber?)? validator;

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
              initialValue: "",
              showDropdownIcon: true,
              validator: widget.validator ??
                  (value) {
                    if (value == null || value.number.isEmpty) {
                      return "Enter Your Phone Number";
                    }
                    if (value.number.length != 10) {
                      return "Invalid Phone Number";
                    }
                    return null;
                  },
              initialCountryCode: "IN",
              controller: widget.controller,
              disableLengthCheck: true,
              showCountryFlag: true,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.themeColor(context)),
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.secondaryColor(context).withOpacity(0.3),
                hintText: "Phone number",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.red)),
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
