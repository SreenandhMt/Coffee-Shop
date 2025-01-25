import 'package:coffee_app/components/checkout/promo_widget.dart';
import 'package:coffee_app/components/checkout/title_widget.dart';
import 'package:coffee_app/features/auth/views/forgot_password/email_conform_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/app_colors.dart';
import '../../core/fonts.dart';
import '../../core/size.dart';
import '../../features/checkout/view_models/checkout_view_model.dart';
import '../../route/navigation_utils.dart';
import 'payment_widget.dart';
import 'product_details_widget.dart';
import 'tile_widget.dart';

class DeliveryWidgets extends ConsumerStatefulWidget {
  const DeliveryWidgets({
    super.key,
    this.isOrderDetails = false,
    required this.shopId,
  });
  final bool isOrderDetails;
  final String shopId;

  @override
  ConsumerState<DeliveryWidgets> createState() => _DeliveryWidgetsState();
}

class _DeliveryWidgetsState extends ConsumerState<DeliveryWidgets> {
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
                    onTap: () => NavigationUtils.chooseAddressPage(
                        context, widget.shopId),
                    startIcon: Icons.location_on_rounded,
                    title: checkoutViewModel.selectedAddress!["title"],
                    subtitle:
                        "${checkoutViewModel.selectedAddress!["address"]} \n 5  minutes estimate arrived",
                    endIcon: Icons.arrow_forward_ios_rounded)
              else
                TileWidget(
                    onTap: () => NavigationUtils.chooseAddressPage(
                        context, widget.shopId),
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
        CheckoutTitleWidget(
            text: "Delivery",
            child: Column(
              children: [
                if (checkoutViewModel.selectedDelivery != null)
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: InkWell(
                      onTap: () => NavigationUtils.chooseDeliveryPage(
                          context, widget.shopId),
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
                    onTap: () => NavigationUtils.chooseDeliveryPage(
                        context, widget.shopId),
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
                NavigationUtils.searchingDriverPage(context, widget.shopId);
              })
      ],
    );
  }
}
