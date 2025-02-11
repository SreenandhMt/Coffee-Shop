class AddressModel {
  final String title;
  final String name;
  final String phoneNumber;
  final String address;
  final bool isSelected;
  final String? note;
  final String id;
  final String uid;

  AddressModel({
    required this.title,
    required this.name,
    required this.phoneNumber,
    required this.address,
    this.isSelected = false,
    this.note,
    required this.id,
    required this.uid,
  });
  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      title: json['title'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
      isSelected: json['isSelected'],
      id: json['id'],
      uid: json['uid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'name': name,
      'phoneNumber': phoneNumber,
      'address': address,
      'isSelected': isSelected,
      'id': id,
      "uid": uid,
    };
  }

  AddressModel copyWith({
    String? title,
    String? name,
    String? phoneNumber,
    String? address,
    bool? isSelected,
  }) {
    return AddressModel(
      title: title ?? this.title,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      isSelected: isSelected ?? this.isSelected,
      uid: uid,
      id: id,
    );
  }
}
