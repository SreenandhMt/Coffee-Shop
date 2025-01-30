class AddressModel {
  final String title;
  final String name;
  final String phoneNumber;
  final String address;
  final bool isSelected;
  final Map<String, dynamic> map;

  ///TODO: Add Address formate
  AddressModel({
    required this.title,
    required this.name,
    required this.phoneNumber,
    required this.address,
    this.isSelected = false,
    required this.map,
  });
  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      title: json['title'],
      name: json['name'],
      phoneNumber: json['number'],
      address: json['address'],
      isSelected: json['select'],
      map: json,
    );
  }
}
