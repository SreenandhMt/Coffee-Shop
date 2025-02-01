import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/app_colors.dart';
import '../../core/size.dart';
import '../../features/coffee_shop_details/view_models/coffee_shop_view_model.dart';
import '../../features/home/models/offer_model.dart';

class OfferWidget extends ConsumerWidget {
  const OfferWidget({
    super.key,
    required this.offer,
    required this.isSelected,
  });
  final OfferModel offer;
  final bool isSelected;

  @override
  Widget build(BuildContext context, ref) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey, width: 0.2)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            offer.title,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
          ),
          Text(offer.description),
          height10,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.timer_outlined),
              width5,
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Valid until",
                    style: TextStyle(fontSize: 13),
                  ),
                  height5,
                  Text(
                    offer.validDate,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w700),
                  )
                ],
              ),
              width10,
              const Icon(Icons.payment),
              width5,
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Min transaction",
                    style: TextStyle(fontSize: 13),
                  ),
                  height5,
                  Text(
                    "\$${offer.minPrice}",
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              const Spacer(),
              ElevatedButton(
                  onPressed: () {
                    ref
                        .read(shopDetailsViewModelProvider.notifier)
                        .claimOffer(offer);
                  },
                  style: ButtonStyle(
                      shadowColor: WidgetStateColor.transparent,
                      backgroundColor: isSelected
                          ? const WidgetStatePropertyAll(AppColors.primaryColor)
                          : WidgetStatePropertyAll(
                              AppColors.secondaryColor(context))),
                  child: Text(
                    isSelected ? "Claim" : "Claimed",
                    style: TextStyle(
                        color: isSelected
                            ? Colors.white
                            : AppColors.themeTextColor(context)),
                  ))
            ],
          )
        ],
      ),
    );
  }
}
