import 'package:coffee_app/features/home/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/fonts.dart';
import '../view_models/home_view_model.dart';

class NearbyShopsPage extends ConsumerStatefulWidget {
  const NearbyShopsPage({super.key});

  @override
  ConsumerState<NearbyShopsPage> createState() => _NearbyShopsPageState();
}

class _NearbyShopsPageState extends ConsumerState<NearbyShopsPage> {
  @override
  Widget build(BuildContext context) {
    final homeViewModel = ref.watch(homeViewModelProvider);
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
