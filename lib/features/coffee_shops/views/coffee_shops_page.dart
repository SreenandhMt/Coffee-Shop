import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:coffee_app/core/app_colors.dart';
import 'package:coffee_app/core/assets.dart';
import 'package:coffee_app/core/fonts.dart';
import 'package:coffee_app/core/size.dart';
import 'package:coffee_app/features/coffee_shops/view_models/coffee_shops_view_model.dart';
import 'package:coffee_app/features/home/models/shop_model.dart';
import 'package:coffee_app/localization/locales.dart';
import 'package:coffee_app/route/navigation_utils.dart';

import '../../../core/tabbar.dart';

class CoffeeShopsPage extends ConsumerStatefulWidget {
  const CoffeeShopsPage({super.key});

  @override
  ConsumerState<CoffeeShopsPage> createState() => _CoffeeShopsPageState();
}

class _CoffeeShopsPageState extends ConsumerState<CoffeeShopsPage> {
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
    final size = MediaQuery.sizeOf(context);
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
            Expanded(
              child: TabBarView(children: [
                ListView.builder(
                  itemCount: viewModel.coffeeShops.length,
                  itemBuilder: (context, index) {
                    return ShopWidget(
                        index: index, shopModel: viewModel.coffeeShops[index]);
                  },
                ),
                ListView.builder(
                  itemCount: viewModel.favoriteCoffeeShops.length,
                  itemBuilder: (context, index) {
                    return ShopWidget(
                      index: index,
                      shopModel: viewModel.favoriteCoffeeShops[index],
                    );
                  },
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

class ShopSearchPage extends ConsumerStatefulWidget {
  const ShopSearchPage({super.key});

  @override
  ConsumerState<ShopSearchPage> createState() => _ShopSearchPageState();
}

class _ShopSearchPageState extends ConsumerState<ShopSearchPage> {
  List<String> resentSearch = [
    "Caffely Astoria Aromas",
    "Caffely West Village",
    "Caffely Manhattan",
    "Caffely Well Street",
    "Caffely Queens",
    "Caffely Upper East",
  ];
  bool submitted = false;
  SearchController searchController = SearchController();
  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
        searchController: searchController,
        builder: (context, controller) => const Icon(
              Icons.search_sharp,
              size: 30,
            ),
        viewOnSubmitted: (value) async {
          await ref
              .read(coffeeShopsViewModelProvider.notifier)
              .searchShops(value);
          await Future.delayed(const Duration(milliseconds: 500));
          submitted = true;
          final query = searchController.text;
          searchController.text = ' ';
          searchController.text = query;
        },
        dividerColor: Colors.transparent,
        suggestionsBuilder: (context, controller) {
          if (submitted) {
            final searchedShops = ref.read(coffeeShopsViewModelProvider);
            return List.generate(
              searchedShops.searchedShops.length,
              (index) => ShopWidget(
                index: index,
                shopModel: searchedShops.searchedShops[index],
              ),
            );
          }
          return List.generate(
            resentSearch.length,
            (index) => ListTile(
              onTap: () {
                submitted = true;
                searchController.text = resentSearch[index];
              },
              title: Text(
                resentSearch[index],
                maxLines: 1,
                style: subtitleFont(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              trailing: IconButton(
                  onPressed: () => setState(() {
                        resentSearch.removeAt(index);
                        final query = searchController.text;
                        searchController.text = ' ';
                        searchController.text = query;
                      }),
                  icon: const Icon(Icons.close)),
            ),
          );
        });
  }
}

class ShopWidget extends ConsumerWidget {
  const ShopWidget({
    super.key,
    required this.index,
    required this.shopModel,
  });
  final int index;
  final ShopModel shopModel;

  @override
  Widget build(BuildContext context, ref) {
    final viewModel = ref.watch(coffeeShopsViewModelProvider);
    final size = MediaQuery.sizeOf(context);
    return Container(
      height: size.width * 0.3,
      margin: const EdgeInsets.only(top: 15, left: 10, right: 10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: () => NavigationUtils.coffeeShopDetailsPage(context,
            shopId: shopModel.id),
        child: Row(
          spacing: 0,
          children: [
            Container(
              height: size.width * 0.27,
              width: size.width * 0.27,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(shopModel.images[0]),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(10)),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(shopModel.name,
                        maxLines: 1,
                        style: titleFonts(
                            fontWeight: FontWeight.w700, fontSize: 20)),
                    Row(
                      spacing: 5,
                      children: [
                        const Icon(Icons.location_on_rounded,
                            color: AppColors.primaryColor),
                        Text(
                          shopModel.distance,
                          maxLines: 1,
                          style: const TextStyle(fontSize: 15),
                        ),
                        const Expanded(
                          child: Text("(350 5th Ave, New York, NY 1999)",
                              maxLines: 1),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        width5,
                        Text(shopModel.rating.toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16)),
                        const Expanded(
                            child: Text("(2.4k reviews)", maxLines: 1))
                      ],
                    )
                  ],
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded, weight: 0.1)
          ],
        ),
      ),
    );
  }
}
