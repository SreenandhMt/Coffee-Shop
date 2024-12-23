class CoffeeModel {
  final String name;
  final String price;
  final String imagePath;
  // final String description;
  // final String id;
  
  const CoffeeModel({
    required this.name,
    required this.price,
    required this.imagePath,
    // required this.description,
    // required this.id,
  });

  factory CoffeeModel.fromJson(Map<String, dynamic> json) {
    return CoffeeModel(
      name: json['name'],
      price: json['price'],
      imagePath: json['imagePath'],
      // description: json['description'],
      // id: json['id'],
    );
  }
}