import 'package:coffee_app/core/app_colors.dart';
import 'package:coffee_app/features/account/view_models/account_view_model.dart';
import 'package:coffee_app/features/auth/views/forgot_password/email_conform_page.dart';
import 'package:coffee_app/features/auth/views/profile_details_page.dart';
import 'package:coffee_app/localization/locales.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/fonts.dart';
import '../../auth/views/signin_page.dart';

class PersonalInfoPage extends ConsumerStatefulWidget {
  const PersonalInfoPage({super.key});

  @override
  ConsumerState<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends ConsumerState<PersonalInfoPage> {
  TextEditingController fullNameController = TextEditingController(),
      phoneNumberController = TextEditingController(),
      emailController = TextEditingController(),
      birthDateController = TextEditingController();
  bool isFulled = false;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await ref.read(accountViewModelProvider.notifier).getUserData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(accountViewModelProvider);
    if (!isFulled) {
      fullNameController.text = viewModel.userData["name"] ?? "";
      emailController.text = viewModel.userData["email"] ?? "";
      phoneNumberController.text = viewModel.userData["phoneNumber"] ?? "";
      birthDateController.text = viewModel.userData["birthDate"] ?? "";
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(LocaleData.accountPersonalInfoTitle.getString(context),
            style: appBarTitleFont),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          children: [
            Expanded(
              child: ListView(
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
                                ),
                              ),
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
                    obscureText: false,
                  ),
                  PhoneNumberInputBox(
                    controller: phoneNumberController,
                  ),
                  DateInputBox(
                    controller: birthDateController,
                    hintText: "Date of Birth",
                  ),
                ],
              ),
            ),
            AuthButton(
              text: "Save",
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
