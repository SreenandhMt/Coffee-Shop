import 'package:coffee_app/features/notification/services/notification_service.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import 'package:coffee_app/features/notification/models/notification_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_view_model.g.dart';

class NotificationStateModel {
  final bool loading;
  final Map<String, List<NotificationModel>>? notifications;

  NotificationStateModel({
    required this.loading,
    required this.notifications,
  });

  factory NotificationStateModel.initial() {
    return NotificationStateModel(
      loading: false,
      notifications: null,
    );
  }

  NotificationStateModel copyWith({
    bool? loading,
    Map<String, List<NotificationModel>>? notifications,
  }) {
    return NotificationStateModel(
      loading: loading ?? this.loading,
      notifications: notifications ?? this.notifications,
    );
  }
}

@riverpod
class NotificationViewModel extends _$NotificationViewModel {
  @override
  NotificationStateModel build() {
    return NotificationStateModel.initial();
  }

  Future<void> getNotifications({bool loading = true}) async {
    state = state.copyWith(loading: loading);
    Map<String, List<NotificationModel>>? groupNotifications;
    final response = await NotificationService.getNotifications();
    response.fold(
      (l) => debugPrint(l),
      (r) {
        final notifications =
            r.map((e) => NotificationModel.formJson(e)).toList();
        groupNotifications = groupNotificationsByDate(notifications);
        state = state.copyWith(
          loading: false,
          notifications: groupNotifications,
        );
      },
    );
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

class NotificationViewModels extends ChangeNotifier {
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

    // setNotifications(groupNotifications);
    // log(notifications.toString());

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
