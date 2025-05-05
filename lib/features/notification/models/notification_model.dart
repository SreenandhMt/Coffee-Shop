class NotificationModel {
  final String title;
  final String? subtitle;
  final String? imageUrl;
  final String postTime;
  final bool isRead;
  final String date;
  final bool? isInfo;
  final String? infoIcon;

  NotificationModel({
    required this.title,
    this.subtitle,
    this.imageUrl,
    required this.postTime,
    required this.isRead,
    required this.date,
    this.isInfo,
    this.infoIcon,
  });

  factory NotificationModel.formJson(Map<String, dynamic> json) {
    return NotificationModel(
      title: json['title'],
      subtitle: json['subtitle'],
      imageUrl: json['imageUrl'],
      postTime: json['time'],
      isRead: json['isRead'],
      isInfo: json['isInfo'],
      infoIcon: json['infoIcon'],
      date: json['date'],
    );
  }
}
