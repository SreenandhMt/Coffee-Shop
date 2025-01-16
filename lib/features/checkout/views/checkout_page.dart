import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:coffee_app/core/app_colors.dart';
import 'package:coffee_app/core/fonts.dart';
import 'package:coffee_app/core/size.dart';
import 'package:coffee_app/features/auth/views/forgot_password/email_conform_page.dart';
import 'package:coffee_app/features/auth/views/signin_page.dart';
import 'package:coffee_app/features/buying/models/order_details_model.dart';
import 'package:coffee_app/features/checkout/view_models/checkout_view_model.dart';
import 'package:coffee_app/route/navigation_utils.dart';

import '../../../core/tabbar.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => CheckoutPageState();
}

class CheckoutPageState extends State<CheckoutPage> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final checkoutViewModel = context.watch<CheckoutViewModel>();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Checkout", style: appBarTitleFont),
        ),
        body: Column(
          children: [
            Container(
              height: 45,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                  color: AppColors.secondaryColor(context),
                  borderRadius: BorderRadius.circular(15)),
              child: const TabBar(
                dividerColor: Colors.transparent,
                indicator: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black54,
                tabs: [
                  TabbarItem(text: "Pick Up"),
                  TabbarItem(text: "Delivery"),
                ],
              ),
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  SingleChildScrollView(
                    child: PickupWidgets(),
                  ),
                  SingleChildScrollView(
                    child: DeliveryWidgets(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DeliveryWidgets extends StatefulWidget {
  const DeliveryWidgets({
    super.key,
    this.isOrderDetails = false,
  });
  final bool isOrderDetails;

  @override
  State<DeliveryWidgets> createState() => _DeliveryWidgetsState();
}

class _DeliveryWidgetsState extends State<DeliveryWidgets> {
  @override
  Widget build(BuildContext context) {
    final checkoutViewModel = context.watch<CheckoutViewModel>();
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
              height20,
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text("Your order is delivered from:"),
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
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Divider(thickness: 0.1),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text("To your address:"),
              ),
              if (checkoutViewModel.selectedAddress != null)
                TileWidget(
                    onTap: () => NavigationUtils.chooseAddressPage(context),
                    startIcon: Icons.location_on_rounded,
                    title: checkoutViewModel.selectedAddress!["title"],
                    subtitle:
                        "${checkoutViewModel.selectedAddress!["address"]} \n 5  minutes estimate arrived",
                    endIcon: Icons.arrow_forward_ios_rounded)
              else
                TileWidget(
                    onTap: () => NavigationUtils.chooseAddressPage(context),
                    startIcon: Icons.location_on_rounded,
                    title: "Home",
                    subtitle:
                        "701 7th Ave, New York, NY 10036, USA \n 5  minutes estimate arrived",
                    endIcon: Icons.arrow_forward_ios_rounded),
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
                checkoutViewModel.orderModel.length,
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
                          orderModel: checkoutViewModel.orderModel[index]),
                    ],
                  );
                },
              ),
            )),
        CheckoutTitleWidget(
            text: "Delivery",
            child: Column(
              children: [
                if (checkoutViewModel.selectedDelivery != null)
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: InkWell(
                      onTap: () => NavigationUtils.chooseDeliveryPage(context),
                      child: Row(
                        children: [
                          width10,
                          CircleAvatar(
                            backgroundColor: AppColors.secondaryColor(context),
                            backgroundImage: NetworkImage(
                                checkoutViewModel.selectedDelivery!["url"]),
                          ),
                          width15,
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(checkoutViewModel.selectedDelivery!["name"],
                                  maxLines: 2,
                                  style: subtitleFont(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800)),
                            ],
                          ),
                          const Spacer(),
                          const Icon(Icons.arrow_forward_ios_rounded)
                        ],
                      ),
                    ),
                  )
                else
                  TileWidget(
                    onTap: () => NavigationUtils.chooseDeliveryPage(context),
                    startIcon: Icons.delivery_dining_outlined,
                    title: "Choose Delivery",
                    subtitle: "Choose your delivery service",
                    endIcon: Icons.arrow_forward_ios_rounded,
                  )
              ],
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
                        onTap: () =>
                            NavigationUtils.chooseVouchersPage(context),
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
                    onTap: () => NavigationUtils.choosePaymentPage(context),
                    child: SelectedPaymentWidget(
                        paymentMethod: checkoutViewModel.paymentMethod!))
                : TileWidget(
                    onTap: () => NavigationUtils.choosePaymentPage(context),
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
                if (checkoutViewModel.selectedDelivery != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Delivery Fee",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "\$${checkoutViewModel.selectedDelivery!["price"]}",
                          style: const TextStyle(
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
                        "\$48.0",
                        style: TextStyle(
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
          InkWell(
            onTap: () => NavigationUtils.driverProfilePage(context),
            child: Container(
              width: double.infinity,
              height: 60,
              margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: AppColors.primaryColor,
              ),
              alignment: Alignment.center,
              child: const Text(
                "Track Order",
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
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
          height10
        ] else
          AuthButton(
              text: "Place Order",
              onPressed: () {
                NavigationUtils.searchingDriverPage(context);
              })
      ],
    );
  }
}

class PickupWidgets extends StatefulWidget {
  const PickupWidgets({
    super.key,
    this.isOrderDetails = false,
  });
  final bool isOrderDetails;

  @override
  State<PickupWidgets> createState() => _PickupWidgetsState();
}

class _PickupWidgetsState extends State<PickupWidgets> {
  @override
  Widget build(BuildContext context) {
    final checkoutViewModel = context.watch<CheckoutViewModel>();
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
                checkoutViewModel.orderModel.length,
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
                          orderModel: checkoutViewModel.orderModel[index]),
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
                        onTap: () =>
                            NavigationUtils.chooseVouchersPage(context),
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
                    onTap: () => NavigationUtils.choosePaymentPage(context),
                    child: SelectedPaymentWidget(
                        paymentMethod: checkoutViewModel.paymentMethod!))
                : TileWidget(
                    onTap: () => NavigationUtils.choosePaymentPage(context),
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
                        "\$48.0",
                        style: TextStyle(
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

class CheckoutTitleWidget extends StatefulWidget {
  const CheckoutTitleWidget({
    super.key,
    required this.text,
    this.action,
    required this.child,
  });
  final String text;
  final Widget? action;
  final Widget child;

  @override
  State<CheckoutTitleWidget> createState() => CheckoutTitleWidgetState();
}

class CheckoutTitleWidgetState extends State<CheckoutTitleWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.secondaryColor(context)),
            borderRadius: BorderRadius.circular(10)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Text(widget.text,
                    style: subtitleFont(
                        fontSize: 19, fontWeight: FontWeight.bold)),
              ),
              if (widget.action != null) ...[const Spacer(), widget.action!]
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Divider(thickness: 0.1),
          ),
          widget.child
        ]));
  }
}

