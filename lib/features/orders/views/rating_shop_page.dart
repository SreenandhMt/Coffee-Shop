import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';
import '../../../core/size.dart';
import '../../../route/navigation_utils.dart';

class RatingShopPage extends StatefulWidget {
  const RatingShopPage({super.key});

  @override
  State<RatingShopPage> createState() => _RatingShopPageState();
}

class _RatingShopPageState extends State<RatingShopPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          spacing: 10,
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(15)),
            ),
            height15,
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                "Enjoyed your coffee?",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
              ),
            ),
            height10,
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                "Rate the shop. your feedback is matters.",
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
                  Icons.star_border_rounded,
                  color: null,
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
            const Spacer(),
            const Row(
              children: [
                width10,
                Text("Leave your review",
                    style:
                        TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
              ],
            ),
            TextFormField(
                maxLines: 4,
                style: TextStyle(
                    fontSize: 16, color: AppColors.themeColor(context)),
                decoration: InputDecoration(
                    hintText: "Example: Good coffee",
                    hintStyle:
                        const TextStyle(fontSize: 16, color: Colors.grey),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none))),
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
                    NavigationUtils.showHomeSuccessPage(context);
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
                    NavigationUtils.showHomeSuccessPage(context);
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
