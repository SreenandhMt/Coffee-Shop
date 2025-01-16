import 'package:coffee_app/core/app_colors.dart';
import 'package:coffee_app/core/fonts.dart';
import 'package:coffee_app/core/size.dart';
import 'package:coffee_app/features/auth/views/forgot_password/email_conform_page.dart';
import 'package:coffee_app/features/checkout/view_models/checkout_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ChooseAddressPage extends StatefulWidget {
  const ChooseAddressPage({super.key});

  @override
  State<ChooseAddressPage> createState() => _ChooseAddressPageState();
}

class _ChooseAddressPageState extends State<ChooseAddressPage> {
  final List<Map<String, dynamic>> address = [
    {
      "title": "Home",
      "name": "Andrew Ainsley",
      "number": "+1 111 467 378 399",
      "address": "701 7th Ave, New York, NY 10036, USA",
      "pin": true,
      "select": true
    },
    {
      "title": "Apartment",
      "name": "Andrew Ainsley",
      "number": "+1 111 467 378 399",
      "address": "Liberty Lsland, New York, NY 10036, USA",
      "pin": true,
      "select": false
    },
    {
      "title": "Mom's House",
      "name": "Jenny Wilson",
      "number": "+1 111 467 378 399",
      "address": "Central Park, New York, NY 10036, USA",
      "pin": true,
      "select": false
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: const [Icon(Icons.add), width10],
        title: Text("Choose Delivery Address", style: appBarTitleFont),
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
            itemCount: address.length,
            itemBuilder: (context, index) => Container(
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: address[index]["select"]
                      ? Border.all(color: AppColors.primaryColor, width: 2)
                      : Border.all(color: AppColors.secondaryColor(context))),
              child: InkWell(
                onTap: () {
                  setState(() {
                    for (var element in address) {
                      element["select"] = false;
                    }
                    address[index]["select"] = true;
                  });
                  context
                      .read<CheckoutViewModel>()
                      .selectAddress(address[index]);
                },
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          address[index]["title"],
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                        if (address[index]["select"]) ...[
                          width20,
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border:
                                    Border.all(color: AppColors.primaryColor)),
                            child: const Text(
                              "Main Address",
                              style: TextStyle(
                                  fontSize: 10, color: AppColors.primaryColor),
                            ),
                          ),
                        ],
                        const Spacer(),
                        const Icon(Icons.share_outlined)
                      ],
                    ),
                    height30,
                    Row(
                      children: [
                        Text(address[index]["name"],
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w700)),
                        width20,
                        Text("(${address[index]['number']})")
                      ],
                    ),
                    height10,
                    Row(
                      children: [
                        Text(address[index]["address"]),
                        if (address[index]["select"]) ...[
                          const Spacer(),
                          const Icon(Icons.done)
                        ]
                      ],
                    ),
                    height10,
                    const Row(
                      children: [
                        Icon(Icons.location_on_rounded),
                        Text("Pinpoint already")
                      ],
                    )
                  ],
                ),
              ),
            ),
          )),
          AuthButton(
            text: "OK",
            onPressed: () {
              if (context.read<CheckoutViewModel>().selectedAddress == null) {
                context.read<CheckoutViewModel>().selectAddress(address[0]);
              }
              context.pop();
            },
          )
        ],
      ),
    );
  }
}
