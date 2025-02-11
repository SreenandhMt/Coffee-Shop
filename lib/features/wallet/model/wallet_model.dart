class TransactionHistoryModel {
  final String name;
  final dynamic date;
  final String amount;
  final String paymentMethod;
  final String status;

  TransactionHistoryModel({
    required this.name,
    required this.date,
    required this.amount,
    required this.paymentMethod,
    required this.status,
  });

  factory TransactionHistoryModel.fromJson(Map<String, dynamic> json) {
    return TransactionHistoryModel(
      name: json['name'],
      date: json['date'],
      amount: json['amount'],
      paymentMethod: json['method'],
      status: json['status'],
    );
  }
}
