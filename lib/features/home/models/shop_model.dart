import 'dart:math';

class ShopModel {
  final String name;
  final List<dynamic> images;
  final double rating;
  final String distance;
  final String id;
  final Map<String, dynamic>? about;
  final List<dynamic> types;
  final Map<dynamic, dynamic>? address;
  final Map<String, dynamic> map;
  final List<dynamic> allRating;

  ShopModel({
    required this.name,
    required this.images,
    required this.rating,
    required this.distance,
    required this.id,
    this.about,
    required this.types,
    this.address,
    required this.map,
    required this.allRating,
  });

  factory ShopModel.fromJson(Map<String, dynamic> map) {
    return ShopModel(
      name: map["name"],
      images: map["images"],
      rating: double.parse(map["rating"].toStringAsFixed(1)),
      distance:
          "${(Random().nextDouble() * 9 + 1).toStringAsFixed(1)} km", //TODO: add distance logic here
      id: map["id"].toString(),
      types: map["types"],
      about: map["about"],
      address: map["address"],
      map: map,
      allRating: map["all-rating"],
    );
  }
}
