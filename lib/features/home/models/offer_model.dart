import 'dart:developer';

class OfferModel {
  final String title;
  final String description;
  final String image;
  final dynamic offer;
  final dynamic minPrice;
  final String validDate;
  final String id;
  final List<dynamic> termsAndCondition;
  final String code;

  OfferModel({
    required this.title,
    required this.description,
    required this.image,
    required this.offer,
    required this.minPrice,
    required this.validDate,
    required this.id,
    required this.termsAndCondition,
    required this.code,
  });

  factory OfferModel.fromJson(Map map) {
    log(map.toString());
    return OfferModel(
      title: map['title'],
      description: map['subtitle'],
      image: map['image'],
      offer: map['offer'],
      minPrice: map['min-price'],
      validDate: map['valid-date'],
      id: map['id'] ?? "",
      termsAndCondition: map['terms-condition'],
      code: map['code'],
    );
  }
}
