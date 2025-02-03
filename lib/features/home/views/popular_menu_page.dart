import 'package:coffee_app/core/fonts.dart';
import 'package:coffee_app/features/home/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../components/home/coffee_widget.dart';
import '../../../localization/locales.dart';
import '../view_models/home_view_model.dart';

class PopularMenuPage extends ConsumerStatefulWidget {
  const PopularMenuPage({super.key});

  @override
  ConsumerState<PopularMenuPage> createState() => _PopularMenuPageState();
}

class _PopularMenuPageState extends ConsumerState<PopularMenuPage> {
  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homeViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(LocaleData.homeProductListTitle.getString(context),
            style: appBarTitleFont),
      ),
      body: GridView.builder(
        itemCount: homeState.popularCoffees.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 1 / 1.34),
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(10),
          child: CoffeeCard(model: homeState.popularCoffees[index]),
        ),
      ),
    );
  }
}
