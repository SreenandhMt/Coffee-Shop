import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/app_colors.dart';
import '../../core/size.dart';
import '../../features/checkout/view_models/checkout_view_model.dart';

class SelectedPromo extends ConsumerStatefulWidget {
  const SelectedPromo({
    super.key,
    required this.code,
  });
  final String code;

  @override
  ConsumerState<SelectedPromo> createState() => _SelectedPromoState();
}

class _SelectedPromoState extends ConsumerState<SelectedPromo> {
  @override
  Widget build(BuildContext context) {
    // final checkoutViewModel = ref.watch(checkoutViewModelProvider);
    return Padding(
      padding: const EdgeInsets.all(20),
      child: InkWell(
        onTap: () => ref
            .read(checkoutViewModelProvider.notifier)
            .removePromos(widget.code),
        child: Row(
          children: [
            width10,
            CircleAvatar(
                backgroundColor: AppColors.secondaryColor(context),
                child: Icon(
                  Icons.discount_outlined,
                  color: AppColors.themeColor(context),
                )),
            width15,
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4,
              children: [
                Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: AppColors.primaryColor),
                    child: Row(
                      children: [
                        Text(
                          widget.code,
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        width5,
                        const Icon(Icons.close, size: 15)
                      ],
                    )),
                const Text("Save orders with promos"),
              ],
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios_rounded)
          ],
        ),
      ),
    );
  }
}
