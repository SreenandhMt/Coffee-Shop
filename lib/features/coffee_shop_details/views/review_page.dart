import 'package:coffee_app/core/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:coffee_app/core/app_colors.dart';
import 'package:coffee_app/core/fonts.dart';
import 'package:coffee_app/core/size.dart';

import '../../../components/coffee_shop_details/review_widget.dart';
import '../../../components/coffee_shop_details/total_rate_widget.dart';
import '../view_models/coffee_shop_view_model.dart';

class RatingAndReviews extends ConsumerWidget {
  const RatingAndReviews({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final size = MediaQuery.sizeOf(context);
    final viewModel = ref.watch(shopDetailsViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Rating & Reviews', style: appBarTitleFont),
      ),
      body: viewModel.reviews == null
          ? const AppProgressBar()
          : RefreshIndicator(
              onRefresh: () async {
                await ref
                    .read(shopDetailsViewModelProvider.notifier)
                    .getReviews(viewModel.shopModel!.id);
              },
              color: AppColors.primaryColor,
              child: ListView(
                children: [
                  //*total rate
                  TotalRateWidget(
                    reviewsLength: viewModel.reviews!.length,
                    shopModel: viewModel.shopModel!,
                  ),
                  //*sorting
                  height20,
                  LimitedBox(
                    maxHeight: size.width * 0.11,
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      scrollDirection: Axis.horizontal,
                      itemCount: 6,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: InkWell(
                          onTap: () => viewModel.selectedFilter == null ||
                                  viewModel.selectedFilter!.toInt() != index
                              ? ref
                                  .read(shopDetailsViewModelProvider.notifier)
                                  .reviewSort(index.toDouble())
                              : ref
                                  .read(shopDetailsViewModelProvider.notifier)
                                  .clearFilter(),
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: viewModel.selectedFilter == null ||
                                            viewModel.selectedFilter!.toInt() !=
                                                index
                                        ? Colors.grey
                                        : AppColors.primaryColor)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (index == 0) ...[
                                  const Icon(Icons.sort),
                                  width5,
                                  const Text(
                                    "Sort by",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  width5,
                                ] else ...[
                                  const Icon(Icons.star_border_rounded),
                                  width5,
                                  Text(
                                    "$index",
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  width5,
                                ]
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  //*Reviews List
                  height20,
                  ...List.generate(
                    viewModel.sortedReview!.length,
                    (index) =>
                        ReviewWidget(review: viewModel.sortedReview![index]),
                  )
                ],
              ),
            ),
    );
  }
}
