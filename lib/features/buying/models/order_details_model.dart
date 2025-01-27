import 'package:coffee_app/features/home/models/coffee_model.dart';

class BasketProductModel {
  final int quantity;
  final double totalPrice;
  final double basePrice;
  final double? selectSizePrice;
  final String? selectSizeName;
  final List<Map<String, dynamic>> selectedOption;
  final String? type;
  final String? note;
  final String shopID;
  final Map<String, dynamic> map;
  CoffeeModel productModel;

  BasketProductModel({
    required this.quantity,
    required this.totalPrice,
    required this.basePrice,
    this.selectSizePrice,
    this.selectSizeName,
    required this.selectedOption,
    this.type,
    this.note,
    required this.shopID,
    required this.map,
    required this.productModel,
  });

  factory BasketProductModel.fromJson(
      Map<String, dynamic> json, CoffeeModel coffeeModel) {
    json.addEntries({"shop-id": coffeeModel.shopId}.entries);
    List<Map<String, dynamic>> mapList = [];
    if (json['option'] != null) {
      json['option'].forEach(
        (item) {
          if (item is Map<String, dynamic>) {
            mapList.add(item);
          } else {}
        },
      );
    }
    return BasketProductModel(
      quantity: json['quantity'],
      totalPrice: json['totalPrice'],
      basePrice: json['basePrice'],
      selectedOption: mapList,
      selectSizePrice: json['sizePrice'],
      selectSizeName: json['sizeName'],
      note: json['note'],
      productModel: coffeeModel,
      type: json['type'],
      map: json,
      shopID: json["shop-id"],
    );
  }
}
