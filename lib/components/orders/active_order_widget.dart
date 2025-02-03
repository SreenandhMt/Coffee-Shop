import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/app_colors.dart';
import '../../core/fonts.dart';
import '../../core/size.dart';
import '../../features/orders/view_models/order_view_model.dart';
import '../../localization/locales.dart';
import '../../route/navigation_utils.dart';

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
