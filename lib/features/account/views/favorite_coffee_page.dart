import 'package:coffee_app/core/size.dart';
import 'package:coffee_app/features/account/view_models/account_view_model.dart';
import 'package:coffee_app/localization/locales.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../components/home/coffee_widget.dart';
import '../../../core/fonts.dart';
import '../../home/views/home_page.dart';

class FavoriteCoffeePage extends ConsumerStatefulWidget {
  const FavoriteCoffeePage({super.key});

  @override
  ConsumerState<FavoriteCoffeePage> createState() => _FavoriteCoffeePageState();
}

class _FavoriteCoffeePageState extends ConsumerState<FavoriteCoffeePage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) =>
        ref.read(accountViewModelProvider.notifier).getFavoriteCoffees());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(accountViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(LocaleData.accountFavoriteCoffeeTitle.getString(context),
            style: appBarTitleFont),
        actions: const [
          Icon(Icons.search, size: 30),
          width5,
        ],
      ),
      body: GridView.builder(
        itemCount: viewModel.favoriteCoffees.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 1 / 1.35),
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(10),
          child: CoffeeCard(model: viewModel.favoriteCoffees[index]),
        ),
      ),
    );
  }
}
