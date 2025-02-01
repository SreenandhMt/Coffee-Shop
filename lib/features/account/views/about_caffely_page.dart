import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:coffee_app/core/assets.dart';
import 'package:coffee_app/core/fonts.dart';
import 'package:coffee_app/core/size.dart';

import '../../../components/account/about_caffely_widget.dart';

class AboutCaffelyPage extends StatefulWidget {
  const AboutCaffelyPage({super.key});

  @override
  State<AboutCaffelyPage> createState() => _AboutCaffelyPageState();
}

class _AboutCaffelyPageState extends State<AboutCaffelyPage> {
  List<String> terms = [
    "Terms and Conditions",
    "Privacy Policy",
    "Job Vacancy",
    "Contact Us",
    "Partner",
    "Accessibility",
    "Feedback",
    "Rate us",
    "Visit Our Website",
    "Follow us on Social Media",
    "Refund Policy",
    "Shipping Policy",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "About Caffely",
          style: appBarTitleFont,
        ),
      ),
      body: ListView(
        children: [
          height10,
          Image.asset(
            AppAssets.logoWithText(context),
            height: 200,
            width: 200,
          ),
          height10,
          ...List.generate(
              terms.length, (index) => AboutCaffelyWidget(title: terms[index]))
        ],
      ),
    );
  }
}
