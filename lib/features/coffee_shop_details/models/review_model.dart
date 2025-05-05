import 'package:intl/intl.dart';

class ReviewModel {
  final String name;
  final String imageUrl;
  final String review;
  final double rating;
  final String date;
  final String shopID;

  ReviewModel({
    required this.name,
    required this.imageUrl,
    required this.review,
    required this.rating,
    required this.date,
    required this.shopID,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json, date) {
    return ReviewModel(
      name: json['username'],
      imageUrl: json['image'] ?? "",
      review: json['review'],
      rating: json['rating'],
      date: date,
      shopID: json["shop-id"],
    );
  }
}
