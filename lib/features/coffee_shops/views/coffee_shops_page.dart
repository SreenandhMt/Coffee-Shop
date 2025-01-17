import 'package:coffee_app/core/app_colors.dart';
import 'package:coffee_app/core/fonts.dart';
import 'package:coffee_app/core/size.dart';
import 'package:coffee_app/features/coffee_shops/view_models/coffee_shops_view_model.dart';
import 'package:coffee_app/route/navigation_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/tabbar.dart';

class CoffeeShopsPage extends ConsumerStatefulWidget {
  const CoffeeShopsPage({super.key});

  @override
  ConsumerState<CoffeeShopsPage> createState() => _CoffeeShopsPageState();
}

class _CoffeeShopsPageState extends ConsumerState<CoffeeShopsPage> {
  List<String> resentSearch = [
    "Caffely Central Park",
    "Caffely Times Square",
    "Caffely Brooklyn Blend",
    "Caffely Broadway Brews",
    "Caffely SoHo Sips",
    "Caffely Chelsea Chai",
    "Caffely Wall Street Beans"
  ];
  bool submitted = false;
  SearchController searchController = SearchController();
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
            width: 30,
            height: 30,
            color: AppColors.primaryColor,
          ),
          centerTitle: true,
          title: Text("Shop", style: appBarTitleFont),
          actions: [
            SearchAnchor(
              searchController: searchController,
              builder: (context, controller) => const Icon(
                Icons.search_sharp,
                size: 30,
              ),
              viewOnSubmitted: (value) {
                submitted = true;
                final query = searchController.text;
                searchController.text = ' ';
                searchController.text = query;
              },
              dividerColor: Colors.transparent,
              suggestionsBuilder: (context, controller) => submitted
                  ? List.generate(viewModel.favoriteCoffeeShops.length,
                      (index) => _buildSearchResult(index, viewModel, size))
                  : List.generate(
                      resentSearch.length,
                      (index) => ListTile(
                        onTap: () {
                          submitted = true;
                          searchController.text = resentSearch[index];
                        },
                        title: Text(
                          resentSearch[index],
                          maxLines: 1,
                          style: subtitleFont(
                              fontSize: 16, fontWeight: FontWeight.w500),
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
                    ),
            ),
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
                  Text("Your Location",
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
              child: const TabBar(
                dividerColor: Colors.transparent,
                indicator: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black54,
                tabs: [
                  TabbarItem(text: "All"),
                  TabbarItem(text: "Favorite"),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(children: [
                ListView.builder(
                  itemCount: viewModel.coffeeShops.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: size.width * 0.3,
                      margin:
                          const EdgeInsets.only(top: 15, left: 10, right: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: InkWell(
                        onTap: () => NavigationUtils.coffeeShopDetailsPage(
                            context,
                            shopId: viewModel.coffeeShops[index].id),
                        child: Row(
                          spacing: 0,
                          children: [
                            Container(
                              height: size.width * 0.27,
                              width: size.width * 0.27,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          viewModel.coffeeShops[index].image),
                                      fit: BoxFit.cover),
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(viewModel.coffeeShops[index].name,
                                        maxLines: 1,
                                        style: titleFonts(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 20)),
                                    Row(
                                      spacing: 5,
                                      children: [
                                        const Icon(Icons.location_on_rounded,
                                            color: AppColors.primaryColor),
                                        Text(
                                          viewModel.coffeeShops[index].distance,
                                          maxLines: 1,
                                          style: const TextStyle(fontSize: 15),
                                        ),
                                        const Expanded(
                                          child: Text(
                                              "(350 5th Ave, New York, NY 1999)",
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
                                        Text(
                                            viewModel.coffeeShops[index].rating,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16)),
                                        const Expanded(
                                            child: Text("(2.4k reviews)",
                                                maxLines: 1))
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const Icon(Icons.arrow_forward_ios_rounded,
                                weight: 0.1)
                          ],
                        ),
                      ),
                    );
                  },
                ),
                ListView.builder(
                  itemCount: viewModel.favoriteCoffeeShops.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: size.width * 0.3,
                      margin:
                          const EdgeInsets.only(top: 15, left: 10, right: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: InkWell(
                        onTap: () => NavigationUtils.coffeeShopDetailsPage(
                            context,
                            shopId: viewModel.favoriteCoffeeShops[index].id),
                        child: Row(
                          spacing: 0,
                          children: [
                            Container(
                              height: size.width * 0.27,
                              width: size.width * 0.27,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(viewModel
                                          .favoriteCoffeeShops[index].image),
                                      fit: BoxFit.cover),
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        viewModel
                                            .favoriteCoffeeShops[index].name,
                                        maxLines: 1,
                                        style: titleFonts(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 20)),
                                    Row(
                                      spacing: 5,
                                      children: [
                                        const Icon(Icons.location_on_rounded,
                                            color: AppColors.primaryColor),
                                        Text(
                                          viewModel.favoriteCoffeeShops[index]
                                              .distance,
                                          maxLines: 1,
                                          style: const TextStyle(fontSize: 15),
                                        ),
                                        const Expanded(
                                          child: Text(
                                              "(350 5th Ave, New York, NY 1999)",
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
                                        Text(
                                          viewModel.favoriteCoffeeShops[index]
                                              .rating,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                          ),
                                        ),
                                        const Expanded(
                                          child: Text(
                                            "(2.4k reviews)",
                                            maxLines: 1,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const Icon(Icons.arrow_forward_ios_rounded,
                                weight: 0.1)
                          ],
                        ),
                      ),
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

  Widget _buildSearchResult(int index, CoffeeShopsStateModel viewModel, size) {
    return Container(
      height: size.width * 0.3,
      margin: const EdgeInsets.only(top: 15, left: 10, right: 10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: () => NavigationUtils.coffeeShopDetailsPage(context,
            shopId: viewModel.coffeeShops[index].id),
        child: Row(
          spacing: 0,
          children: [
            Container(
              height: size.width * 0.27,
              width: size.width * 0.27,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(viewModel.coffeeShops[index].image),
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
                    Text(viewModel.coffeeShops[index].name,
                        maxLines: 1,
                        style: titleFonts(
                            fontWeight: FontWeight.w700, fontSize: 20)),
                    Row(
                      spacing: 5,
                      children: [
                        const Icon(Icons.location_on_rounded,
                            color: AppColors.primaryColor),
                        Text(
                          viewModel.coffeeShops[index].distance,
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
                        Text(viewModel.coffeeShops[index].rating,
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
