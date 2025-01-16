import 'package:coffee_app/core/app_colors.dart';
import 'package:coffee_app/core/size.dart';
import 'package:coffee_app/features/auth/views/forgot_password/email_conform_page.dart';
import 'package:coffee_app/features/auth/views/profile_details_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../core/fonts.dart';

class FillUpAddressDetailsPage extends StatefulWidget {
  const FillUpAddressDetailsPage({super.key});

  @override
  State<FillUpAddressDetailsPage> createState() =>
      _FillUpAddressDetailsPageState();
}

class _FillUpAddressDetailsPageState extends State<FillUpAddressDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Add New Address", style: appBarTitleFont),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                width10,
                Icon(Icons.location_on_rounded, color: AppColors.primaryColor),
                width10,
                Text(
                  "75 9th Ave, New York, NY 10011, USA",
                  style: TextStyle(fontSize: 16),
                )
              ],
            ),
          ),
          inputWIthLabel("Address Labels", "Label"),
          inputWIthLabel("Note to Courier (optional)", "Note"),
          inputWIthLabel("Recipient's Name", "Name"),
          phoneNumberInputWithLabel(),
          height10,
          Row(
            children: [
              width10,
              Checkbox(
                value: true,
                onChanged: (value) {},
                fillColor: const WidgetStatePropertyAll(AppColors.primaryColor),
              ),
              const Text(
                "Set As Primary Address",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
              )
            ],
          ),
          const Spacer(),
          AuthButton(
              text: "Save",
              onPressed: () {
                context.pop();
                if (context.canPop()) context.pop();
              })
        ],
      ),
    );
  }

  Widget phoneNumberInputWithLabel() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Recipient's Phone Number",
            style: TextStyle(
              fontSize: 16,
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
            initialCountryCode: "IN",
            controller: TextEditingController(),
            disableLengthCheck: true,
            showCountryFlag: true,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.themeColor(context)),
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
            onChanged: (phone) {
              print(phone.completeNumber);
            },
          ),
        ],
      ),
    );
  }

  Widget inputWIthLabel(String label, String hintText) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextFormField(
            style: TextStyle(
                color: AppColors.themeColor(context),
                fontWeight: FontWeight.w600),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
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
