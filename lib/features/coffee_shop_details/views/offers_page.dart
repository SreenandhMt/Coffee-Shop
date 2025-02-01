import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:coffee_app/core/fonts.dart';

import '../../../components/coffee_shop_details/offer_widget.dart';
import '../view_models/coffee_shop_view_model.dart';

class OffersPage extends ConsumerWidget {
  const OffersPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    final viewModel = ref.watch(shopDetailsViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Spacial Offers', style: appBarTitleFont),
        actions: const [Icon(Icons.search, size: 30)],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                ...List.generate(
                  viewModel.offers!.length,
                  (index) => OfferWidget(
                    offer: viewModel.offers![index],
                    isSelected: viewModel.selectedOffers == null ||
                        !viewModel.selectedOffers!
                            .contains(viewModel.offers![index]),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
