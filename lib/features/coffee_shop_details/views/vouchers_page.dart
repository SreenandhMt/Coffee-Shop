import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:coffee_app/core/fonts.dart';

import '../../../core/app_colors.dart';
import '../../../core/size.dart';
import '../../auth/views/forgot_password/email_conform_page.dart';
import '../../checkout/view_models/checkout_view_model.dart';

class VouchersAndDiscountPage extends StatefulWidget {
  const VouchersAndDiscountPage({
    super.key,
    this.isBuyingPage = false,
  });
  final bool isBuyingPage;

  @override
  State<VouchersAndDiscountPage> createState() =>
      _VouchersAndDiscountPageState();
}

class _VouchersAndDiscountPageState extends State<VouchersAndDiscountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
            widget.isBuyingPage ? "Vouchers Available" : "Vouchers & Discount",
            style: appBarTitleFont),
        actions: const [Icon(Icons.search, size: 30)],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Container(
                  padding: const EdgeInsets.all(15),
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Early Bird Brews",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w700),
                      ),
                      const Text(
                          "Enjoy 20% off an all coffee orders before 10 AM!"),
                      height10,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.timer_outlined),
                          width5,
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Valid until",
                                style: TextStyle(fontSize: 13),
                              ),
                              height5,
                              Text(
                                "Dec 31, 2023",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w700),
                              )
                            ],
                          ),
                          width10,
                          const Icon(Icons.payment),
                          width5,
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Min transaction",
                                style: TextStyle(fontSize: 13),
                              ),
                              height5,
                              Text(
                                "\$3.00",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                          const Spacer(),
                          ElevatedButton(
                              onPressed: () {},
                              style: const ButtonStyle(
                                  backgroundColor: WidgetStatePropertyAll(
                                      AppColors.primaryColor)),
                              child: const Text(
                                "Use",
                                style: TextStyle(color: Colors.white),
                              ))
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(15),
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Early Bird Brews",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w700),
                      ),
                      const Text(
                          "Enjoy 20% off an all coffee orders before 10 AM!"),
                      height10,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.timer_outlined),
                          width5,
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Valid until",
                                style: TextStyle(fontSize: 13),
                              ),
                              height5,
                              Text(
                                "Dec 31, 2023",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w700),
                              )
                            ],
                          ),
                          width10,
                          const Icon(Icons.payment),
                          width5,
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Min transaction",
                                style: TextStyle(fontSize: 13),
                              ),
                              height5,
                              Text(
                                "\$3.00",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                          const Spacer(),
                          ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                  backgroundColor: WidgetStatePropertyAll(
                                      AppColors.secondaryColor(context))),
                              child: const Text(
                                "Used",
                                style: TextStyle(color: Colors.white),
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (widget.isBuyingPage) ...[
            AuthButton(
                text: "OK",
                onPressed: () {
                  context.read<CheckoutViewModel>().addPromos("XM4LWP3");
                  context.pop();
                })
          ]
        ],
      ),
    );
  }
}
