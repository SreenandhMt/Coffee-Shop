import 'package:coffee_app/core/assets.dart';
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
      body: buyingViewModel.isLoading || buyingViewModel.coffeeModel == null
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              children: [
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
                height20,
                AvailableTypeWidget(
                    onTap: (value) => ref
                        .read(buyingViewModelProvider.notifier)
                        .selectTypeIndex(value),
                    selectedIndex: buyingViewModel.selectedTypeIndex),
                height20,
                AvailableSizeWidget(
                    onTap: (value, price, oldPrice) => ref
                        .read(buyingViewModelProvider.notifier)
                        .selectSizeIndex(value, price, oldPrice),
                    selectedIndex: buyingViewModel.selectedSizeIndex),
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
                        final orderModel = ref
                            .read(buyingViewModelProvider.notifier)
                            .getProducts();
                        ref
                            .read(shopDetailsViewModelProvider.notifier)
                            .addProductID(orderModel);
                        context.pop();
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

class AvailableSizeWidget extends StatefulWidget {
  const AvailableSizeWidget({
    super.key,
    this.selectedIndex,
    required this.onTap,
  });
  final int? selectedIndex;
  final Function(int, double, double?) onTap;

  @override
  State<AvailableSizeWidget> createState() => AvailableSizeWidgetState();
}

class AvailableSizeWidgetState extends State<AvailableSizeWidget> {
  final sizes = [
    {"title": "Toll", "price": "Free"},
    {"title": "Grande", "price": "0.50"},
    {"title": "Venti", "price": "1.00"},
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Size",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
        height15,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            sizes.length,
            (index) => Padding(
              padding: const EdgeInsets.only(right: 2),
              child: InkWell(
                onTap: () => widget.onTap(
                    index,
                    sizes[index]["price"] == "Free"
                        ? 0.00
                        : double.tryParse(sizes[index]["price"]!)!,
                    widget.selectedIndex == null
                        ? null
                        : sizes[widget.selectedIndex!]['price'] == "Free"
                            ? 0.00
                            : double.tryParse(
                                sizes[widget.selectedIndex!]['price']!)),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 23),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: index == widget.selectedIndex
                            ? AppColors.primaryColor
                            : Colors.grey,
                        width: index == widget.selectedIndex ? 1.0 : 0.1),
                    color: index == widget.selectedIndex
                        ? AppColors.primaryColor.withOpacity(0.2)
                        : AppColors.secondaryColor(context),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(15 - (index * 5)),
                        child: Image.asset(
                          AppAssets.hotCoffee(context),
                          width: (40 + ((index) * 10)),
                          height: (40 + ((index) * 10)),
                        ),
                      ),
                      height5,
                      Text(sizes[index]["title"] ?? "",
                          style: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w700)),
                      height5,
                      Text(
                          "${sizes[index]["price"] == "Free" ? "" : "+ "}${sizes[index]["price"]}",
                          style: const TextStyle(fontSize: 15))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class AvailableTypeWidget extends StatefulWidget {
  const AvailableTypeWidget({
    super.key,
    this.selectedIndex,
    required this.onTap,
  });
  final int? selectedIndex;
  final Function(int) onTap;

  @override
  State<AvailableTypeWidget> createState() => AavailableStateTypeWidget();
}

class AavailableStateTypeWidget extends State<AvailableTypeWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Available in",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
        height15,
        Row(
          children: [
            ...List.generate(
              2,
              (index) => Padding(
                padding: const EdgeInsets.only(right: 10),
                child: InkWell(
                  onTap: () => widget.onTap(index),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 23),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          width: widget.selectedIndex == index ? 1.0 : 0.1,
                          color: widget.selectedIndex == index
                              ? AppColors.primaryColor
                              : Colors.grey),
                      color: widget.selectedIndex == index
                          ? AppColors.primaryColor.withOpacity(0.2)
                          : AppColors.secondaryColor(context),
                    ),
                    child: Column(
                      children: [
                        if (index == 0)
                          Image.asset(
                            AppAssets.hotCoffee(context),
                            width: 70,
                            height: 70,
                          )
                        else
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Image.asset(
                              AppAssets.iceCoffee(context),
                              width: 60,
                              height: 60,
                            ),
                          ),
                        height5,
                        Text(index == 0 ? "Hot" : "Iced",
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class OptionWidget extends StatefulWidget {
  const OptionWidget({
    super.key,
    required this.title,
    required this.currentValue,
    required this.values,
    required this.onTap,
  });
  final String title;
  final Map<String, dynamic>? currentValue;
  final List<dynamic> values;
  final Function(Map<String, dynamic>, double, double?) onTap;

  @override
  State<OptionWidget> createState() => OoptionWidgetState();
}

class OoptionWidgetState extends State<OptionWidget> {
  bool isHide = false;
  List<Map<String, dynamic>> mapValue = [];

  @override
  void initState() {
    for (var element in widget.values) {
      mapValue.add(element);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              widget.title,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
            ),
            width5,
            const Text("(Optional)", style: TextStyle(fontSize: 15)),
            const Spacer(),
            const Text("Max 1",
                style: TextStyle(
                    fontSize: 15,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w800)),
            IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  setState(() {
                    isHide = !isHide;
                  });
                },
                icon: Icon(
                    isHide
                        ? Icons.keyboard_arrow_down_rounded
                        : Icons.keyboard_arrow_up_rounded,
                    color: AppColors.primaryColor))
          ],
        ),
        if (!isHide)
          ...List.generate(
            mapValue.length,
            (index) => Row(
              children: [
                Text(
                  mapValue[index]["name"],
                  style: const TextStyle(fontSize: 17),
                ),
                const Spacer(),
                Text("+ \$${mapValue[index]["price"]}",
                    style: const TextStyle(fontSize: 15)),
                Radio(
                  fillColor:
                      const WidgetStatePropertyAll(AppColors.primaryColor),
                  value: mapValue[index],
                  groupValue: widget.currentValue,
                  onChanged: (c) => widget.onTap(
                      c!,
                      double.parse(c["price"]),
                      widget.currentValue != null
                          ? double.parse(widget.currentValue!["price"])
                          : null),
                ),
              ],
            ),
          ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Divider(
            thickness: 0.03,
          ),
        )
      ],
    );
  }
}
