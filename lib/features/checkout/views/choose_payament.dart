import 'package:coffee_app/core/app_colors.dart';
import 'package:coffee_app/core/fonts.dart';
import 'package:coffee_app/core/size.dart';
import 'package:coffee_app/features/auth/views/forgot_password/email_conform_page.dart';
import 'package:coffee_app/route/navigation_utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChoosePaymentPage extends StatefulWidget {
  const ChoosePaymentPage({super.key});

  @override
  State<ChoosePaymentPage> createState() => ChoosePaymentPageState();
}

class ChoosePaymentPageState extends State<ChoosePaymentPage> {
  @override
  Widget build(BuildContext context) {
    final paymentMethods = [
      "PayPal",
      "Google Pay",
      "Apple Pay",
      ".... .... .... .... 4676",
      ".... .... .... .... 5567"
    ];
    final images = [
      "https://cdn-icons-png.flaticon.com/512/2504/2504802.png",
      "https://w7.pngwing.com/pngs/63/1016/png-transparent-google-logo-google-logo-g-suite-chrome-text-logo-chrome.png",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR2XR3uve98Zaune2n4CVHaAjR6ReZwmcwHYg&s",
      "https://static-00.iconduck.com/assets.00/mastercard-icon-2048x1286-s6y46dfh.png",
      "https://w7.pngwing.com/pngs/167/298/png-transparent-card-credit-logo-visa-logos-and-brands-icon-thumbnail.png"
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Payment Method', style: appBarTitleFont),
        actions: const [
          Icon(Icons.add),
          width10,
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: AppColors.primaryColor, width: 2)),
            child: const Row(
              children: [
                Icon(
                  Icons.wallet,
                  size: 60,
                  color: AppColors.primaryColor,
                ),
                width10,
                Text(
                  "My Wallet",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                Spacer(),
                Text("\$948.50",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryColor)),
                width5,
                Icon(Icons.check_rounded, color: AppColors.primaryColor)
              ],
            ),
          ),
          ...List.generate(
            images.length,
            (index) => Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.secondaryColor(context))),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(images[index]),
                  ),
                  width20,
                  Text(
                    paymentMethods[index],
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
          ),
          AuthButton(
            text: "OK",
            onPressed: () {
              if (context.canPop()) context.pop();
              if (context.canPop()) context.pop();
              NavigationUtils.checkoutPage(context);
            },
          )
        ],
      ),
    );
  }
}
