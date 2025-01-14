import 'package:action_slider/action_slider.dart';
import 'package:coffee_app/core/app_colors.dart';
import 'package:coffee_app/core/fonts.dart';
import 'package:coffee_app/core/size.dart';
import 'package:coffee_app/route/navigation_utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SearchingDriverPage extends StatefulWidget {
  const SearchingDriverPage({super.key});

  @override
  State<SearchingDriverPage> createState() => _SearchingDriverPageState();
}

class _SearchingDriverPageState extends State<SearchingDriverPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 5), () {
      if (!mounted) return;
      context.pop();
      NavigationUtils.driverProfilePage(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Searching Driver", style: appBarTitleFont),
      ),
      body: Column(
        spacing: 5,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.delivery_dining_rounded,
            size: 100,
            color: AppColors.primaryColor,
          ),
          const Text(
            "Finding you a nearby drivers",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
          ),
          const Text("This may take a few seconds..."),
          const Expanded(child: SizedBox()),
          CircleAvatar(
            radius: 150,
            backgroundColor: AppColors.primaryColor.withOpacity(0.2),
            child: CircleAvatar(
              radius: 120,
              backgroundColor: AppColors.primaryColor.withOpacity(0.3),
              child: CircleAvatar(
                radius: 80,
                backgroundColor: AppColors.primaryColor.withOpacity(0.5),
                child: CircleAvatar(
                    radius: 50, backgroundColor: AppColors.themeColor(context)),
              ),
            ),
          ),
          const Expanded(child: SizedBox()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ActionSlider.standard(
                width: MediaQuery.of(context).size.width * 0.55,
                height: 50,
                rolling: true,
                icon: const Icon(Icons.close),
                backgroundColor: Colors.transparent,
                borderWidth: 0,
                boxShadow: const [],
                toggleColor: Colors.red,
                child: const Text(
                  '>> Slide to Cancel',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                action: (controller) async {
                  controller.loading(); //starts loading animation
                  await Future.delayed(const Duration(seconds: 1));
                  controller.success(); //starts success animation
                  if (!mounted) context.pop();
                },
              ),
            ],
          ),
          height30,
        ],
      ),
    );
  }
}
