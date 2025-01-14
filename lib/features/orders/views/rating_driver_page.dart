import 'package:coffee_app/core/app_colors.dart';
import 'package:coffee_app/core/size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../route/navigation_utils.dart';

class RatingPage extends StatefulWidget {
  const RatingPage({super.key});

  @override
  State<RatingPage> createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          spacing: 10,
          children: [
            const CircleAvatar(radius: 80),
            height15,
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                "Let's rate your driver's delivery service",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
              ),
            ),
            height10,
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                "How was the delivery of your order from Caffely Astoria Aromas?",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
            height20,
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.star_rate_rounded,
                  color: Colors.orange,
                  size: 50,
                ),
                Icon(
                  Icons.star_rate_rounded,
                  color: Colors.orange,
                  size: 50,
                ),
                Icon(
                  Icons.star_rate_rounded,
                  color: Colors.orange,
                  size: 50,
                ),
                Icon(
                  Icons.star_rate_rounded,
                  color: Colors.orange,
                  size: 50,
                ),
                Icon(
                  Icons.star_rate_rounded,
                  color: Colors.orange,
                  size: 50,
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Divider(
                thickness: 0.3,
              ),
            ),
            const Text("Haven't received your order?"),
            height10,
            const Text(
              "Call your diver",
              style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryColor),
            ),
            const Spacer(),
            height10,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor.withOpacity(0.2),
                    shadowColor: Colors.transparent,
                    fixedSize:
                        Size((MediaQuery.sizeOf(context).width / 2) * 0.9, 60),
                  ),
                  onPressed: () {
                    NavigationUtils.tipDriverPage(context);
                  },
                  child: const Text("Cancel",
                      style: TextStyle(
                          color: AppColors.primaryColor, fontSize: 17)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    fixedSize:
                        Size((MediaQuery.sizeOf(context).width / 2) * 0.9, 60),
                  ),
                  onPressed: () {
                    NavigationUtils.tipDriverPage(context);
                  },
                  child: const Text("Submit",
                      style: TextStyle(color: Colors.white, fontSize: 17)),
                ),
              ],
            ),
            height10,
          ],
        ),
      ),
    );
  }
}
