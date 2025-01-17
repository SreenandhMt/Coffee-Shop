import 'package:coffee_app/core/app_colors.dart';
import 'package:coffee_app/route/navigation_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_indicator/loading_indicator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      if (FirebaseAuth.instance.currentUser != null) {
        if (!mounted) return;
        NavigationUtils.replaceHomePage(context);
      } else {
        if (!mounted) return;
        NavigationUtils.introductionPage(context);
      }
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
          Image.asset('assets/logo.png', width: double.infinity, height: 250),
          const SizedBox(
              width: 70,
              height: 70,
              child: LoadingIndicator(
                indicatorType: Indicator.ballRotateChase,
                colors: [AppColors.primaryColor],
              )),
        ],
      ),
    );
  }
}
