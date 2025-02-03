import 'package:coffee_app/core/assets.dart';
import 'package:coffee_app/features/auth/views/forgot_password/email_conform_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/app_colors.dart';
import '../../../core/fonts.dart';
import '../../../core/size.dart';

class AddPaymentMethodPage extends StatefulWidget {
  const AddPaymentMethodPage({super.key});

  @override
  State<AddPaymentMethodPage> createState() => _AddPaymentMethodPageState();
}

class _AddPaymentMethodPageState extends State<AddPaymentMethodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Payment Method", style: appBarTitleFont),
        actions: const [
          Icon(Icons.document_scanner_outlined),
          width10,
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10,
                children: [
                  height10,
                  const InputWithLabelWidget(
                      "Card Number", "Enter Card Number"),
                  const InputWithLabelWidget(
                      "Card Holder Name", "Enter Card Holder Name"),
                  _cardDetailsFormField(MediaQuery.sizeOf(context)),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      "Supported Payments:",
                      style: subtitleFont(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    width: 200,
                    height: 60,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(AppAssets.supportedCard),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          AuthButton(
            text: "Add Card",
            onPressed: () {
              context.pop();
            },
          )
        ],
      ),
    );
  }

  Widget _cardDetailsFormField(Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        LimitedBox(
          maxWidth: (size.width / 2) * 0.9,
          child: const InputWithLabelWidget("Expiry Date", "00/00",
              icon: Icons.date_range_outlined),
        ),
        LimitedBox(
          maxWidth: (size.width / 2) * 0.9,
          child: const InputWithLabelWidget("CVV", "000"),
        )
      ],
    );
  }
}

class InputWithLabelWidget extends StatelessWidget {
  const InputWithLabelWidget(this.label, this.hintText, {this.icon, super.key});
  final String label;
  final String hintText;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: subtitleFont(
              fontSize: 16,
              color: AppColors.themeTextColor(context),
              fontWeight: FontWeight.w700,
            ),
          ),
          TextFormField(
            style: TextStyle(
                color: AppColors.themeColor(context),
                fontWeight: FontWeight.w600),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                fontSize: 16,
                color: AppColors.themeTextColor(context),
              ),
              suffixIcon: icon != null ? Icon(icon) : null,
              filled: true,
              fillColor: AppColors.secondaryColor(context).withOpacity(0.2),
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
