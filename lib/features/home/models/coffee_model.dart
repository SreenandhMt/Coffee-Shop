class CoffeeModel {
  final String name;
  final String price;
  final String imagePath;
  final Map map;
  // final String description;
  final String id;
  final String? shopId;

  const CoffeeModel({
    required this.name,
    required this.price,
    required this.imagePath,
    required this.map,
    required this.id,
    required this.shopId,
  });

  factory CoffeeModel.fromJson(Map<String, dynamic> json) {
    return CoffeeModel(
      name: json['name'],
      price: json['price'],
      imagePath: json['imagePath'],
      map: json,
      // description: json['description'],
      id: json['id'],
      shopId: json['shopId'],
    );
  }
}
