import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:coffee_app/components/checkout/promo_widget.dart';
import 'package:coffee_app/components/checkout/title_widget.dart';
import 'package:coffee_app/features/auth/views/forgot_password/email_conform_page.dart';

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
    this.orderID,
    required this.shopId,
  });
  final bool isOrderDetails;
  final String? orderID;
  final String shopId;

  @override
  ConsumerState<DeliveryWidgets> createState() => _DeliveryWidgetsState();
}

class _DeliveryWidgetsState extends ConsumerState<DeliveryWidgets> {
  bool isValidate = false;
  @override
  void initState() {
    if (widget.isOrderDetails && widget.orderID != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref
            .read(checkoutViewModelProvider.notifier)
            .loadOrderData(widget.orderID!);
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final checkoutViewModel = ref.watch(checkoutViewModelProvider);
    if (checkoutViewModel.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
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
                    if (checkoutViewModel.shopModel != null)
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 4,
                          children: [
                            Text(checkoutViewModel.shopModel!.name,
                                maxLines: 1,
                                style: subtitleFont(
                                    fontSize: 18, fontWeight: FontWeight.w800)),
                            Text(checkoutViewModel
                                .shopModel!.address!["address"]),
                            Text(
                                "${checkoutViewModel.shopModel!.distance} form your location"),
                          ],
                        ),
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
                    onTap: () => widget.isOrderDetails
                        ? null
                        : NavigationUtils.chooseAddressPage(
                            context, widget.shopId),
                    startIcon: Icons.location_on_rounded,
                    title: checkoutViewModel.selectedAddress!.title,
                    subtitle:
                        "${checkoutViewModel.selectedAddress!.address} \n 5  minutes estimate arrived",
                    endIcon: widget.isOrderDetails
                        ? const IconData(0)
                        : Icons.arrow_forward_ios_rounded)
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
                      onTap: () => widget.isOrderDetails
                          ? null
                          : NavigationUtils.chooseDeliveryPage(
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
                          if (!widget.isOrderDetails)
                            const Icon(Icons.arrow_forward_ios_rounded)
                        ],
                      ),
                    ),
                  )
                else
                  TileWidget(
                    border: isValidate ? Border.all(color: Colors.red) : null,
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
                    border: isValidate ? Border.all(color: Colors.red) : null,
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
        if (widget.isOrderDetails && checkoutViewModel.orderModel != null) ...[
          CheckoutTitleWidget(
              text: "Transaction Details",
              child: Column(
                children: [
                  ...List.generate(
                    checkoutViewModel.orderModel!.transactionDetails.length,
                    (index) => Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            checkoutViewModel
                                .orderModel!.transactionDetails[index].type,
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                          if (checkoutViewModel
                                  .orderModel!.transactionDetails[index].type ==
                              "Status")
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.primaryColor),
                              child: Text(
                                checkoutViewModel.orderModel!.paymentStatus,
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                            )
                          else
                            Text(
                              double.tryParse(checkoutViewModel.orderModel!
                                          .transactionDetails[index].value
                                          .toString()) !=
                                      null
                                  ? "\$${checkoutViewModel.orderModel!.transactionDetails[index].value}"
                                  : checkoutViewModel.orderModel!
                                      .transactionDetails[index].value,
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w600),
                            )
                        ],
                      ),
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
                if (checkoutViewModel.paymentMethod == null) {
                  isValidate = true;
                  setState(() {});
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Please select payment method")));
                  return;
                }
                if (checkoutViewModel.selectedDelivery == null) {
                  isValidate = true;
                  setState(() {});
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Please select delivery method")));
                  return;
                }
                ref
                    .read(checkoutViewModelProvider.notifier)
                    .deliveryOrderConform();
                NavigationUtils.searchingDriverPage(context, widget.shopId);
              })
      ],
    );
  }
}
