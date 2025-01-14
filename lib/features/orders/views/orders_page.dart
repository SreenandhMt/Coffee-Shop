import 'package:coffee_app/core/size.dart';
import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';
import '../../../core/fonts.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: Container(
            width: 30,
            height: 30,
            color: AppColors.primaryColor,
          ),
          centerTitle: true,
          title: Text("Shop", style: appBarTitleFont),
          actions: const [
            Icon(Icons.search_rounded, size: 30),
            width5,
          ]),
    );
  }
}
