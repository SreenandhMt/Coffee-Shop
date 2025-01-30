import 'package:coffee_app/core/assets.dart';
import 'package:coffee_app/features/auth/views/signin_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:coffee_app/core/app_colors.dart';
import 'package:coffee_app/core/fonts.dart';
import 'package:coffee_app/core/size.dart';
import 'package:coffee_app/features/auth/views/forgot_password/email_conform_page.dart';
import 'package:coffee_app/features/checkout/view_models/checkout_view_model.dart';

class ChoosePaymentPage extends ConsumerStatefulWidget {
  const ChoosePaymentPage({
    super.key,
    this.isTopUpPage = false,
  });
  final bool isTopUpPage;

  @override
  ConsumerState<ChoosePaymentPage> createState() => ChoosePaymentPageState();
}

class ChoosePaymentPageState extends ConsumerState<ChoosePaymentPage> {
  final paymentMethods = [
    {"name": "Wallet", "image": ""},
    {"name": "Stripe", "image": AppAssets.stripeLogo},
  ];
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => ref
        .read(checkoutViewModelProvider.notifier)
        .setPaymentMethod(paymentMethods[0]));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(checkoutViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.isTopUpPage
                ? "Choose Top Up Method"
                : 'Choose Payment Method',
            style: appBarTitleFont),
        actions: const [
          Icon(Icons.add),
          width10,
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                if (widget.isTopUpPage)
                  ...List.generate(
                    paymentMethods.length,
                    (index) => PaymentWidget(
                        paymentMethod: paymentMethods[index],
                        selected:
                            viewModel.paymentMethod == paymentMethods[index]),
                  )
                else
                  ...List.generate(
                    paymentMethods.length,
                    (index) => PaymentWidget(
                        paymentMethod: paymentMethods[index],
                        selected:
                            viewModel.paymentMethod == paymentMethods[index]),
                  ),
              ],
            ),
          ),
          if (widget.isTopUpPage)
            AuthButton(
              text: "Conform Top Up - \$100.00",
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => DialogBox(
                    icon: Icons.check_box_rounded,
                    title: "Top Up Successful!",
                    subtitle:
                        "The amount of \$100 hs been added to your wallet",
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              fixedSize: const Size(double.infinity, 60),
                            ),
                            onPressed: () {
                              if (context.canPop()) context.pop();
                              if (context.canPop()) context.pop();
                              if (context.canPop()) context.pop();
                            },
                            child: const Text("OK",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17)),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          else
            AuthButton(
              text: "OK",
              onPressed: () {
                if (context.canPop()) context.pop();
              },
            )
        ],
      ),
    );
  }
}

class PaymentWidget extends ConsumerStatefulWidget {
  const PaymentWidget({
    super.key,
    required this.paymentMethod,
    required this.selected,
  });
  final Map<String, dynamic> paymentMethod;
  final bool selected;

  @override
  ConsumerState<PaymentWidget> createState() => _PaymentWidgetState();
}

class _PaymentWidgetState extends ConsumerState<PaymentWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.paymentMethod["name"] == "Wallet") {
      return InkWell(
        onTap: () => ref
            .read(checkoutViewModelProvider.notifier)
            .setPaymentMethod(widget.paymentMethod),
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
      return InkWell(
        onTap: () => ref
            .read(checkoutViewModelProvider.notifier)
            .setPaymentMethod(widget.paymentMethod),
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
                backgroundImage:
                    AssetImage(widget.paymentMethod["image"] ?? ""),
              ),
              width20,
              Text(
                widget.paymentMethod["name"] ?? "",
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
}
