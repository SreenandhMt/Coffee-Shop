import 'package:coffee_app/core/app_colors.dart';
import 'package:coffee_app/core/fonts.dart';
import 'package:coffee_app/core/size.dart';
import 'package:coffee_app/features/auth/views/forgot_password/email_conform_page.dart';
import 'package:coffee_app/route/navigation_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view_models/wallet_view_model.dart';

TextEditingController topUpAmount = TextEditingController();

class TopUpPage extends ConsumerStatefulWidget {
  const TopUpPage({super.key});

  @override
  ConsumerState<TopUpPage> createState() => _TopUpPageState();
}

class _TopUpPageState extends ConsumerState<TopUpPage> {
  @override
  Widget build(BuildContext context) {
    final walletModel = ref.watch(walletViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: AppColors.primaryColor,
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Top Up Amount',
          style: titleFonts(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: AppColors.primaryColor,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextField(
                    autofocus: true,
                    controller: topUpAmount,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    textInputAction: TextInputAction.unspecified,
                    cursorColor: Colors.white,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    cursorRadius: const Radius.circular(10),
                    cursorOpacityAnimates: true,
                    cursorHeight: 50,
                    cursorWidth: 3,
                    decoration: InputDecoration(
                      hintText: 'Enter Amount',
                      hintStyle: titleFonts(
                        fontSize: 40,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Available balance: \$${walletModel.balance}",
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
          ),
          height10,
          AuthButton(
              text: "Continue",
              onPressed: () => NavigationUtils.chooseTopUpPaymentPage(context)),
        ],
      ),
    );
  }
}
