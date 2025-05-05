import 'package:coffee_app/features/buying/models/order_details_model.dart';

import '../../address/models/address_model.dart';

class OrderModel {
  final String id;
  final String type; // "Pickup" or "Delivery"
  final String? pickupTime; // Optional for "Pickup"
  final String? pickUpDate;
  final String status;
  final String shopId;
  final String shopName;
  final List<String> shopImages;
  final Map<String, dynamic> shopAddress;
  final String productName;
  final String productId;
  final String productImage;
  final String userId;
  final List<String> discounts;
  final bool usePoint;
  final Map<String, dynamic> paymentMethod;
  final String paymentStatus;
  final List<PaymentDetail> paymentDetails;
  final String orderDate;
  final BasketProductModel orderDetails;
  final List<TransactionDetail> transactionDetails;
  final Map<String, dynamic>? deliveryService;
  final AddressModel? address;
  final Map map;

  OrderModel(
      {required this.id,
      required this.type,
      this.pickupTime, // Optional
      required this.status,
      required this.shopId,
      required this.shopName,
      required this.shopImages,
      required this.shopAddress,
      required this.productName,
      required this.productId,
      required this.productImage,
      required this.userId,
      required this.discounts,
      required this.usePoint,
      required this.paymentMethod,
      required this.paymentStatus,
      required this.paymentDetails,
      required this.orderDate,
      required this.orderDetails,
      required this.pickUpDate,
      required this.transactionDetails,
      this.deliveryService, // Optional
      this.address, // Optional
      required this.map});

  factory OrderModel.fromJson(
      Map<String, dynamic> json, BasketProductModel basketMode) {
    return OrderModel(
        id: json['id'],
        type: json['type'],
        pickupTime:
            json['pickup-time'] != null && json['pickup-time'].isNotEmpty
                ? json['pickup-time']
                : null,
        status: json['status'],
        shopId: json['shop-id'],
        shopName: json['shop-name'],
        shopImages: List<String>.from(json['shop-image']),
        shopAddress: json['shop-address'],
        productName: json['product-name'],
        productId: json['product-id'],
        productImage: json['product-image'],
        userId: json['user-id'],
        discounts: List<String>.from(json['discount']),
        usePoint: json['use-point'],
        paymentMethod: Map<String, dynamic>.from(json['payment-method']),
        paymentStatus: json['payment-status'],
        paymentDetails: (json['payment-details'] as List)
            .map((e) => PaymentDetail.fromJson(e))
            .toList(),
        orderDate: json['order-date'].toString(),
        orderDetails: basketMode,
        transactionDetails: (json['transaction-details'] as List)
            .map((e) => TransactionDetail.fromJson(e))
            .toList(),
        deliveryService: json['delivery-service'],
        pickUpDate: json["pickup-date"],
        address: json['address'] == null
            ? null
            : AddressModel.fromJson(json['address']),
        map: json);
  }
}

class PaymentDetail {
  final String type;
  final double value;

  PaymentDetail({
    required this.type,
    required this.value,
  });

  factory PaymentDetail.fromJson(Map<String, dynamic> json) {
    return PaymentDetail(
      type: json['type'],
      value: double.parse(json['value'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'value': value,
    };
  }
}

class TransactionDetail {
  final String type;
  final dynamic value;

  TransactionDetail({
    required this.type,
    required this.value,
  });

  factory TransactionDetail.fromJson(Map<String, dynamic> json) {
    return TransactionDetail(
      type: json['type'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'value': value,
    };
  }
}
