
import 'package:coffee_app/core/app_colors.dart';
import 'package:coffee_app/core/fonts.dart';
import 'package:coffee_app/core/size.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignupSuccessPage extends StatefulWidget {
  const SignupSuccessPage({super.key});

  @override
  State<SignupSuccessPage> createState() => _SignupSuccessPageState();
}

class _SignupSuccessPageState extends State<SignupSuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Spacer(),
          CircleAvatar(radius: 60,backgroundColor: AppColors.primaryColor,child: Icon(Icons.check,size: 60,),),
          height20,
          Text("You're All Set!",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
          height10,
          Text("Your coffee adventure begins!",style: subtitleFont()),
          Spacer(),
          Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      fixedSize: Size(MediaQuery.sizeOf(context).width*0.9, 60),
                    ),
                    onPressed: () {
                      context.pop();
                    },
                    child: const Text("Start Exploring",style: TextStyle(color: Colors.white, fontSize: 17)),
                  ),
                ],
              ),
              height35,
        ],
      ),
    );
  }
}