import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/fonts.dart';
import '../../core/size.dart';
import '../../features/buying/models/order_details_model.dart';

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
                    image: NetworkImage(orderModel.productModel.imagePath)),
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
                if (orderModel.selectedOption.isNotEmpty)
                  ...orderModel.selectedOption.map((option) {
                    return productInfoWidget(
                      "1 x ${option["name"]}",
                      "+ ${option["price"]}",
                      null,
                    );
                  }),
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
