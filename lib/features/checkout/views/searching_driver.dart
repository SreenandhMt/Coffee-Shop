import 'package:action_slider/action_slider.dart';
import 'package:coffee_app/core/app_colors.dart';
import 'package:coffee_app/core/fonts.dart';
import 'package:coffee_app/core/size.dart';
import 'package:coffee_app/route/navigation_utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_animations/simple_animations.dart';

class SearchingDriverPage extends StatefulWidget {
  const SearchingDriverPage({super.key});

  @override
  State<SearchingDriverPage> createState() => _SearchingDriverPageState();
}

class _SearchingDriverPageState extends State<SearchingDriverPage>
    with AnimationMixin {
  late Animation<double> size;

  @override
  void initState() {
    size = Tween<double>(begin: 100.0, end: 190.0).animate(controller);
    controller.play();
    controller.loop();
    Future.delayed(const Duration(seconds: 5), () {
      if (!mounted) return;
      context.pop();
      NavigationUtils.driverProfilePage(context, false);
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
            radius: size.value,
            backgroundColor: AppColors.primaryColor.withOpacity(0.2),
            child: CircleAvatar(
              radius: 100,
              backgroundColor: AppColors.primaryColor.withOpacity(0.3),
              child: CircleAvatar(
                radius: 60,
                backgroundColor: AppColors.secondaryColor(context),
                backgroundImage: const NetworkImage(
                    "https://cdn.pixabay.com/photo/2023/02/18/11/00/icon-7797704_640.png"),
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
                  controller.success();
                  await Future.delayed(const Duration(seconds: 1));
                  if (!mounted) return;
                  context.pop();
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
