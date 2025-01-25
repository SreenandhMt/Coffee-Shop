import 'package:coffee_app/core/app_colors.dart';
import 'package:coffee_app/core/fonts.dart';
import 'package:coffee_app/core/size.dart';
import 'package:coffee_app/features/checkout/views/driver_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view_models/coffee_shop_view_model.dart';

class AboutShopPage extends ConsumerWidget {
  const AboutShopPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shopState = ref.read(shopDetailsViewModelProvider);
    final aboutData = shopState.shopModel!.about;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(shopState.shopModel!.name,
                  style: titleFonts(fontSize: 25)),
            ),
            height15,
            Padding(
              padding: const EdgeInsets.only(left: 15, bottom: 5),
              child: Text(
                "About",
                style: titleFonts(fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Text(
                aboutData!["about"],
                style: subtitleFont(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
            height20,
            ...List.generate(
              aboutData["opening"].length,
              (index) => Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15, bottom: 5),
                    child: Text(aboutData["opening"][index]["days"],
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600)),
                  ),
                  const Spacer(),
                  const Text(":",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 15, bottom: 5),
                    child: Text("${aboutData["opening"][index]["times"]}",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 15),
            //   child: Text("Saturday - Sunday   : 12:00 - 20.00",
            //       style: titleFonts(fontSize: 20, fontWeight: FontWeight.w600)),
            // ),
            height20,
            Padding(
              padding: const EdgeInsets.only(left: 15, bottom: 5),
              child: Text(
                "Address",
                style: titleFonts(fontSize: 20),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Icon(Icons.location_on_rounded, color: Colors.green),
                  width10,
                  Text(
                    "350 5th Ave, New York, NY 10118, USA",
                    style: TextStyle(fontSize: 15),
                  )
                ],
              ),
            ),
            height20,
            GestureDetector(
              onScaleUpdate: (value) {},
              child: Container(
                width: double.infinity,
                clipBehavior: Clip.hardEdge,
                height: 250,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.backgroundColor(context)),
                child: const GoogleMapWidget(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