class TileWidget extends StatelessWidget {
  const TileWidget({
    super.key,
    required this.startIcon,
    required this.title,
    required this.subtitle,
    this.endIcon,
    this.onTap,
  });
  final IconData startIcon;
  final String title;
  final String subtitle;
  final IconData? endIcon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: InkWell(
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            width10,
            CircleAvatar(
                backgroundColor: AppColors.secondaryColor(context),
                child: Icon(
                  startIcon,
                  color: AppColors.themeColor(context),
                )),
            width15,
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 4,
                children: [
                  Text(title,
                      maxLines: 2,
                      style: subtitleFont(
                          fontSize: 18, fontWeight: FontWeight.w800)),
                  Text(subtitle, maxLines: 3),
                ],
              ),
            ),
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

class ProductDetailsWidget extends StatefulWidget {
  const ProductDetailsWidget({
    super.key,
    required this.orderModel,
  });
  final OrderDetailsModel orderModel;

  @override
  State<ProductDetailsWidget> createState() => _ProductDetailsWidgetState();
}

class _ProductDetailsWidgetState extends State<ProductDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final orderModel = widget.orderModel;
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
}

class SelectedPromo extends StatefulWidget {
  const SelectedPromo({
    super.key,
    required this.code,
  });
  final String code;

  @override
  State<SelectedPromo> createState() => _SelectedPromoState();
}

class _SelectedPromoState extends State<SelectedPromo> {
  @override
  Widget build(BuildContext context) {
    final checkoutViewModel = Provider.of<CheckoutViewModel>(context);
    return Padding(
      padding: const EdgeInsets.all(20),
      child: InkWell(
        onTap: () => checkoutViewModel.removePromos(widget.code),
        child: Row(
          children: [
            width10,
            CircleAvatar(
                backgroundColor: AppColors.secondaryColor(context),
                child: Icon(
                  Icons.discount_outlined,
                  color: AppColors.themeColor(context),
                )),
            width15,
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4,
              children: [
                Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: AppColors.primaryColor),
                    child: Row(
                      children: [
                        Text(
                          widget.code,
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        width5,
                        const Icon(Icons.close, size: 15)
                      ],
                    )),
                const Text("Save orders with promos"),
              ],
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios_rounded)
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
              context
                  .read<CheckoutViewModel>()
                  .setPickUpTime("Pick up now", "Ready in 15 mins");
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
              context
                  .read<CheckoutViewModel>()
                  .setPickUpTime("Pick up at 12:00 PM", "Today, Dec 22 2023");
              context.pop();
            })
      ],
    );
  }
}

class SelectedPaymentWidget extends StatefulWidget {
  const SelectedPaymentWidget({super.key, required this.paymentMethod});
  final String paymentMethod;

  @override
  State<SelectedPaymentWidget> createState() => _SelectedPaymentWidgetState();
}

class _SelectedPaymentWidgetState extends State<SelectedPaymentWidget> {
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
      return Container(
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
                color: AppColors.secondaryColor(context), width: 0.1)),
        child: Row(
          children: [
            const Icon(
              Icons.wallet,
              size: 55,
              color: AppColors.primaryColor,
            ),
            width10,
            const Text(
              "My Wallet",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            const Spacer(),
            const Text("\$948.50",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            width5,
            Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey.shade500)
          ],
        ),
      );
    } else {
      for (int i = 0; i < paymentMethods.length; i++) {
        if (paymentMethods[i] == widget.paymentMethod) {
          return Container(
            margin: const EdgeInsets.all(4),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: AppColors.secondaryColor(context), width: 0.1)),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(images[i]),
                ),
                width20,
                Text(
                  paymentMethods[i],
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w700),
                ),
                const Spacer(),
                Icon(Icons.arrow_forward_ios_rounded,
                    color: Colors.grey.shade500)
              ],
            ),
          );
        }
      }
      return const SizedBox();
    }
  }
}
