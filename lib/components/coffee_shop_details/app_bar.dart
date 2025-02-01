import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/app_colors.dart';
import '../../core/size.dart';
import '../../features/coffee_shop_details/view_models/coffee_shop_view_model.dart';

class CoffeeShopDetailsAppBar extends ConsumerWidget {
  const CoffeeShopDetailsAppBar({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final backgroundColor = Colors.grey.withOpacity(0.6);
    final viewModel = ref.watch(shopDetailsViewModelProvider);
    return Padding(
      padding: EdgeInsets.only(
          left: 10, right: 10, top: MediaQuery.paddingOf(context).top),
      child: Row(
        children: [
          IconButton(
              onPressed: () => context.pop(),
              style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(backgroundColor)),
              icon: Icon(
                Icons.arrow_back,
                size: 30,
                color: AppColors.backgroundColor(context),
              )),
          const Spacer(),
          IconButton(
            onPressed: () {
              ref
                  .read(shopDetailsViewModelProvider.notifier)
                  .addShopFavoriteList();
            },
            style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(backgroundColor)),
            icon: Icon(
              viewModel.isFavorite ? Icons.favorite : Icons.favorite_border,
              size: 30,
              color: viewModel.isFavorite
                  ? Colors.red
                  : AppColors.backgroundColor(context),
            ),
          ),
          width10,
          IconButton(
            onPressed: () {
              //todo add share system with deep linking
            },
            style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(backgroundColor)),
            icon: Icon(
              Icons.share_rounded,
              size: 30,
              color: AppColors.backgroundColor(context),
            ),
          )
        ],
      ),
    );
  }
}
