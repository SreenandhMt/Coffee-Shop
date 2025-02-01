import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/coffee_shop_details/view_models/coffee_shop_view_model.dart';
import '../home/coffee_widget.dart';

class CoffeeList extends ConsumerWidget {
  const CoffeeList({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final viewModel = ref.watch(shopDetailsViewModelProvider);
    if (viewModel.coffeeModel == null) return const SizedBox();
    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: viewModel.coffeeModel!.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 1 / 1.3),
      itemBuilder: (context, index) {
        if (viewModel.selectedCoffeeIds.isNotEmpty) {
          for (var id in viewModel.selectedCoffeeIds) {
            if (id.productModel.id == viewModel.coffeeModel![index].id) {
              return CoffeeCard(
                onLongPress: () {
                  ref
                      .read(shopDetailsViewModelProvider.notifier)
                      .removeProductID(id);
                },
                model: viewModel.coffeeModel![index],
                isShopPage: true,
                selected: true,
              );
            }
          }
        }
        return CoffeeCard(
          model: viewModel.coffeeModel![index],
          isShopPage: true,
        );
      },
    );
  }
}
