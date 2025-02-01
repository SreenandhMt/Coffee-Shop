import '/core/app_colors.dart';
import 'package:flutter/material.dart';

import '../../core/size.dart';
import '../../features/coffee_shop_details/models/review_model.dart';

class ReviewWidget extends StatelessWidget {
  const ReviewWidget({
    super.key,
    required this.review,
  });
  final ReviewModel review;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              width10,
              CircleAvatar(
                  backgroundImage: review.imageUrl.isEmpty
                      ? null
                      : NetworkImage(review.imageUrl),
                  backgroundColor: AppColors.secondaryColor(context)),
              width10,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    review.name,
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.w700),
                  ),
                  const Text("5 days ago"),
                ],
              ),
              const Spacer(),
              Icon(
                  review.rating >= 1
                      ? Icons.star
                      : review.rating >= 0.5
                          ? Icons.star_half
                          : Icons.star_border,
                  color: Colors.orange),
              Icon(
                  review.rating >= 2
                      ? Icons.star
                      : review.rating >= 1.5
                          ? Icons.star_half
                          : Icons.star_border,
                  color: Colors.orange),
              Icon(
                  review.rating >= 3
                      ? Icons.star
                      : review.rating >= 2.5
                          ? Icons.star_half
                          : Icons.star_border,
                  color: Colors.orange),
              Icon(
                  review.rating >= 4
                      ? Icons.star
                      : review.rating >= 3.5
                          ? Icons.star_half
                          : Icons.star_border,
                  color: Colors.orange),
              Icon(
                  review.rating >= 5
                      ? Icons.star
                      : review.rating >= 4.5
                          ? Icons.star_half
                          : Icons.star_border,
                  color: Colors.orange),
              width5,
              const Icon(Icons.more_vert_outlined),
              width10,
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 15, bottom: 15),
          child: Text(
            review.review,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
