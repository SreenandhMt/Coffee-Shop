import 'package:coffee_app/features/home/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/fonts.dart';
import '../view_models/home_view_model.dart';

class NearbyShopsPage extends StatefulWidget {
  const NearbyShopsPage({super.key});

  @override
  State<NearbyShopsPage> createState() => _NearbyShopsPageState();
}

class _NearbyShopsPageState extends State<NearbyShopsPage> {
  @override
  Widget build(BuildContext context) {
    final homeViewModel = context.watch<HomeViewModel>();
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Nearby Shops", style: appBarTitleFont),
      ),
      body: GridView.builder(
        itemCount: homeViewModel.nearbyShops.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 1 / 1.28),
        itemBuilder: (context, index) => NearbyShopCard(
          shopModel: homeViewModel.nearbyShops[index],
          width: (size.width / 2) * 0.9,
        ),
      ),
    );
  }
}
