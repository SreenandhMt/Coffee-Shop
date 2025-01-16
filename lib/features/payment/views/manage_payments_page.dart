import 'package:coffee_app/route/navigation_utils.dart';
import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';
import '../../../core/fonts.dart';
import '../../../core/size.dart';

class ManagePaymentsPage extends StatefulWidget {
  const ManagePaymentsPage({super.key});

  @override
  State<ManagePaymentsPage> createState() => _ManagePaymentsPageState();
}

class _ManagePaymentsPageState extends State<ManagePaymentsPage> {
  final paymentMethods = [
    "PayPal",
    "Google Pay",
    "Apple Pay",
    ".... .... .... .... 4676",
    ".... .... .... .... 5567"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Payment Method", style: appBarTitleFont),
        actions: [
          IconButton(
              onPressed: () => NavigationUtils.addNewPaymentMethodPage(context),
              icon: const Icon(Icons.add)),
          width10,
        ],
      ),
      body: ListView(
        children: List.generate(
          paymentMethods.length,
          (index) =>
              ConnectedPaymentWidget(paymentMethod: paymentMethods[index]),
        ),
      ),
    );
  }
}

class ConnectedPaymentWidget extends StatefulWidget {
  const ConnectedPaymentWidget({super.key, required this.paymentMethod});
  final String paymentMethod;

  @override
  State<ConnectedPaymentWidget> createState() => _ConnectedPaymentWidgetState();
}

class _ConnectedPaymentWidgetState extends State<ConnectedPaymentWidget> {
  final paymentMethods = [
    "Wallet",
    "PayPal",
    "Google Pay",
    "Apple Pay",
    ".... .... .... .... 4676",
    ".... .... .... .... 5567"
  ];
  final images = [
    "",
    "https://cdn-icons-png.flaticon.com/512/2504/2504802.png",
    "https://w7.pngwing.com/pngs/63/1016/png-transparent-google-logo-google-logo-g-suite-chrome-text-logo-chrome.png",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR2XR3uve98Zaune2n4CVHaAjR6ReZwmcwHYg&s",
    "https://static-00.iconduck.com/assets.00/mastercard-icon-2048x1286-s6y46dfh.png",
    "https://w7.pngwing.com/pngs/167/298/png-transparent-card-credit-logo-visa-logos-and-brands-icon-thumbnail.png"
  ];
  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < paymentMethods.length; i++) {
      if (paymentMethods[i] == widget.paymentMethod) {
        return InkWell(
          child: Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: AppColors.secondaryColor(context), width: 0.5)),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: AppColors.secondaryColor(context),
                  backgroundImage: NetworkImage(images[i]),
                ),
                width20,
                Text(
                  paymentMethods[i],
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const Spacer(),
                const Text(
                  "Connected",
                  style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
        );
      }
    }
    return const SizedBox();
  }
}
