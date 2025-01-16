import 'package:coffee_app/core/size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/fonts.dart';
import '../../home/view_models/home_view_model.dart';
import '../../home/views/home_page.dart';

class FavoriteCoffeePage extends StatefulWidget {
  const FavoriteCoffeePage({super.key});

  @override
  State<FavoriteCoffeePage> createState() => _FavoriteCoffeePageState();
}

class _FavoriteCoffeePageState extends State<FavoriteCoffeePage> {
  @override
  Widget build(BuildContext context) {
    final homeViewModel = context.watch<HomeViewModel>();
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
