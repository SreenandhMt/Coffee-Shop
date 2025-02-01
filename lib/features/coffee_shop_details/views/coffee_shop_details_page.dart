import 'package:coffee_app/core/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../components/shop_details_page/app_bar.dart';
import '../../../components/shop_details_page/checkout_button.dart';
import '../../../components/shop_details_page/coffee_list.dart';
import '/core/app_colors.dart';
import '/core/fonts.dart';
import '/core/size.dart';
import '/features/coffee_shop_details/view_models/coffee_shop_view_model.dart';
import '/route/navigation_utils.dart';
import '../../introduction/views/introduction_pages.dart';

class CoffeeShopDetailsPage extends ConsumerStatefulWidget {
  const CoffeeShopDetailsPage({
    super.key,
    required this.shopId,
  });
  final String shopId;

  @override
  ConsumerState<CoffeeShopDetailsPage> createState() =>
      _CoffeeShopDetailsPageState();
}

class _CoffeeShopDetailsPageState extends ConsumerState<CoffeeShopDetailsPage> {
  PageController controller = PageController();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => ref
        .read(shopDetailsViewModelProvider.notifier)
        .getAllData(widget.shopId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
    final viewModel = ref.watch(shopDetailsViewModelProvider);
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: viewModel.isLoading || viewModel.shopModel == null
          ? const AppProgressBar()
          : Stack(
              children: [
                ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    //*Images
                    LimitedBox(
                        maxHeight: size.height * 0.49,
                        child: Stack(
                          children: [
                            PageView(
                              controller: controller,
                              children: List.generate(
                                viewModel.shopModel!.images.length,
                                (index) => Image.network(
                                  viewModel.shopModel!.images[index],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: SmoothIndicator(
                                      controller: controller,
                                      count:
                                          viewModel.shopModel!.images.length)),
                            )
                          ],
                        )),
                    //*buttons
                    InkWell(
                      onTap: () => NavigationUtils.coffeeShopAboutPage(context,
                          shopId: widget.shopId),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(viewModel.shopModel!.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.clip,
                                  style: titleFonts(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w700)),
                            ),
                            const Icon(Icons.arrow_forward_ios_rounded),
                          ],
                        ),
                      ),
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                      child: Divider(height: 5, thickness: 0.08),
                    ),
                    //*-2
                    InkWell(
                      onTap: () => NavigationUtils.reviewAndRatingPage(context,
                          shopId: widget.shopId),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 15, bottom: 15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            width10,
                            const Icon(Icons.star_rate_rounded,
                                color: Colors.orange, size: 38),
                            width10,
                            Text(viewModel.shopModel!.rating.toString(),
                                style: const TextStyle(
                                    fontSize: 21, fontWeight: FontWeight.bold)),
                            width10,
                            Text(
                                "(${viewModel.reviews == null ? 10 : viewModel.reviews!.length} Reviews)",
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey)),
                            const Spacer(),
                            const Icon(Icons.arrow_forward_ios_rounded),
                            width10
                          ],
                        ),
                      ),
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                      child: Divider(height: 5, thickness: 0.08),
                    ),
                    //*-3
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 15, bottom: 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          width10,
                          const Icon(Icons.location_on,
                              color: Colors.green, size: 38),
                          width10,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(viewModel.shopModel!.distance,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              const Text("Available for pick-up delivery",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    //*-4
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                      child: Divider(height: 5, thickness: 0.08),
                    ),
                    InkWell(
                      onTap: () => NavigationUtils.offersPage(context),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 15, bottom: 15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            width10,
                            Icon(Icons.discount,
                                color: viewModel.offers == null ||
                                        viewModel.offers!.isEmpty
                                    ? Colors.red
                                    : Colors.green,
                                size: 30),
                            width10,
                            Text(
                                viewModel.offers == null ||
                                        viewModel.offers!.isEmpty
                                    ? "No promos are available"
                                    : "${viewModel.offers!.length} promos are available",
                                style: const TextStyle(
                                    fontSize: 19, fontWeight: FontWeight.w800)),
                            const Spacer(),
                            const Icon(Icons.arrow_forward_ios_rounded),
                            width10
                          ],
                        ),
                      ),
                    ),
                    //*category
                    height10,
                    LimitedBox(
                        maxHeight: size.width * 0.14,
                        child: ListView.builder(
                          padding: const EdgeInsets.only(left: 10),
                          scrollDirection: Axis.horizontal,
                          itemCount: viewModel.shopModel!.types.length,
                          itemBuilder: (context, index) => Container(
                              margin: const EdgeInsets.only(
                                  top: 5, bottom: 5, left: 3, right: 3),
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, bottom: 10, top: 10),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 0.5, color: Colors.grey),
                                  color: index == 0
                                      ? AppColors.primaryColor
                                      : null,
                                  borderRadius: BorderRadius.circular(30)),
                              alignment: Alignment.center,
                              child: Text(
                                viewModel.shopModel!.types[index],
                                style: TextStyle(
                                    color: index == 0 ? Colors.white : null,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                              )),
                        )),
                    height5,
                    //*Coffee List
                    const CoffeeList()
                  ],
                ),
                //*checkout button
                if (viewModel.selectedCoffeeIds.isNotEmpty)
                  const Align(
                      alignment: Alignment.bottomCenter,
                      child: CheckoutButton()),
                //*app bar on top
                const CoffeeShopDetailsAppBar()
              ],
            ),
    );
  }
}
