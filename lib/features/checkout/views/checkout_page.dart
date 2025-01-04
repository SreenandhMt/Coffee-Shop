import 'package:coffee_app/core/app_colors.dart';
import 'package:coffee_app/core/fonts.dart';
import 'package:coffee_app/core/size.dart';
import 'package:coffee_app/features/auth/views/forgot_password/email_conform_page.dart';
import 'package:coffee_app/features/buying/models/order_details_model.dart';
import 'package:coffee_app/features/checkout/view_models/checkout_view_model.dart';
import 'package:coffee_app/route/navigation_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => CheckoutPageState();
}

class CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final checkoutViewModel = context.watch<CheckoutViewModel>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Checkout", style: appBarTitleFont),
      ),
      body: ListView(
        children: [
          height10,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(2, (index) {
              bool isSelected = index == 0;
              return Container(
                width: (size.width / 2) * 0.96,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primaryColor
                        : AppColors.secondaryColor(context),
                    borderRadius: isSelected
                        ? BorderRadius.circular(10)
                        : const BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10))),
                alignment: Alignment.center,
                child: Text(index == 0 ? "Pick up" : "Delivery",
                    style: subtitleFont(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : null)),
              );
            }),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.secondaryColor(context)),
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                tileWidget(
                    onTap: () => showModalBottomSheet(
                          context: context,
                          builder: (context) => const ChoosePickUpWidget(),
                        ),
                    Icons.timer_sharp,
                    "Choose pick up time",
                    "Take orders directly at the shop",
                    Icons.arrow_forward_ios_rounded),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Divider(thickness: 0.1),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text("Take your order at:"),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      width10,
                      CircleAvatar(
                          backgroundColor: AppColors.secondaryColor(context),
                          child: Icon(
                            Icons.add_business_rounded,
                            color: AppColors.themeColor(context),
                          )),
                      width15,
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 4,
                        children: [
                          Text("Caffely Astoria Aromas",
                              style: subtitleFont(
                                  fontSize: 18, fontWeight: FontWeight.w800)),
                          const Text("350 5th Ave, New York, NY 10118, USA"),
                          const Text("1.2 km form your location"),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.secondaryColor(context)),
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      width10,
                      Text("Order Details",
                          style: subtitleFont(
                              fontSize: 19, fontWeight: FontWeight.bold)),
                      const Spacer(),
                      Container(
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: AppColors.primaryColor)),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.add,
                              color: AppColors.primaryColor,
                            ),
                            Text(
                              "Add more",
                              style: TextStyle(color: AppColors.primaryColor),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Divider(thickness: 0.1),
                ),
                ...List.generate(
                  checkoutViewModel.orderModel.length,
                  (index) {
                    return Column(
                      children: [
                        if (index != 0)
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Divider(thickness: 0.1),
                          ),
                        productDetailsWidget(
                            checkoutViewModel.orderModel[index], size),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.secondaryColor(context)),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: Text("Order Discount",
                        style: subtitleFont(
                            fontSize: 19, fontWeight: FontWeight.bold)),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Divider(thickness: 0.1),
                  ),
                  tileWidget(
                      onTap: () => NavigationUtils.chooseVouchersPage(context),
                      Icons.discount_outlined,
                      "Use Vouchers",
                      "Save orders with promos",
                      Icons.arrow_forward_ios_rounded),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Divider(thickness: 0.1),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        width10,
                        CircleAvatar(
                            backgroundColor: AppColors.secondaryColor(context),
                            child: Icon(
                              Icons.motion_photos_on_rounded,
                              color: AppColors.themeColor(context),
                            )),
                        width15,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 4,
                          children: [
                            Text("200 Points",
                                style: subtitleFont(
                                    fontSize: 18, fontWeight: FontWeight.w800)),
                            const Text("100 points equals \$1.00"),
                          ],
                        ),
                        const Spacer(),
                        CupertinoSwitch(
                          value: false,
                          onChanged: (value) {},
                        )
                      ],
                    ),
                  ),
                ],
              )),
          Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.secondaryColor(context)),
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Text("Payment Method",
                      style: subtitleFont(
                          fontSize: 19, fontWeight: FontWeight.bold)),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Divider(thickness: 0.1),
                ),
                tileWidget(
                    onTap: () => NavigationUtils.choosePaymentPage(context),
                    Icons.payment,
                    "Choose Payment",
                    "Choose your payment method",
                    Icons.arrow_forward_ios_rounded),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.secondaryColor(context)),
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Text("Payment Details",
                      style: subtitleFont(
                          fontSize: 19, fontWeight: FontWeight.bold)),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Divider(thickness: 0.1),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Grand Subtitle",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "\$50.0",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Service Fee",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "\$1.00",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Divider(thickness: 0.1),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Payment",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "\$51.0",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          AuthButton(text: "Place Order", onPressed: () {})
        ],
      ),
    );
  }

  productDetailsWidget(OrderDetailsModel orderModel, size) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin:
                const EdgeInsets.only(left: 10, right: 5, bottom: 5, top: 5),
            decoration: BoxDecoration(
                color: AppColors.secondaryColor(context),
                image: DecorationImage(
                    image: AssetImage(orderModel.productModel.imagePath)),
                borderRadius: BorderRadius.circular(10)),
            height: 100,
            width: size.width * 0.25),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4,
              children: [
                Text(
                  "${orderModel.quantity}x ${orderModel.productModel.name}",
                  style:
                      subtitleFont(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                Text(
                  orderModel.type!,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w500),
                ),
                height5,
                productInfoWidget(
                  "Base price",
                  orderModel.productModel.price,
                  FontWeight.w700,
                ),
                productInfoWidget(
                  "Size (${orderModel.selectSizeName})",
                  "+ ${orderModel.selectSizePrice}",
                  null,
                ),
                if (orderModel.selectMilkName != null &&
                    orderModel.selectMilkName!.isNotEmpty)
                  productInfoWidget(
                    "1 x ${orderModel.selectMilkName}",
                    "+ ${orderModel.selectMilkPrice}",
                    null,
                  ),
                if (orderModel.selectSyrupName != null &&
                    orderModel.selectSyrupName!.isNotEmpty)
                  productInfoWidget(
                    "1 x ${orderModel.selectSyrupName}",
                    "+ ${orderModel.selectSyrupPrice}",
                    null,
                  ),
                if (orderModel.selectToppingsName != null &&
                    orderModel.selectToppingsName!.isNotEmpty)
                  productInfoWidget(
                    "1 x ${orderModel.selectToppingsName}",
                    "+ ${orderModel.selectToppingsPrice}",
                    null,
                  ),
                productInfoWidget(
                  "Subtotal",
                  "${orderModel.totalPrice}",
                  FontWeight.w700,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  productInfoWidget(String title, String price, FontWeight? fontWeight) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 15, fontWeight: fontWeight ?? FontWeight.w500),
        ),
        Text(
          "\$$price",
          style: TextStyle(
              fontSize: 15, fontWeight: fontWeight ?? FontWeight.w500),
        )
      ],
    );
  }

  tileWidget(
      IconData startIcon, String title, String subtitle, IconData? endIcon,
      {void Function()? onTap}) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            width10,
            CircleAvatar(
                backgroundColor: AppColors.secondaryColor(context),
                child: Icon(
                  startIcon,
                  color: AppColors.themeColor(context),
                )),
            width15,
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4,
              children: [
                Text(title,
                    style: subtitleFont(
                        fontSize: 18, fontWeight: FontWeight.w800)),
                Text(subtitle),
              ],
            ),
            const Spacer(),
            if (endIcon == null)
              CupertinoSwitch(
                value: false,
                onChanged: (value) {},
              )
            else
              Icon(endIcon)
          ],
        ),
      ),
    );
  }
}

