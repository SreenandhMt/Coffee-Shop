import 'package:coffee_app/core/app_colors.dart';
import 'package:coffee_app/core/fonts.dart';
import 'package:coffee_app/core/size.dart';
import 'package:coffee_app/features/auth/views/forgot_password/email_conform_page.dart';
import 'package:coffee_app/features/checkout/view_models/checkout_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ChooseDeliveryPage extends StatefulWidget {
  const ChooseDeliveryPage({super.key});

  @override
  State<ChooseDeliveryPage> createState() => _ChooseDeliveryPageState();
}

class _ChooseDeliveryPageState extends State<ChooseDeliveryPage> {
  List<Map<String, dynamic>> deliveryServices = [
    {
      "name": "DoorDash Drive",
      "url":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTeUx0hB9BEW3CVZvR6zvceYadzvFBg0jAYkg&s",
      "price": 1.00,
      "active": true
    },
    {
      "name": "Chowbus",
      "url":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR6mjg0_SUkvnvTar90kyb19cQCw5_hcOul2w&s",
      "price": 1.50,
      "active": false
    },
    {
      "name": "Rapidus",
      "url":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT4Kzg5QUzh2as4xVYzG-6wKOJeNyY_xs7bNw&s",
      "price": 0.80,
      "active": false
    },
    {
      "name": "Roadie",
      "url":
          "https://play-lh.googleusercontent.com/uCpP1a7Pvy6hInBErTH_qLHdhKcBJkk0xWIT83sR-Jfly2EmC6WNVmbcrYxabBlfnrEb",
      "price": 1.00,
      "active": false
    },
    {
      "name": "Zifty",
      "url":
          "https://play-lh.googleusercontent.com/REBf1c9KFzIukX7cpDZWG8BlguwSuVrzjI4Lpm_I-v3xWItZbP21IobBs-XI3iINwQ",
      "price": 1.25,
      "active": false
    },
    {
      "name": "Caviar",
      "url":
          "https://play-lh.googleusercontent.com/KTEMnvGI9YajzYAHpDSPk8T6KjxveyBNAa5YYNjuzhHids6Sxwww76Z57iqVi76Ho2A",
      "price": 1.00,
      "active": false
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Choose Delivery Service", style: appBarTitleFont),
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
            itemCount: deliveryServices.length,
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                setState(() {
                  for (var element in deliveryServices) {
                    element["active"] = false;
                  }
                  deliveryServices[index]["active"] = true;
                });
                context
                    .read<CheckoutViewModel>()
                    .selectDeliveryService(deliveryServices[index]);
              },
              child: Container(
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: deliveryServices[index]["active"]
                        ? Border.all(color: AppColors.primaryColor, width: 2)
                        : Border.all(color: AppColors.secondaryColor(context))),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundImage:
                          NetworkImage(deliveryServices[index]["url"]),
                    ),
                    width15,
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(deliveryServices[index]["name"],
                              style: const TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w700)),
                          Text("\$${deliveryServices[index]["price"]}"),
                        ],
                      ),
                    ),
                    if (deliveryServices[index]["active"]) ...[
                      const Icon(Icons.done, color: AppColors.primaryColor),
                      width10
                    ]
                  ],
                ),
              ),
            ),
          )),
          AuthButton(
            text: "OK",
            onPressed: () {
              if (context.read<CheckoutViewModel>().selectedDelivery == null) {
                context
                    .read<CheckoutViewModel>()
                    .selectDeliveryService(deliveryServices[0]);
              }
              context.pop();
            },
          )
        ],
      ),
    );
  }
}
