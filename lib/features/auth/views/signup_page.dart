import 'package:coffee_app/core/fonts.dart';
import 'package:coffee_app/features/auth/views/profile_details_page.dart';
import 'package:coffee_app/features/auth/views/signin_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/app_colors.dart';
import '../../../core/size.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(backgroundColor: Theme.of(context).scaffoldBackgroundColor),
      body: Padding(
        padding: const EdgeInsets.only(left: 10,right: 10,top: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AuthHadingTexts(title: "Create Account 👩‍💻", subtitle: "Sign up to unlock the world of coffee"),
            InputWithText(controller: emailController,hintText: "Email",icon: Icons.email,obscureText: false),
            height5,
            InputWithText(controller: TextEditingController(),hintText: "Password",icon: Icons.lock,obscureText: true),
            height5,
            InputWithText(controller: TextEditingController(),hintText: "Referral Code (optional)",obscureText: false),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  CupertinoCheckbox(value: false, onChanged: (value) {},inactiveColor: AppColors.primaryColor,activeColor: AppColors.primaryColor),
                  width5,
                  Text("I agree to Caffely",style: sharpLightFont(fontWeight: FontWeight.w600, fontSize: 16)),
                  width5,
                  Text("Terms & Conditions.",style: sharpLightFont(fontWeight: FontWeight.w600, fontSize: 16,color: AppColors.primaryColor)),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20,right: 20),
              child: Divider(thickness: 0.1),
            ),
            height10,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Already have an account?",style: sharpLightFont(fontSize: 15),),
                width5,
                InkWell(onTap: () {
                  if (context.canPop()) context.pop();
                  context.push("/welcome/signin");
                },child: Text("Sign in",style: sharpLightFont(color: AppColors.primaryColor,fontWeight: FontWeight.w700),))
              ],
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    fixedSize: Size(size.width*0.9, 60),
                  ),
                  onPressed: () {
                  context.push('/welcome/signup/profileDetails');
                  },
                  child: const Text("Sign up",style: TextStyle(color: Colors.white, fontSize: 17)),
                ),
              ],
            ),
            height15,
          ],
        ),
      ),
    );
  }
}