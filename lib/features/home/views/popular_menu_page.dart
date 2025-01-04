import 'package:coffee_app/core/fonts.dart';
import 'package:coffee_app/features/home/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_models/home_view_model.dart';

class PopularMenuPage extends StatefulWidget {
  const PopularMenuPage({super.key});

  @override
  State<PopularMenuPage> createState() => _PopularMenuPageState();
}

class _PopularMenuPageState extends State<PopularMenuPage> {
  @override
  Widget build(BuildContext context) {
    final homeViewModel = context.watch<HomeViewModel>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Popular Menu", style: appBarTitleFont),
      ),
      body: GridView.builder(
        itemCount: homeViewModel.popularCoffees.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 1 / 1.3),
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(10),
          child: CoffeeCard(model: homeViewModel.popularCoffees[index]),
        ),
      ),
    );
  }
  
}
