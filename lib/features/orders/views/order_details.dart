import 'package:coffee_app/localization/locales.dart';
import 'package:flutter/material.dart';

import 'package:coffee_app/core/fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../components/checkout/delivery_widget.dart';
import '../../../components/checkout/pick_up_widget.dart';
import '../view_models/order_view_model.dart';

class OrderDetailsPage extends ConsumerStatefulWidget {
  const OrderDetailsPage({
    super.key,
    required this.isPickUp,
  });
  final bool isPickUp;

  @override
  ConsumerState<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends ConsumerState<OrderDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final orderModel = ref.watch(orderViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(LocaleData.orderDetailsTitle, style: appBarTitleFont),
      ),
      body: ListView(
        children: [
          if (widget.isPickUp)
            PickupWidgets(
              orderID: orderModel.selectedOrder!.id,
              shopId: orderModel.selectedOrder!.shopId,
              isOrderDetails: true,
            )
          else
            DeliveryWidgets(
              orderID: orderModel.selectedOrder!.id,
              shopId: orderModel.selectedOrder!.shopId,
              isOrderDetails: true,
            ),
        ],
      ),
    );
  }
}
