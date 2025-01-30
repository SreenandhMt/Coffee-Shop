import 'package:coffee_app/features/introduction/views/introduction_pages.dart';
import 'package:coffee_app/localization/locales.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:coffee_app/core/app_colors.dart';
import 'package:coffee_app/core/fonts.dart';
import 'package:coffee_app/core/size.dart';
import 'package:coffee_app/features/home/models/coffee_model.dart';
import 'package:coffee_app/features/home/models/shop_model.dart';
import 'package:coffee_app/features/home/view_models/home_view_model.dart';
import 'package:coffee_app/route/navigation_utils.dart';

final _titleFont = subtitleFont(fontSize: 17, fontWeight: FontWeight.w700);

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
          _homeScreenCategoryText(
              LocaleData.homeShopListTitle.getString(context),
              () => NavigationUtils.nearbyShopsPage(context)),
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
          _homeScreenCategoryText(
              LocaleData.homeProductListTitle.getString(context),
              () => NavigationUtils.popularMenuPage(context)),
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

  Widget _homeScreenCategoryText(String text, onTap) {
    return Row(
      children: [
        width20,
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
          ),
        ),
        InkWell(
          onTap: onTap,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                LocaleData.viewAll.getString(context),
                style: const TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              width10,
              const Icon(Icons.arrow_forward_ios,
                  size: 15, color: AppColors.primaryColor),
            ],
          ),
        ),
        width20,
      ],
    );
  }
}

class CoffeeCard extends StatelessWidget {
  const CoffeeCard({
    super.key,
    required this.model,
    this.selected = false,
    this.isShopPage = false,
    this.onLongPress,
  });

  final CoffeeModel model;
  final bool selected;
  final bool isShopPage;
  final void Function()? onLongPress;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return InkWell(
      onLongPress: onLongPress,
      onTap: () => NavigationUtils.buyingPage(context, model.id, isShopPage),
      child: Column(
        children: [
          Container(
            width: (size.width / 2) * 0.9,
            height: size.width * 0.45,
            decoration: BoxDecoration(
              color: AppColors.secondaryColor(context),
              border: selected
                  ? Border.all(
                      width: 2.5,
                      color: AppColors.primaryColor,
                    )
                  : null,
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(model.imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 8.0),
            child: SizedBox(
              width: size.width * 0.4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    style: subtitleFont(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: selected ? AppColors.primaryColor : null),
                    maxLines: 2,
                  ),
                  Text("\$${model.price}",
                      style: const TextStyle(
                          fontSize: 15, color: AppColors.primaryColor))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class NearbyShopCard extends StatelessWidget {
  const NearbyShopCard({
    super.key,
    required this.shopModel,
    required this.width,
  });
  final ShopModel shopModel;
  final double width;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return InkWell(
      onTap: () =>
          NavigationUtils.coffeeShopDetailsPage(context, shopId: shopModel.id),
      child: Container(
        width: width,
        height: size.width * 0.65,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Container(
              // width: size.width*0.4,
              height: size.width * 0.35,
              decoration: BoxDecoration(
                color: AppColors.secondaryColor(context),
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(shopModel.images[0]),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.themeColor(context).withOpacity(0.5),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.star_rate_rounded,
                            color: Colors.orange,
                          ),
                          Text(
                            shopModel.rating.toString(),
                            style: const TextStyle(
                                fontSize: 13, color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 8.0),
              child: SizedBox(
                // width: size.width*0.4,
                height: size.width * 0.2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(shopModel.name, style: _titleFont, maxLines: 2),
                    Row(
                      children: [
                        const Icon(Icons.location_on,
                            color: AppColors.primaryColor, size: 17),
                        width5,
                        Text(
                          shopModel.distance,
                          style: subtitleFont(fontSize: 15),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
