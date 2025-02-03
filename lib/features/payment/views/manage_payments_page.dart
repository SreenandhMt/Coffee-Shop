import 'package:coffee_app/route/navigation_utils.dart';
import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';
import '../../../core/assets.dart';
import '../../../core/fonts.dart';
import '../../../core/size.dart';

class ManagePaymentsPage extends StatefulWidget {
  const ManagePaymentsPage({super.key});

  @override
  State<ManagePaymentsPage> createState() => _ManagePaymentsPageState();
}

class _ManagePaymentsPageState extends State<ManagePaymentsPage> {
  final paymentMethods = [
    {"name": "Stripe", "image": AppAssets.stripeLogo},
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
  final Map<String, String> paymentMethod;

  @override
  State<ConnectedPaymentWidget> createState() => _ConnectedPaymentWidgetState();
}

class _ConnectedPaymentWidgetState extends State<ConnectedPaymentWidget> {
  @override
  Widget build(BuildContext context) {
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
              backgroundImage: AssetImage(widget.paymentMethod["image"] ?? ""),
            ),
            width20,
            Text(
              widget.paymentMethod["name"] ?? "",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
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
