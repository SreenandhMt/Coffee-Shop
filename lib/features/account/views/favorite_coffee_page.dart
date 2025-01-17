import 'package:coffee_app/core/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/fonts.dart';
import '../../home/view_models/home_view_model.dart';
import '../../home/views/home_page.dart';

class FavoriteCoffeePage extends ConsumerStatefulWidget {
  const FavoriteCoffeePage({super.key});

  @override
  ConsumerState<FavoriteCoffeePage> createState() => _FavoriteCoffeePageState();
}

class _FavoriteCoffeePageState extends ConsumerState<FavoriteCoffeePage> {
  @override
  Widget build(BuildContext context) {
    final homeViewModel = ref.watch(homeViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Favorite Coffee", style: appBarTitleFont),
        actions: const [
          Icon(Icons.search, size: 30),
          width5,
        ],
      ),
      body: GridView.builder(
        itemCount: homeViewModel.popularCoffees.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 1 / 1.3),
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(10),
          child: CoffeeCard(model: homeViewModel.popularCoffees[index]),
        ),
      ),
    );
  }
}
