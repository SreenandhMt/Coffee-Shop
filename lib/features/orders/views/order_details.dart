import 'package:flutter/material.dart';

import 'package:coffee_app/core/fonts.dart';

import '../../../components/checkout/delivery_widget.dart';
import '../../../components/checkout/pick_up_widget.dart';

class OrderDetailsPage extends StatefulWidget {
  const OrderDetailsPage({
    super.key,
    required this.isPickUp,
  });
  final bool isPickUp;

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Order Details", style: appBarTitleFont),
      ),
      body: ListView(
        children: [
          if (widget.isPickUp)
            const PickupWidgets(
              shopId: "",
              isOrderDetails: true,
            )
          else
            const DeliveryWidgets(
              shopId: "",
              isOrderDetails: true,
            ),
        ],
      ),
    );
  }
}
