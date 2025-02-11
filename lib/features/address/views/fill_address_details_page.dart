import 'package:coffee_app/core/app_colors.dart';
import 'package:coffee_app/core/size.dart';
import 'package:coffee_app/features/address/view_models/address_view_model.dart';
import 'package:coffee_app/features/auth/views/forgot_password/email_conform_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../core/fonts.dart';

class FillUpAddressDetailsPage extends ConsumerStatefulWidget {
  const FillUpAddressDetailsPage({super.key});

  @override
  ConsumerState<FillUpAddressDetailsPage> createState() =>
      _FillUpAddressDetailsPageState();
}

class _FillUpAddressDetailsPageState
    extends ConsumerState<FillUpAddressDetailsPage> {
  TextEditingController labelController = TextEditingController(),
      noteController = TextEditingController(),
      nameController = TextEditingController(),
      number = TextEditingController();
  bool isSelected = false;

  final GlobalKey<FormState> _key = GlobalKey();

  @override
  void initState() {
    final addressModel = ref.read(addressViewModelProvider).selectedAddress;
    if (addressModel != null) {
      labelController.text = addressModel.title;
      noteController.text = addressModel.note ?? "";
      nameController.text = addressModel.name;
      number.text = addressModel.phoneNumber;
      isSelected = addressModel.isSelected;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.read(addressViewModelProvider);
    return Form(
      key: _key,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Add New Address", style: appBarTitleFont),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        width10,
                        const Icon(Icons.location_on_rounded,
                            color: AppColors.primaryColor),
                        width10,
                        Expanded(
                          child: Text(
                            viewModel.userAddress,
                            style: const TextStyle(fontSize: 16),
                            maxLines: 3,
                          ),
                        )
                      ],
                    ),
                  ),
                  inputWIthLabel(
                    "Address Labels",
                    "Label",
                    labelController,
                    isRequired: true,
                  ),
                  inputWIthLabel(
                    "Note to Courier (optional)",
                    "Note",
                    noteController,
                  ),
                  inputWIthLabel(
                    "Recipient's Name",
                    "Name",
                    nameController,
                    isRequired: true,
                  ),
                  phoneNumberInputWithLabel(number),
                  height10,
                  Row(
                    children: [
                      width10,
                      Checkbox(
                        value: isSelected,
                        onChanged: (value) {
                          setState(() {
                            isSelected = value!;
                          });
                        },
                        fillColor: const WidgetStatePropertyAll(
                            AppColors.primaryColor),
                      ),
                      const Text(
                        "Set As Primary Address",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w800),
                      )
                    ],
                  ),
                ],
              ),
            ),
            AuthButton(
                text: "Save",
                onPressed: () async {
                  if (!_key.currentState!.validate()) return;
                  if (viewModel.selectedAddress != null) {
                    ref.read(addressViewModelProvider.notifier).saveAddress(
                          name: nameController.text,
                          number: number.text,
                          title: labelController.text,
                          isSelected: isSelected,
                          note: noteController.text,
                        );
                  } else {
                    await ref
                        .read(addressViewModelProvider.notifier)
                        .addAddress(
                          title: labelController.text,
                          note: noteController.text,
                          userName: nameController.text,
                          number: number.text,
                          isSelected: isSelected,
                        );
                  }
                  if (mounted) {
                    context.pop();
                    if (context.canPop()) context.pop();
                  }
                })
          ],
        ),
      ),
    );
  }

  Widget phoneNumberInputWithLabel(controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recipient's Phone Number",
            style: TextStyle(
              fontSize: 16,
              color: AppColors.themeTextColor(context),
              fontWeight: FontWeight.bold,
            ),
          ),
          IntlPhoneField(
            showDropdownIcon: true,
            validator: (value) {
              if (value == null || value.number.isEmpty) {
                return "Enter Your Phone Number";
              }
              if (value.number.length != 10) {
                return "Invalid Phone Number";
              }
              return null;
            },
            autovalidateMode: AutovalidateMode.always,
            initialCountryCode: "IN",
            controller: controller,
            disableLengthCheck: true,
            showCountryFlag: true,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.themeTextColor(context)),
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.secondaryColor(context).withOpacity(0.5),
              hintText: "Phone number",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              errorBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget inputWIthLabel(String label, String hintText, controller,
      {bool isRequired = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: AppColors.themeTextColor(context),
              fontWeight: FontWeight.bold,
            ),
          ),
          TextFormField(
            controller: controller,
            validator: (value) {
              if (!isRequired) return null;
              if (value == null || value.isEmpty) {
                return "The value is required";
              }
              return null;
            },
            style: TextStyle(
                color: AppColors.themeColor(context),
                fontWeight: FontWeight.w600),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                fontSize: 16,
                color: AppColors.themeTextColor(context),
                fontWeight: FontWeight.bold,
              ),
              filled: true,
              fillColor: AppColors.secondaryColor(context).withOpacity(0.5),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
