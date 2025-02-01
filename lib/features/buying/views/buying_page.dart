import 'package:coffee_app/components/buying_page/size_widget.dart';
import 'package:coffee_app/components/buying_page/type_widget.dart';
import 'package:coffee_app/core/assets.dart';
import 'package:coffee_app/core/progress_bar.dart';
import 'package:coffee_app/features/buying/models/order_details_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:coffee_app/core/app_colors.dart';
import 'package:coffee_app/core/fonts.dart';
import 'package:coffee_app/core/size.dart';
import 'package:coffee_app/features/buying/view_models/buying_view_model.dart';
import 'package:coffee_app/features/coffee_shop_details/view_models/coffee_shop_view_model.dart';
import 'package:coffee_app/route/navigation_utils.dart';

import '../../../components/buying_page/option_widget.dart';

class BuyingPage extends ConsumerStatefulWidget {
  const BuyingPage({
    super.key,
    required this.id,
    required this.shopPageOpened,
  });
  final String id;
  final bool? shopPageOpened;

  @override
  ConsumerState<BuyingPage> createState() => _BuyingPageState();
}

class _BuyingPageState extends ConsumerState<BuyingPage> {
  int? selectedIndex;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) =>
        ref.read(buyingViewModelProvider.notifier).getCoffeeModel(widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final buyingViewModel = ref.watch(buyingViewModelProvider);
    return Scaffold(
      //*App bar
      appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 100),
          child: SafeArea(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                width10,
                IconButton(
                    onPressed: () => context.pop(),
                    icon: const Icon(Icons.close)),
                const Spacer(),
                IconButton(
                  onPressed: () => ref
                      .read(buyingViewModelProvider.notifier)
                      .toggleFavorite(),
                  icon: Icon(
                    buyingViewModel.isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border_rounded,
                    color: buyingViewModel.isFavorite ? Colors.red : null,
                  ),
                ),
                IconButton(
                    onPressed: () => context.pop(),
                    icon: const Icon(Icons.share_outlined)),
              ],
            ),
          )),
      //*body
      body: buyingViewModel.isLoading || buyingViewModel.coffeeModel == null
          ? const AppProgressBar()
          : ListView(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              children: [
                //*image
                AspectRatio(
                  aspectRatio: 1 / 0.93,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        color: AppColors.secondaryColor(context),
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: NetworkImage(
                                buyingViewModel.coffeeModel!.imagePath))),
                  ),
                ),
                Row(
                  children: [
                    //*name-price
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(buyingViewModel.coffeeModel!.name,
                            style: titleFonts()),
                        height5,
                        Text("\$${buyingViewModel.coffeeModel!.price}",
                            style: const TextStyle(fontSize: 16))
                      ],
                    ),
                    const Spacer(),
                    //*quantity
                    InkWell(
                      onTap: () {
                        if (buyingViewModel.quantity == 1) return;
                        ref
                            .read(buyingViewModelProvider.notifier)
                            .removeQuantity();
                      },
                      child: Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: buyingViewModel.quantity == 1
                                    ? Colors.grey
                                    : AppColors.primaryColor)),
                        child: Icon(
                          Icons.remove,
                          color: buyingViewModel.quantity == 1
                              ? Colors.grey
                              : AppColors.primaryColor,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        buyingViewModel.quantity.toString(),
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (buyingViewModel.quantity >= 10) return;
                        ref
                            .read(buyingViewModelProvider.notifier)
                            .addQuantity();
                      },
                      child: Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: buyingViewModel.quantity >= 10
                                    ? Colors.grey
                                    : AppColors.primaryColor)),
                        child: Icon(
                          Icons.add,
                          color: buyingViewModel.quantity >= 10
                              ? Colors.grey
                              : AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                //*type
                height20,
                AvailableTypeWidget(
                    onTap: (value) => ref
                        .read(buyingViewModelProvider.notifier)
                        .selectTypeIndex(value),
                    selectedIndex: buyingViewModel.selectedTypeIndex),
                //*size
                height20,
                AvailableSizeWidget(
                    onTap: (value, price, oldPrice) => ref
                        .read(buyingViewModelProvider.notifier)
                        .selectSizeIndex(value, price, oldPrice),
                    selectedIndex: buyingViewModel.selectedSizeIndex),
                //*ad on options
                height15,
                ...List.generate(
                    buyingViewModel.coffeeModel!.optionList!.length,
                    (index) => OptionWidget(
                        title: buyingViewModel.coffeeModel!.optionList![index]
                            ["name"],
                        values: buyingViewModel.coffeeModel!.optionList![index]
                            ["options"],
                        currentValue:
                            buyingViewModel.selectedOption.length > index
                                ? buyingViewModel.selectedOption[index]
                                : null,
                        onTap: (value, price, oldPrice) => ref
                            .read(buyingViewModelProvider.notifier)
                            .selectOption(value, index, price, oldPrice))),
                //*notes
                height20,
                const Text("Notes",
                    style:
                        TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
                height15,
                TextFormField(
                  maxLines: 4,
                  style: TextStyle(
                      fontSize: 16, color: AppColors.themeColor(context)),
                  decoration: InputDecoration(
                      hintText: "Example: No added cream",
                      hintStyle:
                          const TextStyle(fontSize: 16, color: Colors.grey),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none)),
                ),
                height20,
                //*price and button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text("Total Price"),
                        Text(
                          "\$${buyingViewModel.totalPrice.toString()}",
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        fixedSize:
                            Size(MediaQuery.sizeOf(context).width * 0.7, 60),
                      ),
                      onPressed: () {
                        //* getting order model
                        final orderModel = ref
                            .read(buyingViewModelProvider.notifier)
                            .getProducts();
                        //* adding basket
                        ref
                            .read(shopDetailsViewModelProvider.notifier)
                            .addProductID(orderModel);
                        context.pop();
                        //* opening shop page
                        if (!widget.shopPageOpened!) {
                          NavigationUtils.coffeeShopDetailsPage(context,
                              shopId: buyingViewModel.coffeeModel!.shopId);
                        }
                      },
                      child: const Text("Add to Basket",
                          style: TextStyle(color: Colors.white, fontSize: 17)),
                    ),
                  ],
                ),
                height25,
              ],
            ),
    );
  }
}
