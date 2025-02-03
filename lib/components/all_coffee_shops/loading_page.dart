import 'package:coffee_app/core/loading_widget.dart';
import 'package:coffee_app/core/size.dart';
import 'package:flutter/material.dart';

class AllCoffeeShopLoadingPage extends StatelessWidget {
  const AllCoffeeShopLoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      children: List.generate(
        10,
        (index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              width5,
              Skelton(
                height: size.width * 0.27,
                width: size.width * 0.27,
              ),
              width10,
              Column(
                spacing: 1,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Skelton(width: size.width * 0.59, height: 30),
                  height10,
                  Skelton(width: size.width * 0.56, height: 26),
                  height10,
                  Row(
                    children: [
                      Skelton(
                        width: size.width * 0.20,
                        height: 22,
                        color: Colors.yellow,
                      ),
                      width10,
                      Skelton(
                        width: size.width * 0.27,
                        height: 22,
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
