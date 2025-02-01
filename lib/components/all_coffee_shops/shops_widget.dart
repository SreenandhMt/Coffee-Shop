import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/fonts.dart';
import '../../core/size.dart';
import '../../features/home/models/shop_model.dart';
import '../../route/navigation_utils.dart';

class ShopWidget extends StatelessWidget {
  const ShopWidget({
    super.key,
    required this.index,
    required this.shopModel,
  });
  final int index;
  final ShopModel shopModel;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Container(
      height: size.width * 0.3,
      margin: const EdgeInsets.only(top: 15, left: 10, right: 10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: () => NavigationUtils.coffeeShopDetailsPage(context,
            shopId: shopModel.id),
        child: Row(
          spacing: 0,
          children: [
            Container(
              height: size.width * 0.27,
              width: size.width * 0.27,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(shopModel.images[0]),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(10)),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(shopModel.name,
                        maxLines: 1,
                        style: titleFonts(
                            fontWeight: FontWeight.w700, fontSize: 20)),
                    Row(
                      spacing: 5,
                      children: [
                        const Icon(Icons.location_on_rounded,
                            color: AppColors.primaryColor),
                        Text(
                          shopModel.distance,
                          maxLines: 1,
                          style: const TextStyle(fontSize: 15),
                        ),
                        const Expanded(
                          child: Text("(350 5th Ave, New York, NY 1999)",
                              maxLines: 1),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        if (shopModel.rating >= 1)
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                          )
                        else
                          const Icon(
                            Icons.star_border_outlined,
                            color: Colors.amber,
                          ),
                        if (shopModel.rating >= 2)
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                          )
                        else
                          const Icon(
                            Icons.star_border_outlined,
                            color: Colors.amber,
                          ),
                        if (shopModel.rating >= 3)
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                          )
                        else
                          const Icon(
                            Icons.star_border_outlined,
                            color: Colors.amber,
                          ),
                        if (shopModel.rating >= 4)
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                          )
                        else
                          const Icon(
                            Icons.star_border_outlined,
                            color: Colors.amber,
                          ),
                        if (shopModel.rating >= 5)
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                          )
                        else
                          const Icon(
                            Icons.star_border_outlined,
                            color: Colors.amber,
                          ),
                        width5,
                        Text(shopModel.rating.toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16)),
                        const Expanded(
                            child: Text("(2.4k reviews)", maxLines: 1))
                      ],
                    )
                  ],
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded, weight: 0.1)
          ],
        ),
      ),
    );
  }
}
