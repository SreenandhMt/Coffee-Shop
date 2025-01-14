import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';
import '../../../core/size.dart';
import '../../../route/navigation_utils.dart';

class TipDriver extends StatefulWidget {
  const TipDriver({super.key});

  @override
  State<TipDriver> createState() => TipDriverState();
}

class TipDriverState extends State<TipDriver> {
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
                "Wow 5 Star!🤩",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            height5,
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                "Do you want to add additional tip to make your driver's day?",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
            height10,
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: List.generate(
                  10,
                  (index) => Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: index == 1 ? AppColors.primaryColor : null,
                            border: Border.all(
                                width: 1,
                                color: AppColors.secondaryColor(context))),
                        child: Text(
                          "\$${index + 1}",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: index == 1 ? Colors.white : null),
                        ),
                      )),
            ),
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
                    NavigationUtils.ratingShopPage(context);
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
                    NavigationUtils.ratingShopPage(context);
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
