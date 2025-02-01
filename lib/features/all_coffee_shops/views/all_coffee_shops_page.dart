import 'package:coffee_app/components/all_coffee_shops/loading_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:coffee_app/core/app_colors.dart';
import 'package:coffee_app/core/assets.dart';
import 'package:coffee_app/core/fonts.dart';
import 'package:coffee_app/core/size.dart';
import 'package:coffee_app/features/all_coffee_shops/view_models/coffee_shops_view_model.dart';
import 'package:coffee_app/localization/locales.dart';

import '../../../components/all_coffee_shops/search_widget.dart';
import '../../../components/all_coffee_shops/shops_widget.dart';
import '../../../core/tabbar.dart';

class AllCoffeeShopsPage extends ConsumerStatefulWidget {
  const AllCoffeeShopsPage({super.key});

  @override
  ConsumerState<AllCoffeeShopsPage> createState() => _AllCoffeeShopsPageState();
}

class _AllCoffeeShopsPageState extends ConsumerState<AllCoffeeShopsPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(coffeeShopsViewModelProvider.notifier).getAllShops();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(coffeeShopsViewModelProvider);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: Container(
              margin: const EdgeInsets.only(left: 20),
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(AppAssets.logo)))),
          centerTitle: true,
          title:
              Text(LocaleData.shop.getString(context), style: appBarTitleFont),
          actions: const [
            ShopSearchPage(),
            width10,
          ],
        ),
        body: Column(
          children: [
            //*Current location
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                spacing: 5,
                children: [
                  const Icon(Icons.location_on_outlined),
                  width5,
                  Text(LocaleData.yourLocation.getString(context),
                      style: titleFonts(
                          fontWeight: FontWeight.w600, fontSize: 19)),
                  const Spacer(),
                  Text("New York",
                      style: titleFonts(
                          fontWeight: FontWeight.w700, fontSize: 19)),
                  const Icon(
                    Icons.arrow_drop_down_rounded,
                    size: 30,
                    color: AppColors.primaryColor,
                  )
                ],
              ),
            ),
            //*tabbar
            Container(
              height: 45,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                  color: AppColors.secondaryColor(context),
                  borderRadius: BorderRadius.circular(15)),
              child: TabBar(
                dividerColor: Colors.transparent,
                indicator: const BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black54,
                tabs: [
                  TabbarItem(text: LocaleData.allShopTitle.getString(context)),
                  TabbarItem(
                      text: LocaleData.favoriteShopTitle.getString(context)),
                ],
              ),
            ),
            //*tabbar view
            Expanded(
              child: TabBarView(children: [
                viewModel.isLoading || viewModel.coffeeShops == null
                    ? const AllCoffeeShopLoadingPage()
                    : RefreshIndicator(
                        onRefresh: () async {
                          await ref
                              .read(coffeeShopsViewModelProvider.notifier)
                              .getShops();
                        },
                        child: ListView.builder(
                          itemCount: viewModel.coffeeShops!.length,
                          itemBuilder: (context, index) {
                            return ShopWidget(
                                index: index,
                                shopModel: viewModel.coffeeShops![index]);
                          },
                        ),
                      ),
                viewModel.isLoading || viewModel.coffeeShops == null
                    ? const AllCoffeeShopLoadingPage()
                    : RefreshIndicator(
                        onRefresh: () async {
                          await ref
                              .read(coffeeShopsViewModelProvider.notifier)
                              .getFavoriteShops();
                        },
                        child: ListView.builder(
                          itemCount: viewModel.favoriteCoffeeShops.length,
                          itemBuilder: (context, index) {
                            return ShopWidget(
                              index: index,
                              shopModel: viewModel.favoriteCoffeeShops[index],
                            );
                          },
                        ),
                      )
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
