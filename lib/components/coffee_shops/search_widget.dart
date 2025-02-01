import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/fonts.dart';
import '../../features/coffee_shops/view_models/coffee_shops_view_model.dart';
import 'shops_widget.dart';

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
