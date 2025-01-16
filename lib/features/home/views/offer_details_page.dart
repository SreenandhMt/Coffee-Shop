import 'package:coffee_app/core/fonts.dart';
import 'package:coffee_app/core/size.dart';
import 'package:coffee_app/features/auth/views/forgot_password/email_conform_page.dart';
import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';

class OfferDetailsPage extends StatefulWidget {
  const OfferDetailsPage({super.key});

  @override
  State<OfferDetailsPage> createState() => _OfferDetailsPageState();
}

class _OfferDetailsPageState extends State<OfferDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Special Offer", style: appBarTitleFont),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView(
              children: [
                Container(
                  width: double.infinity,
                  height: 200,
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.secondaryColor(context),
                    borderRadius: BorderRadius.circular(15),
                    image: const DecorationImage(
                      image: AssetImage("assets/banner1.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20, top: 5, bottom: 10),
                  child: Text("30% OFF - Limited Time Offer!",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    "Wake up and smell the savings! Enjoy a fantastic 30% discount on all our coffee creations.",
                    style:
                        subtitleFont(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(
                      left: 20, right: 20, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.secondaryColor(context)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SelectableText(
                        "XM4LWP3",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.copy_rounded))
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 15, bottom: 15),
                  margin: const EdgeInsets.only(
                      left: 15, right: 15, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                          color: AppColors.themeColor(context), width: 0.3)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.access_time_filled_rounded,
                            color: AppColors.primaryColor,
                          ),
                          width10,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Valid unit",
                                style: subtitleFont(
                                    fontSize: 14, fontWeight: FontWeight.w400),
                              ),
                              height5,
                              const Text(
                                "Dec 31, 2023",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w700),
                              )
                            ],
                          )
                        ],
                      ),
                      Container(
                          width: 0.5,
                          height: 30,
                          color: AppColors.themeColor(context)),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.payment_rounded,
                            color: AppColors.primaryColor,
                          ),
                          width10,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Min transaction",
                                style: subtitleFont(
                                    fontSize: 14, fontWeight: FontWeight.w400),
                              ),
                              height5,
                              const Text(
                                "\$2.50",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w700),
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20, top: 5, bottom: 10),
                  child: Text("Terms and Conditions",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    "1. Promotion period. The Caffely 30% discount\n   promotion is valid form December 20, 2023, to \n   December 31, 2023. All eligible orders must be\n   placed within this period to avail of the discount.\n2. Eliaibilitv: The promotion is open to all customers",
                    style:
                        subtitleFont(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
                height10,
              ],
            ),
          ),
          AuthButton(text: "Claim Discount", onPressed: () {})
        ],
      ),
    );
  }
}
