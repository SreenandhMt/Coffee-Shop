import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_app/core/app_colors.dart';
import 'package:coffee_app/core/assets.dart';
import 'package:coffee_app/route/check_navigation.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      checkAuthStatus(context, mounted);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(),
          Image.asset(AppAssets.logoWithText(context),
              width: double.infinity, height: 250),
          const SizedBox(
              width: 70,
              height: 70,
              child: LoadingIndicator(
                indicatorType: Indicator.ballRotateChase,
                colors: [
                  AppColors.primaryColor,
                ],
              )),
        ],
      ),
    );
  }
}
