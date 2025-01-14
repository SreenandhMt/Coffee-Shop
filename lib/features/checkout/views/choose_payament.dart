import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:coffee_app/core/app_colors.dart';
import 'package:coffee_app/core/fonts.dart';
import 'package:coffee_app/core/size.dart';
import 'package:coffee_app/features/auth/views/forgot_password/email_conform_page.dart';
import 'package:coffee_app/features/checkout/view_models/checkout_view_model.dart';
import 'package:coffee_app/route/navigation_utils.dart';

class ChoosePaymentPage extends StatefulWidget {
  const ChoosePaymentPage({super.key});

  @override
  State<ChoosePaymentPage> createState() => ChoosePaymentPageState();
}

class ChoosePaymentPageState extends State<ChoosePaymentPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) =>
        context.read<CheckoutViewModel>().setPaymentMethod("Wallet"));
    super.initState();
  }

  final paymentMethods = [
    "Wallet",
    "PayPal",
    "Google Pay",
    "Apple Pay",
    ".... .... .... .... 4676",
    ".... .... .... .... 5567"
  ];

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<CheckoutViewModel>();
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
          ...List.generate(
            paymentMethods.length,
            (index) => PaymentWidget(
                paymentMethod: paymentMethods[index],
                selected: viewModel.paymentMethod == paymentMethods[index]),
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

class PaymentWidget extends StatefulWidget {
  const PaymentWidget({
    super.key,
    required this.paymentMethod,
    required this.selected,
  });
  final String paymentMethod;
  final bool selected;

  @override
  State<PaymentWidget> createState() => _PaymentWidgetState();
}

class _PaymentWidgetState extends State<PaymentWidget> {
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
    if (widget.paymentMethod == "Wallet") {
      return InkWell(
        onTap: () =>
            context.read<CheckoutViewModel>().setPaymentMethod("Wallet"),
        child: Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                  color: !widget.selected
                      ? AppColors.secondaryColor(context)
                      : AppColors.primaryColor,
                  width: 2)),
          child: Row(
            children: [
              Icon(
                Icons.wallet,
                size: 60,
                color: widget.selected ? AppColors.primaryColor : null,
              ),
              width10,
              const Text(
                "My Wallet",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              const Spacer(),
              Text("\$948.50",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: widget.selected ? AppColors.primaryColor : null)),
              width5,
              Icon(Icons.check_rounded,
                  color: widget.selected ? AppColors.primaryColor : null)
            ],
          ),
        ),
      );
    } else {
      for (int i = 0; i < paymentMethods.length; i++) {
        if (paymentMethods[i] == widget.paymentMethod) {
          return InkWell(
            onTap: () => context
                .read<CheckoutViewModel>()
                .setPaymentMethod(paymentMethods[i]),
            child: Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: !widget.selected
                          ? AppColors.secondaryColor(context)
                          : AppColors.primaryColor,
                      width: 2)),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(images[i]),
                  ),
                  width20,
                  Text(
                    paymentMethods[i],
                    style: TextStyle(
                        color: widget.selected ? AppColors.primaryColor : null,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
          );
        }
      }
      return const SizedBox();
    }
  }
}
