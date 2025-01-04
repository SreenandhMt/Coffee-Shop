import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:coffee_app/core/app_colors.dart';

PageController controller = PageController();
final List<Map<String, String>> contents = [
  {
    "title": "Get Your Coffee - Anytime, Anywhere",
    "description": "Choose the way you want to enjoy your coffee with Caffely. Just a few taps on the app, and your coffee is ready for you."
  },
  {
    "title": "Seamless Payments with Our Secure Wallet", 
    "description": "Say goodbye to hassle and hello to seamless transactions with Caffely's secure wallet. Making payments has never been easier."
  },
  {
    "title": "Explore the World of Coffee Right Now",
    "description": "Dive into the fascinating world of coffee with Caffely. Discover unique and delightful coffee flavors, one sip at a time"
  }
];

class IntroductionPage extends StatefulWidget {
  const IntroductionPage({super.key});

  @override
  State<IntroductionPage> createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
          controller: controller,
          physics: const NeverScrollableScrollPhysics(),
          children: List.generate(contents.length, (index) => IntroWidget(title: contents[index]["title"]!,subtitle: contents[index]["description"]!,index: index),)),
    );
  }
}

class IntroWidget extends StatefulWidget {
  const IntroWidget({super.key, required this.title, required this.subtitle, required this.index});
  final String title;
  final String subtitle;
  final int index;

  @override
  State<IntroWidget> createState() => IntroWidgetState();
}

class IntroWidgetState extends State<IntroWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Column(
      children: [
        ClipPath(
          clipper: CustomCurveClipPath(),
          child: Container(
            width: double.infinity,
            height: size.height * 0.55,
            decoration: const BoxDecoration(color: AppColors.primaryColor),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20,right: 20,top: 10),
          child: Text(widget.title,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 30),
              textAlign: TextAlign.center),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            widget.subtitle,
            style: const TextStyle(fontWeight: FontWeight.w200, fontSize: 17),
            textAlign: TextAlign.center,
          ),
        ),
        const Spacer(),
        SmoothIndicator(controller: controller,count: 3),
        const Spacer(),
        if(widget.index != 2)
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                controller.jumpToPage(2);
              },
              style: ButtonStyle(
                fixedSize:
                    WidgetStatePropertyAll(Size((size.width / 2) * 0.9, 65)),
                shadowColor: WidgetStateColor.transparent,
                backgroundColor: WidgetStatePropertyAll(
                    AppColors.primaryColor.withOpacity(0.1)),
              ),
              child: const Text(
                'Skip',
                style: TextStyle(color: AppColors.primaryColor, fontSize: 15),
              ),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                controller.nextPage(
                    duration: const Duration(milliseconds: 10), curve: Curves.ease);
              },
              style: ButtonStyle(
                fixedSize:
                    WidgetStatePropertyAll(Size((size.width / 2) * 0.9, 65)),
                shadowColor: WidgetStateColor.transparent,
                backgroundColor:
                    const WidgetStatePropertyAll(AppColors.primaryColor),
              ),
              child: const Text('Continue',
                  style: TextStyle(color: Colors.white, fontSize: 15)),
            ),
          ],
        )
        else
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                context.go("/welcome");
              },
              style: ButtonStyle(
                fixedSize: WidgetStatePropertyAll(Size(size.width * 0.9, 65)),
                shadowColor: WidgetStateColor.transparent,
                backgroundColor:
                    const WidgetStatePropertyAll(AppColors.primaryColor),
              ),
              child: const Text('Get Start',
                  style: TextStyle(color: Colors.white, fontSize: 15)),
            ),
          ],
        ),
        const Spacer(),
      ],
    );
  }
}

class SmoothIndicator extends StatefulWidget {
  const SmoothIndicator({
    Key? key,
    required this.controller,
    required this.count,
  }) : super(key: key);
  final PageController controller;
  final int count;

  @override
  State<SmoothIndicator> createState() => SmoothIndicatorState();
}

class SmoothIndicatorState extends State<SmoothIndicator> {
  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
          controller: widget.controller,
          count: widget.count,
          axisDirection: Axis.horizontal,
          effect: ExpandingDotsEffect(
              dotHeight: 10,
              dotWidth: 10,
              dotColor: AppColors.secondaryColor(context),
              activeDotColor: AppColors.primaryColor),
        );
  }
}

class CustomCurveClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 66);
    path.cubicTo(
      size.width * 0.25,
      size.height,
      size.width * 0.75,
      size.height,
      size.width,
      size.height - 66,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
