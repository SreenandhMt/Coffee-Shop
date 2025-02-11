import 'package:coffee_app/features/orders/models/order_model.dart';
import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/fonts.dart';
import '../../core/size.dart';

class OrderWidget extends StatelessWidget {
  const OrderWidget({
    super.key,
    required this.orderModel,
  });
  final OrderModel orderModel;

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
                image: NetworkImage(orderModel.productImage),
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
                orderModel.productName,
                maxLines: 1,
                style: titleFonts(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              Row(
                spacing: 4,
                children: [
                  const Icon(Icons.add_business_rounded, size: 17),
                  Text(orderModel.shopName)
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.primaryColor, width: 2),
                    borderRadius: BorderRadius.circular(5)),
                child: Text(
                  orderModel.type,
                  style: const TextStyle(color: AppColors.primaryColor),
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
