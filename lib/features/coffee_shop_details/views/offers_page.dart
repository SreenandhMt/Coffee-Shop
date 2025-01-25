import 'package:coffee_app/features/auth/views/forgot_password/email_conform_page.dart';
import 'package:coffee_app/features/checkout/view_models/checkout_view_model.dart';
import 'package:coffee_app/route/navigation_utils.dart';
import 'package:flutter/material.dart';

import 'package:coffee_app/core/app_colors.dart';
import 'package:coffee_app/core/fonts.dart';
import 'package:coffee_app/core/size.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

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
                    (index) => Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(color: Colors.grey, width: 0.2)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                viewModel.offers![index].title,
                                style: const TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w700),
                              ),
                              Text(viewModel.offers![index].description),
                              height10,
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(Icons.timer_outlined),
                                  width5,
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Valid until",
                                        style: TextStyle(fontSize: 13),
                                      ),
                                      height5,
                                      Text(
                                        viewModel.offers![index].validDate,
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700),
                                      )
                                    ],
                                  ),
                                  width10,
                                  const Icon(Icons.payment),
                                  width5,
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Min transaction",
                                        style: TextStyle(fontSize: 13),
                                      ),
                                      height5,
                                      Text(
                                        "\$${viewModel.offers![index].minPrice}",
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  ElevatedButton(
                                      onPressed: () {
                                        ref
                                            .read(shopDetailsViewModelProvider
                                                .notifier)
                                            .claimOffer(
                                                viewModel.offers![index]);
                                      },
                                      style: ButtonStyle(
                                          backgroundColor: viewModel
                                                          .selectedOffers ==
                                                      null ||
                                                  !viewModel.selectedOffers!
                                                      .contains(viewModel
                                                          .offers![index])
                                              ? const WidgetStatePropertyAll(
                                                  AppColors.primaryColor)
                                              : WidgetStatePropertyAll(
                                                  AppColors.secondaryColor(
                                                      context))),
                                      child: Text(
                                        viewModel.selectedOffers == null ||
                                                !viewModel.selectedOffers!
                                                    .contains(viewModel
                                                        .offers![index])
                                            ? "Claim"
                                            : "Claimed",
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ))
                                ],
                              )
                            ],
                          ),
                        )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
