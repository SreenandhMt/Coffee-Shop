import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:coffee_app/core/app_colors.dart';
import 'package:coffee_app/core/fonts.dart';
import 'package:coffee_app/core/size.dart';

class SignupSuccessPage extends StatefulWidget {
  const SignupSuccessPage({
    super.key,
    this.title,
    this.subtitle,
    this.buttonText,
  });
  final String? title;
  final String? subtitle;
  final String? buttonText;

  @override
  State<SignupSuccessPage> createState() => _SignupSuccessPageState();
}

class _SignupSuccessPageState extends State<SignupSuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Spacer(),
          const CircleAvatar(
            radius: 60,
            backgroundColor: AppColors.primaryColor,
            child: Icon(
              Icons.check,
              size: 60,
            ),
          ),
          height20,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              widget.title ?? "You're All Set!",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          height10,
          Text(widget.subtitle ?? "Your coffee adventure begins!",
              style: subtitleFont()),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  fixedSize: Size(MediaQuery.sizeOf(context).width * 0.9, 60),
                ),
                onPressed: () {
                  context.pop();
                },
                child: Text(widget.buttonText ?? "Start Exploring",
                    style: const TextStyle(color: Colors.white, fontSize: 17)),
              ),
            ],
          ),
          height35,
        ],
      ),
    );
  }
}
