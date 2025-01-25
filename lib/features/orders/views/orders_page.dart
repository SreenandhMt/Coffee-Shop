import 'package:coffee_app/core/size.dart';
import 'package:coffee_app/core/tabbar.dart';
import 'package:coffee_app/route/navigation_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';
import '../../../core/assets.dart';
import '../../../core/fonts.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
            leading: Container(
                margin: const EdgeInsets.only(left: 20),
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(AppAssets.logo)))),
            centerTitle: true,
            title: Text("Orders", style: appBarTitleFont),
            actions: const [
              Icon(Icons.search_rounded, size: 30),
              width5,
            ]),
        body: Column(
          children: [
            Container(
              height: 45,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                  color: AppColors.secondaryColor(context),
                  borderRadius: BorderRadius.circular(15)),
              child: const TabBar(
                dividerColor: Colors.transparent,
                indicator: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black54,
                tabs: [
                  TabbarItem(text: "Active"),
                  TabbarItem(text: "Completed"),
                  TabbarItem(text: "Canceled"),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(children: [
                Column(
                  spacing: 10,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey, width: 0.2),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: InkWell(
                              onTap: () =>
                                  NavigationUtils.orderDetailsPagePickup(
                                      context),
                              child: Row(
                                spacing: 5,
                                children: [
                                  width10,
                                  Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color: AppColors.secondaryColor(context),
                                      borderRadius: BorderRadius.circular(10),
                                      image: const DecorationImage(
                                        image: AssetImage("assets/image1.png"),
                                      ),
                                    ),
                                  ),
                                  width5,
                                  Column(
                                    spacing: 5,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Classic Brew",
                                        maxLines: 1,
                                        style: titleFonts(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      const Row(
                                        spacing: 4,
                                        children: [
                                          Icon(Icons.add_business_rounded,
                                              size: 17),
                                          Text("Caffely Astoria Aromas")
                                        ],
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 8),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: AppColors.primaryColor,
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: const Text(
                                          "Pick Up",
                                          style: TextStyle(
                                              color: AppColors.primaryColor),
                                        ),
                                      )
                                    ],
                                  ),
                                  const Spacer(),
                                  const Icon(Icons.arrow_forward_ios_rounded),
                                  width5,
                                ],
                              ),
                            ),
                          ),
                          //
                          height5,
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Divider(
                              thickness: 0.2,
                              color: Colors.grey,
                            ),
                          ),
                          //
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 20),
                            child: Row(
                              children: [
                                const Text(
                                  "Remind me 30 minutes earlier",
                                  style: TextStyle(fontSize: 16),
                                ),
                                const Spacer(),
                                CupertinoSwitch(
                                  value: true,
                                  onChanged: (value) {},
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    //
                    Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey, width: 0.2),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: InkWell(
                              onTap: () =>
                                  NavigationUtils.orderDetailsPageDelivery(
                                      context),
                              child: Row(
                                spacing: 5,
                                children: [
                                  width10,
                                  Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color: AppColors.secondaryColor(context),
                                      borderRadius: BorderRadius.circular(10),
                                      image: const DecorationImage(
                                        image: AssetImage("assets/image1.png"),
                                      ),
                                    ),
                                  ),
                                  width5,
                                  Column(
                                    spacing: 5,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Classic Brew",
                                        maxLines: 1,
                                        style: titleFonts(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      const Row(
                                        spacing: 4,
                                        children: [
                                          Icon(Icons.add_business_rounded,
                                              size: 17),
                                          Text("Caffely Astoria Aromas")
                                        ],
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 8),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: AppColors.primaryColor,
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: const Text(
                                          "Pick Up",
                                          style: TextStyle(
                                              color: AppColors.primaryColor),
                                        ),
                                      )
                                    ],
                                  ),
                                  const Spacer(),
                                  const Icon(Icons.arrow_forward_ios_rounded),
                                  width10,
                                ],
                              ),
                            ),
                          ),
                          //
                          height5,
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Divider(
                              thickness: 0.2,
                              color: Colors.grey,
                            ),
                          ),
                          //
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Row(
                              spacing: 10,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    height: 40,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            color: AppColors.primaryColor,
                                            width: 2)),
                                    child: const Text("Cancel Order",
                                        style: TextStyle(
                                            color: AppColors.primaryColor)),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    height: 40,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: AppColors.primaryColor),
                                    child: const Text("Track Order",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                ListView.builder(
                  itemCount: 6,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      spacing: 10,
                      children: [
                        width10,
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: AppColors.secondaryColor(context),
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: AssetImage("assets/image${index + 1}.png"),
                            ),
                          ),
                        ),
                        width5,
                        Column(
                          spacing: 5,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Classic Brew",
                              maxLines: 1,
                              style: titleFonts(
                                  fontSize: 18, fontWeight: FontWeight.w700),
                            ),
                            const Row(
                              spacing: 4,
                              children: [
                                Icon(Icons.add_business_rounded, size: 17),
                                Text("Caffely Astoria Aromas")
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 8),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColors.primaryColor, width: 2),
                                  borderRadius: BorderRadius.circular(5)),
                              child: const Text(
                                "Pick Up",
                                style: TextStyle(color: AppColors.primaryColor),
                              ),
                            )
                          ],
                        ),
                        const Spacer(),
                        const Icon(Icons.arrow_forward_ios_rounded),
                        width10,
                      ],
                    ),
                  ),
                ),
                ListView.builder(
                  itemCount: 6,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      spacing: 10,
                      children: [
                        width10,
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: AppColors.secondaryColor(context),
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: AssetImage("assets/image${6 - index}.png"),
                            ),
                          ),
                        ),
                        width5,
                        Column(
                          spacing: 5,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Classic Brew",
                              maxLines: 1,
                              style: titleFonts(
                                  fontSize: 18, fontWeight: FontWeight.w700),
                            ),
                            const Row(
                              spacing: 4,
                              children: [
                                Icon(Icons.add_business_rounded, size: 17),
                                Text("Caffely Astoria Aromas")
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 8),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColors.primaryColor, width: 2),
                                  borderRadius: BorderRadius.circular(5)),
                              child: const Text(
                                "Pick Up",
                                style: TextStyle(color: AppColors.primaryColor),
                              ),
                            )
                          ],
                        ),
                        const Spacer(),
                        const Icon(Icons.arrow_forward_ios_rounded),
                        width10,
                      ],
                    ),
                  ),
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
