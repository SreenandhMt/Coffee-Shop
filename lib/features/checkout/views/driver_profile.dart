import 'dart:developer';

import 'package:coffee_app/core/app_colors.dart';
import 'package:coffee_app/core/fonts.dart';
import 'package:coffee_app/core/size.dart';
import 'package:coffee_app/features/auth/views/forgot_password/email_conform_page.dart';
import 'package:coffee_app/features/auth/views/signin_page.dart';
import 'package:coffee_app/route/navigation_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DriverProfilePage extends StatefulWidget {
  const DriverProfilePage({super.key});

  @override
  State<DriverProfilePage> createState() => _DriverProfilePageState();
}

class _DriverProfilePageState extends State<DriverProfilePage> {
  final scaffoldState = GlobalKey<ScaffoldState>();
  double profileSize = 350.0;
  bool isDriverArrived = false, shopDialog = false;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 10), () {
      if (!mounted || shopDialog) return;
      showDialog(
        context: context,
        builder: (context) => DialogBox(
          icon: Icons.check_box_rounded,
          title: "Driver Has Arrived",
          subtitle: "The driver has arrived and brougth your orders",
          child: Column(
            children: [
              height20,
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          fixedSize: const Size(double.infinity, 60)),
                      onPressed: () {
                        if (!mounted) return;
                        if (context.canPop()) context.pop();
                        if (context.canPop()) context.pop();
                        NavigationUtils.rewardPintDriverPage(context);
                        isDriverArrived = true;
                      },
                      child: const Text("OK",
                          style: TextStyle(color: Colors.white, fontSize: 17)),
                    ),
                  ),
                ],
              ),
              height10,
            ],
          ),
        ),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // double profileSize = 500.0;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldState,
      // appBar: AppBar(),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          if (profileSize <= 350) ...[
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.paddingOf(context).top, left: 10),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () => context.pop(),
                      padding: const EdgeInsets.all(10),
                      style: ButtonStyle(
                          shadowColor:
                              const WidgetStatePropertyAll(Colors.transparent),
                          backgroundColor: WidgetStatePropertyAll(
                              Colors.greenAccent.withOpacity(0.4))),
                      icon: const Icon(Icons.arrow_back_ios_new_rounded))
                ],
              ),
            )
          ],
          const Spacer(),
          Container(
            height: profileSize,
            width: size.width,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    margin: const EdgeInsets.only(top: 3),
                    width: 70,
                    height: 1,
                    color: Colors.black),
                Padding(
                  padding: EdgeInsets.only(
                      top: profileSize > 350 ? 20 : 10, left: 10),
                  child: Row(
                    children: [
                      if (profileSize > 350)
                        IconButton(
                            onPressed: () => setState(() {
                                  profileSize = 350;
                                }),
                            icon: const Icon(Icons.arrow_back))
                      else
                        const Spacer(),
                      Draggable(
                          feedback: Container(
                            width: profileSize <= 350
                                ? size.width * 0.9
                                : size.width * 0.7,
                            height: 50,
                            color: Colors.transparent,
                          ),
                          onDraggableCanceled: (velocity, offset) {},
                          onDragEnd: (details) {
                            if (profileSize <= 350) {
                            } else if (profileSize >= 380) {
                              profileSize = size.height * 0.99;
                            }
                            setState(() {});
                          },
                          onDragUpdate: (details) {
                            if (profileSize < 350 && details.delta.dy > 0) {
                              return;
                            }
                            if (profileSize >= size.height * 0.99) return;
                            if (details.delta.distance >= 65) return;
                            if (details.delta.dy > 0) {
                              profileSize =
                                  profileSize - details.delta.distance;
                            } else if (profileSize < size.height * 0.99) {
                              profileSize =
                                  profileSize + details.delta.distance;
                            }
                            setState(() {});
                          },
                          child: Container(
                            width: profileSize <= 350
                                ? size.width * 0.9
                                : size.width * 0.7,
                            height: 40,
                            color: Colors.transparent,
                            alignment: Alignment.center,
                            child: profileSize <= 350
                                ? null
                                : Text("Driver Information",
                                    style: appBarTitleFont),
                          )),
                      const Spacer(),
                    ],
                  ),
                ),
                if (profileSize <= size.height * 0.8) ...[
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                    child: Column(
                      spacing: 15,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Driver is heading to the Coffee Shop...",
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 18),
                        ),
                        const Divider(thickness: 0.2),
                        InkWell(
                          onTap: () {},
                          child: const Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 25,
                              ),
                              width10,
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Rayford Chenial",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text("Yamaha MX King"),
                                ],
                              ),
                              Spacer(),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "4.8",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Icon(
                                        Icons.star_half_rounded,
                                        color: Colors.amber,
                                      )
                                    ],
                                  ),
                                  Text("HSW 4736 XK")
                                ],
                              )
                            ],
                          ),
                        ),
                        const Divider(thickness: 0.2),
                        _moreOptions()
                      ],
                    ),
                  )
                ] else ...[
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      spacing: 15,
                      children: [
                        const CircleAvatar(radius: 50),
                        Text("Rayford Chenail", style: appBarTitleFont),
                        const Text("+1-202-555-0161"),
                        Container(
                          padding: const EdgeInsets.all(15),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(width: 0.4)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Icon(
                                    Icons.star_border_rounded,
                                    size: 40,
                                    color: Colors.grey.shade800,
                                  ),
                                  height10,
                                  const Text(
                                    "4.9",
                                    style: TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  const Text("Rating")
                                ],
                              ),
                              Column(
                                children: [
                                  Icon(
                                    Icons.shopping_bag_outlined,
                                    color: Colors.grey.shade800,
                                    size: 40,
                                  ),
                                  height10,
                                  const Text(
                                    "627",
                                    style: TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  const Text("Orders")
                                ],
                              ),
                              Column(
                                children: [
                                  Icon(Icons.timer_outlined,
                                      size: 40, color: Colors.grey.shade800),
                                  height10,
                                  const Text(
                                    "5",
                                    style: TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  const Text("Years")
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(15),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(width: 0.4)),
                          child: Column(
                            spacing: 15,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Member Since",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.grey.shade700),
                                  ),
                                  const Spacer(),
                                  const Text("July 25, 2020",
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700))
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Motorcycle Model",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.grey.shade700),
                                  ),
                                  const Spacer(),
                                  const Text("Yamaha MX King",
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700))
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Plate Number",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.grey.shade700),
                                  ),
                                  const Spacer(),
                                  const Text("HSW 4736 XK",
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700))
                                ],
                              )
                            ],
                          ),
                        ),
                        _moreOptions()
                      ],
                    ),
                  )
                ]
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _moreOptions() {
    return Row(
      spacing: 20,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            NavigationUtils.cancelOrderPage(context);
            shopDialog = true;
          },
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 3, color: Colors.red)),
            child: const Icon(
              Icons.close,
              size: 30,
              color: Colors.red,
            ),
          ),
        ),
        InkWell(
          onTap: () => NavigationUtils.chatDriverPage(context),
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 3, color: Colors.green)),
            child: const Icon(
              CupertinoIcons.chat_bubble_text_fill,
              size: 30,
              color: Colors.green,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(width: 3, color: Colors.green)),
          child: const Icon(
            Icons.call,
            size: 30,
            color: Colors.green,
          ),
        ),
        if (isDriverArrived)
          InkWell(
            onTap: () {
              context.pop();
              NavigationUtils.rewardPintDriverPage(context);
            },
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 3, color: Colors.red)),
              child: const Icon(
                Icons.navigate_next_rounded,
                size: 30,
                color: Colors.red,
              ),
            ),
          ),
      ],
    );
  }
}
