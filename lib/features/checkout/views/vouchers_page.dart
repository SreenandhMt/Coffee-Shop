import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:coffee_app/core/fonts.dart';

import '../../../core/app_colors.dart';
import '../../../core/size.dart';
import '../../auth/views/forgot_password/email_conform_page.dart';
import '../view_models/checkout_view_model.dart';

class VouchersAndDiscountPage extends ConsumerStatefulWidget {
  const VouchersAndDiscountPage({
    super.key,
    this.isBuyingPage = false,
  });
  final bool isBuyingPage;

  @override
  ConsumerState<VouchersAndDiscountPage> createState() =>
      _VouchersAndDiscountPageState();
}

class _VouchersAndDiscountPageState
    extends ConsumerState<VouchersAndDiscountPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) =>
        ref.read(checkoutViewModelProvider.notifier).getOffers());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final checkoutViewModel = ref.watch(checkoutViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
            widget.isBuyingPage ? "Vouchers Available" : "Vouchers & Discount",
            style: appBarTitleFont),
        actions: const [Icon(Icons.search, size: 30)],
      ),
      body: checkoutViewModel.offers == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView(
                    children: List.generate(
                      checkoutViewModel.offers!.length,
                      (index) => Container(
                        padding: const EdgeInsets.all(15),
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              checkoutViewModel.offers![index].title,
                              style: const TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w700),
                            ),
                            Text(checkoutViewModel.offers![index].description),
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
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    height5,
                                    Text(
                                      checkoutViewModel
                                          .offers![index].validDate,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Min transaction",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    height5,
                                    Text(
                                      "\$${checkoutViewModel.offers![index].minPrice}",
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
                                          .read(checkoutViewModelProvider
                                              .notifier)
                                          .addPromos(checkoutViewModel
                                              .offers![index].code);
                                    },
                                    style: ButtonStyle(
                                        backgroundColor: WidgetStatePropertyAll(
                                            !checkoutViewModel.promos.contains(
                                                    checkoutViewModel
                                                        .offers![index].code)
                                                ? AppColors.primaryColor
                                                : AppColors.secondaryColor(
                                                    context))),
                                    child: Text(
                                      !checkoutViewModel.promos.contains(
                                              checkoutViewModel
                                                  .offers![index].code)
                                          ? "Use"
                                          : "Used",
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                if (widget.isBuyingPage) ...[
                  AuthButton(
                      text: "OK",
                      onPressed: () {
                        context.pop();
                      })
                ]
              ],
            ),
    );
  }
}
