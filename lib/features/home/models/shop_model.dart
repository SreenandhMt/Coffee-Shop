class ShopModel {
  final String name;
  final String image;
  final String rating;
  final String distance;
  final String id;

  ShopModel({
    required this.name,
    required this.image,
    required this.rating,
    required this.distance,
    required this.id,
  });

  factory ShopModel.fromJson(Map map) {
    return ShopModel(
        name: map["name"],
        image: map["image"],
        rating: map["rating"],
        distance: map["distance"],
        id: map["id"]);
  }
}
