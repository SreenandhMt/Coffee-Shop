class CoffeeModel {
  final String name;
  final String price;
  final String imagePath;
  final Map<String, dynamic> map;
  // final String description;
  final String id;
  final String shopId;
  final List<Map>? optionList;

  const CoffeeModel({
    required this.name,
    required this.price,
    required this.imagePath,
    required this.map,
    required this.id,
    required this.shopId,
    required this.optionList,
  });

  factory CoffeeModel.fromJson(Map<String, dynamic> json) {
    List<Map> mapList = [];
    json['options'].forEach(
      (item) {
        if (item is Map) {
          mapList.add(item);
        } else {}
      },
    );
    return CoffeeModel(
      name: json['name'],
      price: json['price'],
      imagePath: json['image-url'],
      map: json,
      // description: json['description'],
      optionList: mapList,
      id: json['id'],
      shopId: json['shop-id'],
    );
  }
}
