import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:coffee_app/core/app_colors.dart';
import 'package:coffee_app/core/fonts.dart';
import 'package:coffee_app/features/checkout/view_models/checkout_view_model.dart';

import '../../../components/checkout/delivery_widget.dart';
import '../../../components/checkout/pick_up_widget.dart';
import '../../../core/tabbar.dart';

class CheckoutPage extends ConsumerStatefulWidget {
  const CheckoutPage({super.key, required this.shopID});
  final String shopID;

  @override
  ConsumerState<CheckoutPage> createState() => CheckoutPageState();
}

class CheckoutPageState extends ConsumerState<CheckoutPage> {
  int currentIndex = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => ref
        .read(checkoutViewModelProvider.notifier)
        .setOrderModels(widget.shopID));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.sizeOf(context);
    final checkoutViewModel = ref.watch(checkoutViewModelProvider);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Checkout", style: appBarTitleFont),
        ),
        body: checkoutViewModel.isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Container(
                    height: 45,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
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
                  Expanded(
                    child: TabBarView(
                      children: [
                        SingleChildScrollView(
                          child: PickupWidgets(shopId: widget.shopID),
                        ),
                        SingleChildScrollView(
                          child: DeliveryWidgets(shopId: widget.shopID),
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
