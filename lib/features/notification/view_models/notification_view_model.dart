import 'dart:developer';

import 'package:coffee_app/features/notification/models/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationViewModel extends ChangeNotifier {
  bool _loading = false;
  Map<String, List<NotificationModel>>? _notifications;

  bool get loading => _loading;
  Map<String, List<NotificationModel>>? get notifications => _notifications;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  setNotifications(Map<String, List<NotificationModel>> notifications) {
    _notifications = notifications;
  }

  getNotifications() async {
    setLoading(true);
    final notificationJson = [
      {
        "title": "New Update Available",
        "subtitle": "Update Caffely and get a better coffee experience!",
        "date": "2023-08-01",
        "time": "09:40 AM",
        "isRead": false,
        "isInfo": true,
        "infoIcon": "0xef46"
      },
      {
        "title": 'Your order "Classic Brew" is ready to be picked up!',
        "date": "2023-08-01",
        "time": "08:24 AM",
        "isRead": false,
        "isInfo": false,
        "imageUrl": "assets/image1.png"
      },
      {
        "title": "Enable 2-Factor Authentication",
        "subtitle":
            "Use 2-factor authentication for multiple layers of security on your account.",
        "date": "2023-07-31",
        "time": "04:45 PM",
        "isRead": true,
        "isInfo": true,
        "infoIcon": "0xf47d"
      },
      {
        "title": 'Your order "Minty Fresh Brew" is ready to be picked up!',
        "date": "2023-07-31",
        "time": "08:24 AM",
        "isRead": true,
        "isInfo": false,
        "imageUrl": "assets/image2.png"
      },
      {
        "title": "Multiple Payment Updates!",
        "subtitle": "Now you can add a credit card for coffee payments.",
        "date": "2023-07-02",
        "time": "07:06 PM",
        "isRead": true,
        "isInfo": true,
        "infoIcon": "0xf0057"
      },
      {
        "title": "Christmas & New Year Offer!",
        "subtitle":
            "Limited time promo to order your favorite coffee on special and New Year's days",
        "date": "2023-07-02",
        "time": "05:45 PM",
        "isRead": true,
        "isInfo": true,
        "infoIcon": "0xf184"
      },
    ];

    final notifications =
        notificationJson.map((e) => NotificationModel.formJson(e)).toList();
    final groupNotifications = groupNotificationsByDate(notifications);
    setNotifications(groupNotifications);
    log(notifications.toString());

    setLoading(false);
  }

  Map<String, List<NotificationModel>> groupNotificationsByDate(
      List<NotificationModel> notifications) {
    final today = DateTime.now();
    final yesterday = today.subtract(const Duration(days: 1));

    Map<String, List<NotificationModel>> grouped = {
      'Today': [],
      'Yesterday': [],
    };

    for (var notification in notifications) {
      final date = DateTime.parse(notification.date);

      if (date.year == today.year &&
          date.month == today.month &&
          date.day == today.day) {
        grouped['Today']!.add(notification);
      } else if (date.year == yesterday.year &&
          date.month == yesterday.month &&
          date.day == yesterday.day) {
        grouped['Yesterday']!.add(notification);
      } else {
        final formattedDate = DateFormat('MMM dd, yyyy').format(date);
        if (!grouped.containsKey(formattedDate)) {
          grouped[formattedDate] = [];
        }
        grouped[formattedDate]!.add(notification);
      }
    }

    grouped.removeWhere((key, value) => value.isEmpty);

    return grouped;
  }
}
