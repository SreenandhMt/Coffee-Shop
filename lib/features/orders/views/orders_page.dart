import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:coffee_app/core/size.dart';
import 'package:coffee_app/core/tabbar.dart';
import 'package:coffee_app/features/checkout/view_models/checkout_view_model.dart';
import 'package:coffee_app/features/orders/view_models/order_view_model.dart';
import 'package:coffee_app/localization/locales.dart';
import 'package:coffee_app/route/navigation_utils.dart';

import '../../../core/app_colors.dart';
import '../../../core/assets.dart';
import '../../../core/fonts.dart';

class OrdersPage extends ConsumerStatefulWidget {
  const OrdersPage({super.key});

  @override
  ConsumerState<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends ConsumerState<OrdersPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) => ref.read(orderViewModelProvider.notifier).getOrders(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orderModel = ref.watch(orderViewModelProvider);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
            leading: Container(
                margin: const EdgeInsets.only(left: 20),
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(AppAssets.logo)))),
            centerTitle: true,
            title: Text(LocaleData.orders.getString(context),
                style: appBarTitleFont),
            actions: const [
              Icon(Icons.search_rounded, size: 30),
              width5,
            ]),
        body: Column(
          children: [
            Container(
              height: 45,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                  color: AppColors.secondaryColor(context),
                  borderRadius: BorderRadius.circular(15)),
              child: TabBar(
                dividerColor: Colors.transparent,
                indicator: const BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black54,
                tabs: [
                  TabbarItem(
                      text: LocaleData.orderStatusActive.getString(context)),
                  TabbarItem(
                      text: LocaleData.orderStatusCompleted.getString(context)),
                  TabbarItem(
                      text: LocaleData.orderStatusCanceled.getString(context)),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(children: [
                SingleChildScrollView(
                  child: Column(
                    spacing: 10,
                    children: [
                      ...List.generate(
                        orderModel.activeOrderModels.length,
                        (index) => ActiveOrderWidget(index: index),
                      ),
                    ],
                  ),
                ),
                ListView.builder(
                  itemCount: 6,
                  itemBuilder: (context, index) => OrderWidget(index: index),
                ),
                ListView.builder(
                  itemCount: 6,
                  itemBuilder: (context, index) => OrderWidget(index: index),
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}

class OrderWidget extends StatelessWidget {
  const OrderWidget({
    super.key,
    required this.index,
  });
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        spacing: 10,
        children: [
          width10,
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: AppColors.secondaryColor(context),
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage("assets/image${6 - index}.png"),
              ),
            ),
          ),
          width5,
          Column(
            spacing: 5,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Classic Brew",
                maxLines: 1,
                style: titleFonts(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              const Row(
                spacing: 4,
                children: [
                  Icon(Icons.add_business_rounded, size: 17),
                  Text("Caffely Astoria Aromas")
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.primaryColor, width: 2),
                    borderRadius: BorderRadius.circular(5)),
                child: const Text(
                  "Pick Up",
                  style: TextStyle(color: AppColors.primaryColor),
                ),
              )
            ],
          ),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios_rounded),
          width10,
        ],
      ),
    );
  }
}

class ActiveOrderWidget extends ConsumerWidget {
  const ActiveOrderWidget({
    super.key,
    required this.index,
  });
  final int index;

  @override
  Widget build(BuildContext context, ref) {
    final orderModel = ref.watch(orderViewModelProvider);
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey, width: 0.2),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: InkWell(
              onTap: () {
                ref
                    .read(orderViewModelProvider.notifier)
                    .selectOrderModel(orderModel.activeOrderModels[index]);
                if (orderModel.activeOrderModels[index].type == "Pickup") {
                  NavigationUtils.orderDetailsPagePickup(context);
                } else {
                  NavigationUtils.orderDetailsPageDelivery(context);
                }
              },
              child: Row(
                spacing: 5,
                children: [
                  width10,
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: AppColors.secondaryColor(context),
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(
                            orderModel.activeOrderModels[index].productImage),
                      ),
                    ),
                  ),
                  width5,
                  Expanded(
                    child: Column(
                      spacing: 5,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          orderModel.activeOrderModels[index].productName,
                          maxLines: 1,
                          style: titleFonts(
                              fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                        Row(
                          spacing: 4,
                          children: [
                            const Icon(Icons.add_business_rounded, size: 17),
                            Expanded(
                              child: Text(
                                  orderModel.activeOrderModels[index].shopName,
                                  maxLines: 1),
                            )
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 8),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: AppColors.primaryColor, width: 2),
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            orderModel.activeOrderModels[index].type == "Pickup"
                                ? "Pick Up"
                                : "Delivery",
                            style:
                                const TextStyle(color: AppColors.primaryColor),
                          ),
                        )
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios_rounded),
                  width5,
                ],
              ),
            ),
          ),
          //
          if (orderModel.activeOrderModels[index].type == "Pickup") ...[
            height5,
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Divider(
                thickness: 0.2,
                color: Colors.grey,
              ),
            ),
            //
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
            )
          ] else ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: AppColors.primaryColor, width: 2)),
                      child: Text(
                          LocaleData.cancelOrderButton.getString(context),
                          style:
                              const TextStyle(color: AppColors.primaryColor)),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.primaryColor),
                      child: Text(
                          LocaleData.trackOrderButton.getString(context),
                          style: const TextStyle(color: Colors.white)),
                    ),
                  )
                ],
              ),
            )
          ]
        ],
      ),
    );
  }
}
