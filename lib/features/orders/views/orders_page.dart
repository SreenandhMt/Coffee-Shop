import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:coffee_app/core/size.dart';
import 'package:coffee_app/core/tabbar.dart';
import 'package:coffee_app/features/orders/view_models/order_view_model.dart';
import 'package:coffee_app/localization/locales.dart';

import '../../../components/orders/active_order_widget.dart';
import '../../../components/orders/order_loading.dart';
import '../../../components/orders/order_widget.dart';
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
  void activate() {
    final value = ref.read(orderViewModelProvider);
    if (value.activeOrderModels.isEmpty ||
        value.completedOrderModels.isEmpty ||
        value.canceledOrderModels.isEmpty) {
      ref.read(orderViewModelProvider.notifier).getOrders(loading: false);
    }
    super.activate();
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
            //*tab view
            Expanded(
              child: TabBarView(children: [
                if (orderModel.isLoading)
                  const OrderLoading()
                else
                  RefreshIndicator(
                    onRefresh: () async {
                      await ref
                          .read(orderViewModelProvider.notifier)
                          .getOrders(loading: false);
                    },
                    child: orderModel.activeOrderModels.isEmpty
                        ? const Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Center(child: Text("Orders are empty")),
                              // height10,
                              // ElevatedButton(
                              //     style: const ButtonStyle(
                              //         shadowColor: WidgetStateColor.transparent,
                              //         backgroundColor: WidgetStatePropertyAll(
                              //             AppColors.primaryColor)),
                              //     onPressed: () async {
                              //       await ref
                              //           .read(orderViewModelProvider.notifier)
                              //           .getOrders(loading: true);
                              //     },
                              //     child: const Text(
                              //       "Refresh",
                              //       style: TextStyle(color: Colors.white),
                              //     ))
                            ],
                          )
                        : SingleChildScrollView(
                            child: Column(
                              spacing: 10,
                              children: List.generate(
                                orderModel.activeOrderModels.length,
                                (index) => ActiveOrderWidget(
                                  orderModel:
                                      orderModel.activeOrderModels[index],
                                ),
                              ),
                            ),
                          ),
                  ),
                if (orderModel.isLoading)
                  const OrderLoading()
                else
                  orderModel.completedOrderModels.isEmpty
                      ? const Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Center(child: Text("Orders are empty")),
                          ],
                        )
                      : ListView.builder(
                          itemCount: orderModel.completedOrderModels.length,
                          itemBuilder: (context, index) => OrderWidget(
                            orderModel: orderModel.completedOrderModels[index],
                          ),
                        ),
                if (orderModel.isLoading)
                  const OrderLoading()
                else
                  orderModel.canceledOrderModels.isEmpty
                      ? const Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Center(child: Text("Orders are empty")),
                          ],
                        )
                      : ListView.builder(
                          itemCount: orderModel.canceledOrderModels.length,
                          itemBuilder: (context, index) => OrderWidget(
                            orderModel: orderModel.canceledOrderModels[index],
                          ),
                        ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
