import 'package:coffee_app/core/app_colors.dart';
import 'package:coffee_app/core/fonts.dart';
import 'package:coffee_app/core/size.dart';
import 'package:coffee_app/features/auth/views/forgot_password/email_conform_page.dart';
import 'package:coffee_app/features/auth/views/signin_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CancelOrderPage extends StatefulWidget {
  const CancelOrderPage({super.key});

  @override
  State<CancelOrderPage> createState() => _CancelOrderPageState();
}

class _CancelOrderPageState extends State<CancelOrderPage> {
  List<String> reasons = [
    "Change of Mind",
    "Long Wait Time",
    "Incorrect Order",
    "Sudden Urgency",
    "Unavailability",
    "Price Concerns",
    "Dietary Restrictions or Allergies",
    "Temperature Preference",
    "Unfavorable Reviews",
    "Inadequate Seating or Environment",
    "Technical Issues",
    "Other"
  ];
  String currentValue = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Cancel Order", style: appBarTitleFont),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Text(
              "Choose a reason for cancellation:",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
            ),
          ),
          ...List.generate(
            reasons.length,
            (index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                children: [
                  width5,
                  Radio(
                      value: reasons[index],
                      groupValue: currentValue,
                      fillColor: const WidgetStatePropertyAll(Colors.green),
                      onChanged: (value) {
                        setState(() {
                          currentValue = value!;
                        });
                      }),
                  Text(
                    reasons[index],
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          AuthButton(
              text: "Cancel Order",
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                          spacing: 10,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            height20,
                            const Text(
                              "Cancel Order",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.red,
                              ),
                            ),
                            const Divider(thickness: 0.1),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                "Are you sure you want to cancel the order?",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 23, fontWeight: FontWeight.w700),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: RichText(
                                  text: TextSpan(
                                      text:
                                          "Only 90% of funds will be returned to your account based on our ",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.themeColor(context)),
                                      children: const [
                                    TextSpan(
                                        text: "terms and conditions",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.green))
                                  ])),
                            ),
                            height10,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        AppColors.primaryColor.withOpacity(0.2),
                                    shadowColor: Colors.transparent,
                                    fixedSize: Size(
                                        (MediaQuery.sizeOf(context).width / 2) *
                                            0.9,
                                        60),
                                  ),
                                  onPressed: () {
                                    context.pop();
                                  },
                                  child: const Text("No. Don't Cancel",
                                      style: TextStyle(
                                          color: AppColors.primaryColor,
                                          fontSize: 17)),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primaryColor,
                                    fixedSize: Size(
                                        (MediaQuery.sizeOf(context).width / 2) *
                                            0.9,
                                        60),
                                  ),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => DialogBox(
                                        icon: Icons.check_box_rounded,
                                        title: "Order Successfully Cancelled",
                                        subtitle:
                                            "90% of the bunds have been returned to your account.",
                                        child: Column(
                                          children: [
                                            height15,
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor: AppColors
                                                          .primaryColor,
                                                      fixedSize: const Size(
                                                          double.infinity, 60),
                                                    ),
                                                    onPressed: () {
                                                      context.go("/");
                                                    },
                                                    child: const Text("OK",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 17)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            height10
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Text("Yes, Cancel",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 17)),
                                ),
                              ],
                            ),
                            height10,
                          ]),
                    );
                  },
                );
              })
        ],
      ),
    );
  }
}
