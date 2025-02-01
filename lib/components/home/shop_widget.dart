import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/fonts.dart';
import '../../core/size.dart';
import '../../features/home/models/shop_model.dart';
import '../../route/navigation_utils.dart';

class NearbyShopCard extends StatelessWidget {
  const NearbyShopCard({
    super.key,
    required this.shopModel,
    required this.width,
  });
  final ShopModel shopModel;
  final double width;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return InkWell(
      onTap: () =>
          NavigationUtils.coffeeShopDetailsPage(context, shopId: shopModel.id),
      child: Container(
        width: width,
        height: size.width * 0.65,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Container(
              // width: size.width*0.4,
              height: size.width * 0.35,
              decoration: BoxDecoration(
                color: AppColors.secondaryColor(context),
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(shopModel.images[0]),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.themeColor(context).withOpacity(0.5),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.star_rate_rounded,
                            color: Colors.orange,
                          ),
                          Text(
                            shopModel.rating.toString(),
                            style: const TextStyle(
                                fontSize: 13, color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 8.0),
              child: SizedBox(
                // width: size.width*0.4,
                height: size.width * 0.2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(shopModel.name,
                        style: subtitleFont(
                            fontSize: 17, fontWeight: FontWeight.w700),
                        maxLines: 2),
                    Row(
                      children: [
                        const Icon(Icons.location_on,
                            color: AppColors.primaryColor, size: 17),
                        width5,
                        Text(
                          shopModel.distance,
                          style: subtitleFont(fontSize: 15),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
