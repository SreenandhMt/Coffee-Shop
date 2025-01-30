import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:coffee_app/core/app_colors.dart';
import 'package:coffee_app/core/fonts.dart';
import 'package:coffee_app/core/size.dart';
import 'package:coffee_app/features/home/view_models/home_view_model.dart';
import 'package:coffee_app/features/introduction/views/introduction_pages.dart';
import 'package:coffee_app/localization/locales.dart';
import 'package:coffee_app/route/navigation_utils.dart';

import '../../../components/home/coffee_widget.dart';
import '../../../components/home/home_category_text.dart';
import '../../../components/home/shop_widget.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) => ref.read(homeViewModelProvider.notifier).getAllData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final homeState = ref.watch(homeViewModelProvider);
    return Scaffold(
      appBar: _appBar(),
      body: ListView(
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              LimitedBox(
                maxHeight: size.width * 0.6,
                child: PageView(
                  children: List.generate(
                    homeState.banners.length,
                    (index) => InkWell(
                      onTap: () {
                        ref
                            .read(homeViewModelProvider.notifier)
                            .selectBanner(homeState.banners[index]);
                        NavigationUtils.offerDetailsPage(context);
                      },
                      child: Container(
                        width: double.infinity,
                        height: 200,
                        margin: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColors.secondaryColor(context),
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: NetworkImage(homeState.banners[index].image),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 25),
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SmoothIndicator(
                        controller: controller,
                        count: homeState.banners.length)),
              )
            ],
          ),
          HomeCategoryText(
              text: LocaleData.homeShopListTitle.getString(context),
              onTap: () => NavigationUtils.nearbyShopsPage(context)),
          LimitedBox(
              maxHeight: size.width * 0.65,
              maxWidth: size.width,
              child: ListView(
                padding: const EdgeInsets.only(left: 5),
                scrollDirection: Axis.horizontal,
                children: List.generate(
                    homeState.nearbyShops.length,
                    (index) => NearbyShopCard(
                        shopModel: homeState.nearbyShops[index],
                        width: size.width * 0.37)),
              )),
          HomeCategoryText(
              text: LocaleData.homeProductListTitle.getString(context),
              onTap: () => NavigationUtils.popularMenuPage(context)),
          height20,
          GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 1 / 1.25),
              itemBuilder: (context, index) =>
                  CoffeeCard(model: homeState.popularCoffees[index]),
              itemCount: homeState.popularCoffees.length),
        ],
      ),
    );
  }

  _appBar() {
    return AppBar(
      surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
      leading: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: CircleAvatar(backgroundColor: AppColors.themeColor(context)),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Good Morning 🌤️",
            style: subtitleFont(fontSize: 15),
          ),
          Text(
            FirebaseAuth.instance.currentUser!.displayName ?? "",
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
          )
        ],
      ),
      actions: [
        InkWell(
          onTap: () => NavigationUtils.notificationPage(context),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                color: AppColors.secondaryColor(context),
                border: Border.all(width: 0.4, color: Colors.grey),
                shape: BoxShape.circle),
            padding: const EdgeInsets.all(9),
            child: Badge(
              largeSize: 10,
              alignment: Alignment.topRight,
              offset: Offset.zero,
              label: const CircleAvatar(
                radius: 1,
                backgroundColor: Colors.transparent,
              ),
              child: Icon(
                CupertinoIcons.bell,
                color: AppColors.themeColor(context),
                size: 30,
              ),
            ),
          ),
        )
      ],
    );
  }
}
