import 'package:coffee_app/core/app_colors.dart';
import 'package:coffee_app/core/fonts.dart';
import 'package:coffee_app/core/size.dart';
import 'package:coffee_app/features/auth/view_models/auth_view_model.dart';
import 'package:coffee_app/features/coffee_shop_details/models/review_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            viewModel.shopModel!.rating.toString(),
                            style: const TextStyle(
                                fontSize: 40, fontWeight: FontWeight.bold),
                          ),
                          Row(children: [
                            Icon(
                                viewModel.shopModel!.rating >= 1
                                    ? Icons.star
                                    : viewModel.shopModel!.rating >= 0.5
                                        ? Icons.star_half
                                        : Icons.star_border,
                                color: Colors.orange),
                            Icon(
                                viewModel.shopModel!.rating >= 2
                                    ? Icons.star
                                    : viewModel.shopModel!.rating >= 1.5
                                        ? Icons.star_half
                                        : Icons.star_border,
                                color: Colors.orange),
                            Icon(
                                viewModel.shopModel!.rating >= 3
                                    ? Icons.star
                                    : viewModel.shopModel!.rating >= 2.5
                                        ? Icons.star_half
                                        : Icons.star_border,
                                color: Colors.orange),
                            Icon(
                                viewModel.shopModel!.rating >= 4
                                    ? Icons.star
                                    : viewModel.shopModel!.rating >= 3.5
                                        ? Icons.star_half
                                        : Icons.star_border,
                                color: Colors.orange),
                            Icon(
                                viewModel.shopModel!.rating >= 5
                                    ? Icons.star
                                    : viewModel.shopModel!.rating >= 4.5
                                        ? Icons.star_half
                                        : Icons.star_border,
                                color: Colors.orange),
                          ]),
                          Text("(${viewModel.reviews!.length} reviews)")
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
                                maxWidth:
                                    MediaQuery.sizeOf(context).width * 0.5,
                                child: LinearProgressIndicator(
                                  value: 0.5,
                                  backgroundColor:
                                      AppColors.secondaryColor(context),
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
                                maxWidth:
                                    MediaQuery.sizeOf(context).width * 0.5,
                                child: LinearProgressIndicator(
                                  value: 0.5,
                                  backgroundColor:
                                      AppColors.secondaryColor(context),
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
                                maxWidth:
                                    MediaQuery.sizeOf(context).width * 0.5,
                                child: LinearProgressIndicator(
                                  value: 0.5,
                                  backgroundColor:
                                      AppColors.secondaryColor(context),
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
                                maxWidth:
                                    MediaQuery.sizeOf(context).width * 0.5,
                                child: LinearProgressIndicator(
                                  value: 0.5,
                                  backgroundColor:
                                      AppColors.secondaryColor(context),
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
                                maxWidth:
                                    MediaQuery.sizeOf(context).width * 0.5,
                                child: LinearProgressIndicator(
                                  value: 0.5,
                                  backgroundColor:
                                      AppColors.secondaryColor(context),
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
                ),
                // rating end - review start
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
                //
                height20,
                ...List.generate(
                  viewModel.sortedReview!.length,
                  (index) =>
                      _reviewWidget(viewModel.sortedReview![index], context),
                )
              ],
            ),
    );
  }

  _reviewWidget(ReviewModel review, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              width10,
              CircleAvatar(
                  backgroundImage: review.imageUrl.isEmpty
                      ? null
                      : NetworkImage(review.imageUrl),
                  backgroundColor: AppColors.secondaryColor(context)),
              width10,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    review.name,
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.w700),
                  ),
                  const Text("5 days ago"),
                ],
              ),
              const Spacer(),
              Icon(
                  review.rating >= 1
                      ? Icons.star
                      : review.rating >= 0.5
                          ? Icons.star_half
                          : Icons.star_border,
                  color: Colors.orange),
              Icon(
                  review.rating >= 2
                      ? Icons.star
                      : review.rating >= 1.5
                          ? Icons.star_half
                          : Icons.star_border,
                  color: Colors.orange),
              Icon(
                  review.rating >= 3
                      ? Icons.star
                      : review.rating >= 2.5
                          ? Icons.star_half
                          : Icons.star_border,
                  color: Colors.orange),
              Icon(
                  review.rating >= 4
                      ? Icons.star
                      : review.rating >= 3.5
                          ? Icons.star_half
                          : Icons.star_border,
                  color: Colors.orange),
              Icon(
                  review.rating >= 5
                      ? Icons.star
                      : review.rating >= 4.5
                          ? Icons.star_half
                          : Icons.star_border,
                  color: Colors.orange),
              width5,
              const Icon(Icons.more_vert_outlined),
              width10,
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 15, bottom: 15),
          child: Text(
            review.review,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
