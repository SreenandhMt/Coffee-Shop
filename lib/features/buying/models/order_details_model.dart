import 'package:coffee_app/features/home/models/coffee_model.dart';

class OrderDetailsModel {
  final int quantity;
  final double totalPrice;
  final double basePrice;
  final double? selectMilkPrice;
  final String? selectMilkName;
  final double? selectSyrupPrice;
  final String? selectSyrupName;
  final double? selectToppingsPrice;
  final String? selectToppingsName;
  final double? selectSizePrice;
  final String? selectSizeName;
  final String? type;
  final String? note;
  CoffeeModel productModel;

  OrderDetailsModel({
    required this.quantity,
    required this.totalPrice,
    required this.basePrice,
    this.selectMilkPrice,
    this.selectMilkName,
    this.selectSyrupPrice,
    this.selectSyrupName,
    this.selectToppingsPrice,
    this.selectToppingsName,
    this.selectSizePrice,
    this.selectSizeName,
    this.type,
    this.note,
    required this.productModel,
  });

  factory OrderDetailsModel.fromJson(
      Map<String, dynamic> json, CoffeeModel coffeeModel) {
    return OrderDetailsModel(
      quantity: json['quantity'],
      totalPrice: json['totalPrice'],
      basePrice: json['basePrice'],
      selectMilkPrice: json['milkPrice'],
      selectMilkName: json['milkName'],
      selectSyrupPrice: json['syrupPrice'],
      selectSyrupName: json['syrupName'],
      selectToppingsPrice: json['toppingPrice'],
      selectToppingsName: json['toppingName'],
      selectSizePrice: json['sizePrice'],
      selectSizeName: json['sizeName'],
      note: json['note'],
      productModel: coffeeModel,
      type: json['type'],
    );
  }
}
