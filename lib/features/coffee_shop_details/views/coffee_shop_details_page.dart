import 'package:coffee_app/features/checkout/view_models/checkout_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '/core/app_colors.dart';
import '/core/fonts.dart';
import '/core/size.dart';
import '/features/coffee_shop_details/view_models/coffee_shop_view_model.dart';
import '/route/navigation_utils.dart';
import '../../home/views/home_page.dart';
import '../../introduction/views/introduction_pages.dart';

class CoffeeShopDetailsPage extends StatefulWidget {
  const CoffeeShopDetailsPage({
    super.key,
    required this.shopId,
  });
  final String shopId;

  @override
  State<CoffeeShopDetailsPage> createState() => _CoffeeShopDetailsPageState();
}

class _CoffeeShopDetailsPageState extends State<CoffeeShopDetailsPage> {
  PageController controller = PageController();
  final list = ["Coffee", "Baked", "Sandwich", "Cakes", "Cookies"];
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) =>
        context.read<CoffeeShopViewModel>().getShopDetails(widget.shopId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
    final viewModel = context.watch<CoffeeShopViewModel>();
    final backgroundColor = Colors.grey.withOpacity(0.8);
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: viewModel.isLoading || viewModel.shopModel == null
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    LimitedBox(
                        maxHeight: size.height * 0.4,
                        child: Stack(
                          children: [
                            PageView(
                              controller: controller,
                              children: List.generate(
                                1,
                                (index) => Image.network(
                                  viewModel.shopModel!.image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: SmoothIndicator(
                                      controller: controller, count: 1)),
                            )
                          ],
                        )),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(viewModel.shopModel!.name,
                                maxLines: 1,
                                overflow: TextOverflow.clip,
                                style: titleFonts(
                                    fontSize: 25, fontWeight: FontWeight.w700)),
                          ),
                          InkWell(
                              onTap: () => NavigationUtils.coffeeShopAboutPage(
                                  context,
                                  shopId: widget.shopId),
                              child:
                                  const Icon(Icons.arrow_forward_ios_rounded)),
                        ],
                      ),
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                      child: Divider(height: 5, thickness: 0.08),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 15, bottom: 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          width10,
                          const Icon(Icons.star_rate_rounded,
                              color: Colors.orange, size: 38),
                          width10,
                          Text(viewModel.shopModel!.rating,
                              style: const TextStyle(
                                  fontSize: 21, fontWeight: FontWeight.bold)),
                          width10,
                          const Text("(23k Reviews)",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey)),
                          const Spacer(),
                          InkWell(
                              onTap: () => NavigationUtils.reviewAndRatingPage(
                                  context,
                                  shopId: widget.shopId),
                              child:
                                  const Icon(Icons.arrow_forward_ios_rounded)),
                          width10
                        ],
                      ),
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                      child: Divider(height: 5, thickness: 0.08),
                    ),
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
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                      child: Divider(height: 5, thickness: 0.08),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 15, bottom: 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          width10,
                          const Icon(Icons.discount,
                              color: Colors.green, size: 30),
                          width10,
                          const Text("5 promos are available",
                              style: TextStyle(
                                  fontSize: 19, fontWeight: FontWeight.w800)),
                          const Spacer(),
                          InkWell(
                              onTap: () => NavigationUtils.offersPage(context,
                                  shopId: widget.shopId),
                              child:
                                  const Icon(Icons.arrow_forward_ios_rounded)),
                          width10
                        ],
                      ),
                    ),
                    height10,
                    LimitedBox(
                        maxHeight: size.width * 0.14,
                        child: ListView.builder(
                          padding: const EdgeInsets.only(left: 10),
                          scrollDirection: Axis.horizontal,
                          itemCount: list.length,
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
                                list[index],
                                style: const TextStyle(fontSize: 15),
                              )),
                        )),
                    height5,
                    _coffeeList()
                  ],
                ),
                if (viewModel.selectedCoffeeIds.isNotEmpty)
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 80,
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          width10,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              height5,
                              Text(
                                "Total ${viewModel.selectedCoffeeIds.length} item(s)",
                                style: const TextStyle(color: Colors.white),
                              ),
                              Text(
                                "\$${viewModel.totalPrice}",
                                style: const TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              ),
                              const Spacer()
                            ],
                          ),
                          const Spacer(),
                          Text(
                            "Checkout",
                            style: subtitleFont(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                          IconButton(
                              onPressed: () {
                                if (viewModel.selectedCoffeeIds.isNotEmpty) {
                                  context
                                      .read<CheckoutViewModel>()
                                      .setOrderModels(
                                          viewModel.selectedCoffeeIds);
                                  NavigationUtils.checkoutPage(context);
                                }
                              },
                              icon: const Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.white,
                              )),
                          width10
                        ],
                      ),
                    ),
                  ),
                Padding(
                  padding: EdgeInsets.only(
                      left: 10,
                      right: 10,
                      top: MediaQuery.paddingOf(context).top),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () => context.pop(),
                          style: ButtonStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll(backgroundColor)),
                          icon: Icon(
                            Icons.arrow_back,
                            color: AppColors.backgroundColor(context),
                          )),
                      const Spacer(),
                      IconButton(
                          onPressed: () {},
                          style: ButtonStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll(backgroundColor)),
                          icon: Icon(Icons.favorite_border,
                              color: AppColors.backgroundColor(context))),
                      IconButton(
                          onPressed: () {},
                          style: ButtonStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll(backgroundColor)),
                          icon: Icon(Icons.share_rounded,
                              color: AppColors.backgroundColor(context)))
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  _coffeeList() {
    final viewModel = context.watch<CoffeeShopViewModel>();
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
              return Padding(
                padding: const EdgeInsets.all(10),
                child: CoffeeCard(
                  model: viewModel.coffeeModel![index],
                  isShopPage: true,
                  selected: true,
                ),
              );
            }
          }
        }
        return Padding(
          padding: const EdgeInsets.all(10),
          child: CoffeeCard(
            model: viewModel.coffeeModel![index],
            isShopPage: true,
          ),
        );
      },
    );
  }
}