class ChoosePickUpWidget extends StatefulWidget {
  const ChoosePickUpWidget({super.key});

  @override
  State<ChoosePickUpWidget> createState() => _ChoosePickUpWidgetState();
}

class _ChoosePickUpWidgetState extends State<ChoosePickUpWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            margin: const EdgeInsets.all(5),
            width: 70,
            height: 1,
            color: AppColors.themeColor(context)),
        height15,
        Text("Choose pick up time",
            style: subtitleFont(fontSize: 19, fontWeight: FontWeight.bold)),
        height35,
        Container(
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.primaryColor, width: 2),
              borderRadius: BorderRadius.circular(15)),
          child: Row(
            children: [
              width5,
              CircleAvatar(
                  radius: 25,
                  backgroundColor: AppColors.secondaryColor(context),
                  child: Icon(Icons.check_circle_outline_rounded,
                      color: AppColors.themeColor(context))),
              width10,
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                spacing: 5,
                children: [
                  Text("Pick up now",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  Text("Estimated ready in 15 mins.")
                ],
              )
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
              border: Border.all(
                  color: AppColors.secondaryColor(context), width: 2),
              borderRadius: BorderRadius.circular(15)),
          child: InkWell(
            onTap: () {
              context.pop();
              showModalBottomSheet(
                context: context,
                builder: (context) => const PickUptimePicker(),
              );
            },
            child: Row(
              children: [
                width5,
                CircleAvatar(
                    radius: 25,
                    backgroundColor: AppColors.secondaryColor(context),
                    child: Icon(
                      Icons.timer_outlined,
                      color: AppColors.themeColor(context),
                    )),
                width10,
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  spacing: 5,
                  children: [
                    Text("Pick up later",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                    Text("Set your pick up time.")
                  ],
                ),
                const Spacer(),
                const Icon(Icons.arrow_forward_ios_rounded),
                width5,
              ],
            ),
          ),
        ),
        height20,
        AuthButton(
            text: "Conform",
            onPressed: () {
              context.pop();
            })
      ],
    );
  }
}

class PickUptimePicker extends StatefulWidget {
  const PickUptimePicker({super.key});

  @override
  State<PickUptimePicker> createState() => _PickUptimePickerState();
}

class _PickUptimePickerState extends State<PickUptimePicker> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            margin: const EdgeInsets.all(5),
            width: 70,
            height: 1,
            color: AppColors.themeColor(context)),
        height15,
        Text("Set your pick up time",
            style: subtitleFont(fontSize: 19, fontWeight: FontWeight.bold)),
        height35,
        const Text("Today, Dec 22 2023",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
        height20,
        const Text("11    :    59",
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.w700, color: Colors.grey)),
        height5,
        const Text("12    :    00",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700)),
        height5,
        const Text("13    :    0.1",
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.w700, color: Colors.grey)),
        height20,
        AuthButton(
            text: "Set Time",
            onPressed: () {
              context.pop();
            })
      ],
    );
  }
}
