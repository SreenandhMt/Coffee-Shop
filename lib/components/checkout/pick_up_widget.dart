import 'package:coffee_app/components/checkout/product_details_widget.dart';
import 'package:coffee_app/components/checkout/promo_widget.dart';
import 'package:coffee_app/components/checkout/tile_widget.dart';
import 'package:coffee_app/components/checkout/title_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/app_colors.dart';
import '../../core/fonts.dart';
import '../../core/size.dart';
import '../../features/auth/views/forgot_password/email_conform_page.dart';
import '../../features/auth/views/signin_page.dart';
import '../../features/checkout/view_models/checkout_view_model.dart';
import '../../route/navigation_utils.dart';
import 'payment_widget.dart';

class PickupWidgets extends ConsumerStatefulWidget {
  const PickupWidgets({
    super.key,
    this.isOrderDetails = false,
    required this.shopId,
  });
  final bool isOrderDetails;
  final String shopId;

  @override
  ConsumerState<PickupWidgets> createState() => _PickupWidgetsState();
}

class _PickupWidgetsState extends ConsumerState<PickupWidgets> {
  @override
  Widget build(BuildContext context) {
    final checkoutViewModel = ref.watch(checkoutViewModelProvider);
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.secondaryColor(context)),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TileWidget(
                  onTap: () => showModalBottomSheet(
                        context: context,
                        builder: (context) => const ChoosePickUpWidget(),
                      ),
                  startIcon: Icons.timer_sharp,
                  title: checkoutViewModel.pickUpTime ?? "Choose pick up time",
                  subtitle: checkoutViewModel.pickUpDate ??
                      "Take orders directly at the shop",
                  endIcon: Icons.arrow_forward_ios_rounded),
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
        CheckoutTitleWidget(
            text: "Order Details",
            action: widget.isOrderDetails
                ? null
                : Container(
                    margin: const EdgeInsets.all(5),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                  ),
            child: Column(
              children: List.generate(
                checkoutViewModel.orderModels.length,
                (index) {
                  return Column(
                    children: [
                      if (index != 0)
                        const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Divider(thickness: 0.1),
                        ),
                      ProductDetailsWidget(
                          orderModel: checkoutViewModel.orderModels[index]),
                    ],
                  );
                },
              ),
            )),
        if (!widget.isOrderDetails)
          CheckoutTitleWidget(
              text: "Order Discount",
              child: Column(
                children: [
                  if (checkoutViewModel.promos.isNotEmpty)
                    SelectedPromo(code: checkoutViewModel.promos[0])
                  else
                    TileWidget(
                        onTap: () => NavigationUtils.chooseVouchersPage(
                            context, widget.shopId),
                        startIcon: Icons.discount_outlined,
                        title: "Use Vouchers",
                        subtitle: "Save orders with promos",
                        endIcon: Icons.arrow_forward_ios_rounded),
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
        if (!widget.isOrderDetails)
          CheckoutTitleWidget(
            text: "Payment Method",
            child: checkoutViewModel.paymentMethod != null
                ? InkWell(
                    onTap: () => NavigationUtils.choosePaymentPage(
                        context, widget.shopId),
                    child: SelectedPaymentWidget(
                        paymentMethod: checkoutViewModel.paymentMethod!))
                : TileWidget(
                    onTap: () => NavigationUtils.choosePaymentPage(
                        context, widget.shopId),
                    startIcon: Icons.payment,
                    title: "Choose Payment",
                    subtitle: "Choose your payment method",
                    endIcon: Icons.arrow_forward_ios_rounded),
          ),
        CheckoutTitleWidget(
            text: "Payment Details",
            child: Column(
              children: [
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
                if (checkoutViewModel.promos.isNotEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Discount",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "-\$1.00",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                if (checkoutViewModel.promos.isNotEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "200 Points Used",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "-\$2.00",
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
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total Payment",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "\$${checkoutViewModel.totalPrice}",
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
              ],
            )),
        height35,
        if (widget.isOrderDetails) ...[
          CheckoutTitleWidget(
              text: "Transaction Details",
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Amount",
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
                          "Payment Method",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "Caffely Wallet",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Status",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.primaryColor),
                          child: const Text(
                            "Paid",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
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
                          "Date",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "Dec 22, 2023",
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
                          "Time",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "09:41:15 AM",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Row(
                      children: [
                        Text(
                          "Order ID",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                        Spacer(),
                        Text(
                          "ORD7395COF",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                        width5,
                        Icon(Icons.file_copy_outlined)
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Row(
                      children: [
                        Text(
                          "Transaction ID",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                        Spacer(),
                        Text(
                          "TRX8274PAY",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                        width5,
                        Icon(Icons.file_copy_outlined)
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Row(
                      children: [
                        Text(
                          "Reference ID",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                        Spacer(),
                        Text(
                          "REF6306RES",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                        width5,
                        Icon(Icons.file_copy_outlined)
                      ],
                    ),
                  ),
                ],
              )),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            child: Row(
              children: [
                const Text(
                  "Remind me 30 minutes earlier",
                  style: TextStyle(fontSize: 16),
                ),
                const Spacer(),
                CupertinoSwitch(
                  value: true,
                  onChanged: (value) {},
                )
              ],
            ),
          ),
          InkWell(
            onTap: () => NavigationUtils.cancelOrderPage(context),
            child: Container(
              width: double.infinity,
              height: 60,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  width: 2,
                  color: AppColors.primaryColor,
                ),
              ),
              alignment: Alignment.center,
              child: const Text(
                "Cancel Order",
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryColor),
              ),
            ),
          ),
          height10,
        ] else
          AuthButton(
              text: "Place Order",
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => DialogBox(
                        icon: Icons.check_box_rounded,
                        title: "Order Successful!",
                        subtitle:
                            "Step into a world of coffee bliss with our handcrafted brews",
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryColor,
                                  fixedSize: Size(
                                      MediaQuery.sizeOf(context).width * 0.9,
                                      60),
                                ),
                                onPressed: () {},
                                child: const Text("View My Orders",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 17)),
                              ),
                              height10,
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shadowColor: Colors.transparent,
                                  backgroundColor:
                                      AppColors.primaryColor.withOpacity(0.1),
                                  fixedSize: Size(
                                      MediaQuery.sizeOf(context).width * 0.9,
                                      60),
                                ),
                                onPressed: () {
                                  if (context.canPop()) context.pop();
                                  if (context.canPop()) context.pop();
                                  if (context.canPop()) context.pop();
                                },
                                child: const Text("back to Home",
                                    style:
                                        TextStyle(color: null, fontSize: 17)),
                              ),
                              height10,
                            ],
                          ),
                        )));
              })
      ],
    );
  }
}

class ChoosePickUpWidget extends ConsumerStatefulWidget {
  const ChoosePickUpWidget({super.key});

  @override
  ConsumerState<ChoosePickUpWidget> createState() => _ChoosePickUpWidgetState();
}

class _ChoosePickUpWidgetState extends ConsumerState<ChoosePickUpWidget> {
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
              ref
                  .read(checkoutViewModelProvider.notifier)
                  .setPickUpTime("Pick up now", "Ready in 15 mins");
              context.pop();
            })
      ],
    );
  }
}

class PickUptimePicker extends ConsumerStatefulWidget {
  const PickUptimePicker({super.key});

  @override
  ConsumerState<PickUptimePicker> createState() => _PickUptimePickerState();
}

class _PickUptimePickerState extends ConsumerState<PickUptimePicker> {
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
              ref
                  .read(checkoutViewModelProvider.notifier)
                  .setPickUpTime("Pick up at 12:00 PM", "Today, Dec 22 2023");
              context.pop();
            })
      ],
    );
  }
}
