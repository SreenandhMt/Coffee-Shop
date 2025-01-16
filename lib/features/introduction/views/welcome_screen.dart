import 'package:coffee_app/core/size.dart';
import 'package:flutter/material.dart';

import 'package:coffee_app/core/app_colors.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(
            flex: 2,
          ),
          Image.asset("assets/logo.png", height: 200),
          height10,
          const Text("let's dive in into your account"),
          height30,
          const ContinueButton(
              name: "Google", imageLink: "assets/google-logo.png"),
          const ContinueButton(
              imageLink: "assets/apple-logo.png", name: "Apple"),
          const ContinueButton(
              imageLink: "assets/facebook-logo.png", name: "Facebook"),
          const ContinueButton(
              imageLink: "assets/twitter-logo.png", name: "Twitter"),
          const Spacer(),
          ElevatedButton(
              onPressed: () {
                context.push("/welcome/signin");
              },
              style: ButtonStyle(
                  fixedSize:
                      WidgetStatePropertyAll(Size(size.width * 0.95, 66)),
                  shadowColor: WidgetStateColor.transparent,
                  backgroundColor:
                      const WidgetStatePropertyAll(AppColors.primaryColor)),
              child: const Text(
                "Sign in with password",
                style: TextStyle(color: Colors.white, fontSize: 18),
              )),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Don't have account?"),
              width5,
              Text(
                "Sign up",
                style: GoogleFonts.josefinSans(color: AppColors.primaryColor),
              )
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

class ContinueButton extends StatefulWidget {
  const ContinueButton({
    super.key,
    required this.imageLink,
    required this.name,
    this.onTap,
  });
  final String imageLink;
  final String name;
  final void Function()? onTap;

  @override
  State<ContinueButton> createState() => _ContinueButtonState();
}

class _ContinueButtonState extends State<ContinueButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 10),
        height: 60,
        decoration: BoxDecoration(
            color: AppColors.secondaryColor(context),
            borderRadius: BorderRadius.circular(50),
            border: Border.all(width: 0.2, color: Colors.grey)),
        child: Row(
          children: [
            width20,
            Image.asset(widget.imageLink, height: 30, width: 30),
            const Spacer(),
            Text(
              "Continue with ${widget.name}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const Spacer(),
            width30,
          ],
        ),
      ),
    );
  }
}
