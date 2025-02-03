import 'package:coffee_app/core/app_colors.dart';
import 'package:coffee_app/core/loading_widget.dart';
import 'package:coffee_app/core/size.dart';
import 'package:flutter/material.dart';

class OrderLoading extends StatelessWidget {
  const OrderLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => const Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: [
            width10,
            Skelton(width: 100, height: 100),
            width10,
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Skelton(width: null, height: 20),
                Padding(
                  padding: EdgeInsets.only(right: 20, top: 5, bottom: 5),
                  child: Skelton(width: null, height: 20),
                ),
                Skelton(
                  width: 70,
                  height: 40,
                  color: AppColors.primaryColor,
                )
              ],
            )),
            width20,
          ],
        ),
      ),
      itemCount: 8,
    );
  }
}
