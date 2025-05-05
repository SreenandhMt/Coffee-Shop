import 'package:coffee_app/features/orders/view_models/order_view_model.dart';
import 'package:coffee_app/localization/locales.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/app_colors.dart';
import '../../../core/size.dart';
import '../../../route/navigation_utils.dart';

double _ratingValue = 0.5;
TextEditingController _reviewText = TextEditingController();

class RatingShopPage extends ConsumerStatefulWidget {
  const RatingShopPage({super.key});

  @override
  ConsumerState<RatingShopPage> createState() => _RatingShopPageState();
}

class _RatingShopPageState extends ConsumerState<RatingShopPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) =>
          ref.read(orderViewModelProvider.notifier).initOrderDetails(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orderViewModel = ref.watch(orderViewModelProvider);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  spacing: 10,
                  children: [
                    Container(
                      width: size.width * 0.44,
                      height: size.width * 0.43,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          image: DecorationImage(
                              image: NetworkImage(
                                  orderViewModel.shopModel == null
                                      ? ""
                                      : orderViewModel.shopModel!.images.first),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    height15,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        LocaleData.rateShopTitle.getString(context),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w900),
                      ),
                    ),
                    height10,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        LocaleData.rateShopSubTitle.getString(context),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ),
                    height20,
                    RatingBar(
                      initialRating: _ratingValue,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemSize: 50,
                      itemCount: 5,
                      ratingWidget: RatingWidget(
                        full: const Icon(
                          Icons.star_rate_rounded,
                          color: Colors.orange,
                          size: 50,
                        ),
                        half: const Icon(
                          Icons.star_half_rounded,
                          color: Colors.orange,
                          size: 50,
                        ),
                        empty: const Icon(
                          Icons.star_border_rounded,
                          color: Colors.orange,
                          size: 50,
                        ),
                      ),
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      onRatingUpdate: (rating) {
                        _ratingValue = rating;
                      },
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      child: Divider(
                        thickness: 0.3,
                      ),
                    ),
                    Row(
                      children: [
                        width10,
                        Text(LocaleData.rateShopReviewTitle.getString(context),
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w800)),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 5),
                      child: TextFormField(
                          maxLines: 4,
                          controller: _reviewText,
                          style: TextStyle(
                              fontSize: 16,
                              color: AppColors.themeTextColor(context)),
                          decoration: InputDecoration(
                              hintText: "Example: Good coffee",
                              filled: true,
                              fillColor: AppColors.secondaryColor(context),
                              hintStyle: const TextStyle(
                                  fontSize: 16, color: Colors.grey),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none))),
                    ),
                  ],
                ),
              ),
            ),
            height10,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor.withOpacity(0.2),
                    shadowColor: Colors.transparent,
                    fixedSize:
                        Size((MediaQuery.sizeOf(context).width / 2) * 0.9, 60),
                  ),
                  onPressed: () {
                    NavigationUtils.showHomeSuccessPage(context);
                  },
                  child: Text(LocaleData.cancelButton.getString(context),
                      style: const TextStyle(
                          color: AppColors.primaryColor, fontSize: 17)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    fixedSize:
                        Size((MediaQuery.sizeOf(context).width / 2) * 0.9, 60),
                  ),
                  onPressed: () {
                    ref
                        .read(orderViewModelProvider.notifier)
                        .rateAndReviewShop(_ratingValue, _reviewText.text);
                    NavigationUtils.showHomeSuccessPage(context);
                  },
                  child: Text(LocaleData.submitButton.getString(context),
                      style:
                          const TextStyle(color: Colors.white, fontSize: 17)),
                ),
              ],
            ),
            height10,
          ],
        ),
      ),
    );
  }
}
