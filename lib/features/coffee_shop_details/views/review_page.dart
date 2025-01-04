import 'package:coffee_app/core/app_colors.dart';
import 'package:coffee_app/core/fonts.dart';
import 'package:coffee_app/core/size.dart';
import 'package:flutter/material.dart';

class RatingAndReviews extends StatefulWidget {
  const RatingAndReviews({super.key});

  @override
  State<RatingAndReviews> createState() => _RatingAndReviewsState();
}

class _RatingAndReviewsState extends State<RatingAndReviews> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Rating & Reviews', style: appBarTitleFont),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Column(
                  children: [
                    Text(
                      "4.8",
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.orange),
                        Icon(Icons.star, color: Colors.orange),
                        Icon(Icons.star, color: Colors.orange),
                        Icon(Icons.star, color: Colors.orange),
                        Icon(Icons.star_half, color: Colors.orange),
                      ],
                    ),
                    Text("(2.4k reviews)")
                  ],
                ),
                width5,
                Column(
                  children: [
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 5, bottom: 5),
                          child: Text(
                            "5.",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        LimitedBox(
                          maxWidth: MediaQuery.sizeOf(context).width * 0.6,
                          child: LinearProgressIndicator(
                            value: 0.5,
                            backgroundColor: AppColors.secondaryColor(context),
                            minHeight: 8,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 5, bottom: 5),
                          child: Text(
                            "4.",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        LimitedBox(
                          maxWidth: MediaQuery.sizeOf(context).width * 0.6,
                          child: LinearProgressIndicator(
                            value: 0.5,
                            backgroundColor: AppColors.secondaryColor(context),
                            minHeight: 8,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 5, bottom: 5),
                          child: Text(
                            "3.",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        LimitedBox(
                          maxWidth: MediaQuery.sizeOf(context).width * 0.6,
                          child: LinearProgressIndicator(
                            value: 0.5,
                            backgroundColor: AppColors.secondaryColor(context),
                            minHeight: 8,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 5, bottom: 5),
                          child: Text(
                            "2.",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        LimitedBox(
                          maxWidth: MediaQuery.sizeOf(context).width * 0.6,
                          child: LinearProgressIndicator(
                            value: 0.5,
                            backgroundColor: AppColors.secondaryColor(context),
                            minHeight: 8,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 5, bottom: 5),
                          child: Text(
                            "1.",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        LimitedBox(
                          maxWidth: MediaQuery.sizeOf(context).width * 0.6,
                          child: LinearProgressIndicator(
                            value: 0.5,
                            backgroundColor: AppColors.secondaryColor(context),
                            minHeight: 8,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          // rating end - review start
          height20,
          LimitedBox(
            maxHeight: size.width * 0.1,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              scrollDirection: Axis.horizontal,
              itemCount: 6,
              itemBuilder: (context, index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (index == 0) ...[
                      const Icon(Icons.sort),
                      width5,
                      const Text(
                        "Sort by",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      )
                    ] else ...[
                      const Icon(Icons.star_border_rounded),
                      width5,
                      Text(
                        "$index",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      )
                    ]
                  ],
                ),
              ),
            ),
          ),
          //
          height20,
          ...List.generate(
            5,
            (index) => _reviewWidget(),
          )
        ],
      ),
    );
  }

  _reviewWidget() {
    return const Column(
      children: [
        Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              width10,
              CircleAvatar(),
              width10,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Augustina Midgett",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                  ),
                  Text("5 days ago"),
                ],
              ),
              Spacer(),
              Icon(Icons.star, color: Colors.orange),
              Icon(Icons.star, color: Colors.orange),
              Icon(Icons.star, color: Colors.orange),
              Icon(Icons.star, color: Colors.orange),
              Icon(Icons.star_half, color: Colors.orange),
              width5,
              Icon(Icons.more_vert_outlined),
              width10,
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
