import 'package:coffee_app/core/loading_widget.dart';
import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/size.dart';

class HomeLoading extends StatelessWidget {
  const HomeLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return ListView(
      children: [
        //*banner
        LimitedBox(
          maxHeight: size.width * 0.6,
          child: const Padding(
            padding: EdgeInsets.all(20),
            child: Skelton(
              height: 200,
              width: double.infinity,
            ),
          ),
        ),
        Row(
          children: [
            width20,
            Skelton(
              width: size.width * 0.4,
              height: 20,
            ),
            const Spacer(),
            Skelton(
              width: size.width * 0.2,
              height: 20,
              color: AppColors.primaryColor,
            ),
            width20,
          ],
        ),
        height10,
        LimitedBox(
            maxHeight: size.width * 0.6,
            maxWidth: size.width,
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.only(left: 10),
              scrollDirection: Axis.horizontal,
              children: List.generate(4, (index) => const ShopWidget()),
            )),
        height10,
        Row(
          children: [
            width20,
            Skelton(
              width: size.width * 0.4,
              height: 20,
            ),
            const Spacer(),
            Skelton(
              width: size.width * 0.2,
              height: 20,
              color: AppColors.primaryColor,
            ),
            width20,
          ],
        ),
        height20,
        GridView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.only(left: 5),
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 1 / 1.25),
            itemBuilder: (context, index) => Column(
                  children: [
                    Skelton(
                        width: size.width * 0.45, height: size.width * 0.41),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 3, vertical: 8.0),
                      child: SizedBox(
                        width: size.width * 0.45,
                        // height: size.width * 0.2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Skelton(width: size.width * 0.45, height: 30),
                            height5,
                            Row(
                              children: [
                                Skelton(width: size.width * 0.3, height: 25),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
            itemCount: 6),
      ],
    );
  }
}

class ShopWidget extends StatelessWidget {
  const ShopWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Column(
        children: [
          Skelton(
            width: size.width * 0.38,
            height: size.width * 0.37,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 8.0),
            child: SizedBox(
              width: size.width * 0.36,
              // height: size.width * 0.2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Skelton(width: size.width * 0.36, height: 25),
                  height5,
                  Row(
                    children: [
                      Skelton(width: size.width * 0.1, height: 20),
                      width5,
                      Skelton(width: size.width * 0.20, height: 20),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
