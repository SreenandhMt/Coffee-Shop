import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/size.dart';
import '../../features/home/models/shop_model.dart';

class TotalRateWidget extends StatelessWidget {
  const TotalRateWidget({
    super.key,
    required this.shopModel,
    required this.reviewsLength,
  });
  final ShopModel shopModel;
  final int reviewsLength;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                shopModel.rating.toString(),
                style:
                    const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              Row(children: [
                Icon(
                    shopModel.rating >= 1
                        ? Icons.star
                        : shopModel.rating >= 0.5
                            ? Icons.star_half
                            : Icons.star_border,
                    color: Colors.orange),
                Icon(
                    shopModel.rating >= 2
                        ? Icons.star
                        : shopModel.rating >= 1.5
                            ? Icons.star_half
                            : Icons.star_border,
                    color: Colors.orange),
                Icon(
                    shopModel.rating >= 3
                        ? Icons.star
                        : shopModel.rating >= 2.5
                            ? Icons.star_half
                            : Icons.star_border,
                    color: Colors.orange),
                Icon(
                    shopModel.rating >= 4
                        ? Icons.star
                        : shopModel.rating >= 3.5
                            ? Icons.star_half
                            : Icons.star_border,
                    color: Colors.orange),
                Icon(
                    shopModel.rating >= 5
                        ? Icons.star
                        : shopModel.rating >= 4.5
                            ? Icons.star_half
                            : Icons.star_border,
                    color: Colors.orange),
              ]),
              Text("($reviewsLength reviews)")
            ],
          ),
          width5,
          Column(
            children: [
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 5, bottom: 5),
                    child: Text(
                      "5.",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  LimitedBox(
                    maxWidth: MediaQuery.sizeOf(context).width * 0.5,
                    child: LinearProgressIndicator(
                      value: 0.5,
                      backgroundColor: AppColors.secondaryColor(context),
                      minHeight: 8,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 5, bottom: 5),
                    child: Text(
                      "4.",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  LimitedBox(
                    maxWidth: MediaQuery.sizeOf(context).width * 0.5,
                    child: LinearProgressIndicator(
                      value: 0.5,
                      backgroundColor: AppColors.secondaryColor(context),
                      minHeight: 8,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 5, bottom: 5),
                    child: Text(
                      "3.",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  LimitedBox(
                    maxWidth: MediaQuery.sizeOf(context).width * 0.5,
                    child: LinearProgressIndicator(
                      value: 0.5,
                      backgroundColor: AppColors.secondaryColor(context),
                      minHeight: 8,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 5, bottom: 5),
                    child: Text(
                      "2.",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  LimitedBox(
                    maxWidth: MediaQuery.sizeOf(context).width * 0.5,
                    child: LinearProgressIndicator(
                      value: 0.5,
                      backgroundColor: AppColors.secondaryColor(context),
                      minHeight: 8,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 5, bottom: 5),
                    child: Text(
                      "1.",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  LimitedBox(
                    maxWidth: MediaQuery.sizeOf(context).width * 0.5,
                    child: LinearProgressIndicator(
                      value: 0.5,
                      backgroundColor: AppColors.secondaryColor(context),
                      minHeight: 8,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
