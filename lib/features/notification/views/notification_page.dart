import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/core/fonts.dart';
import '/features/notification/view_models/notification_view_model.dart';
import '/localization/locales.dart';
import '/route/navigation_utils.dart';

import '../../../components/notification/notification_widget.dart';

class NotificationPage extends ConsumerStatefulWidget {
  const NotificationPage({super.key});

  @override
  ConsumerState<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends ConsumerState<NotificationPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) =>
        ref.read(notificationViewModelProvider.notifier).getNotifications());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final notificationViewModel = ref.watch(notificationViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          LocaleData.notificationTitle.getString(context),
          style: appBarTitleFont,
        ),
        actions: [
          IconButton(
              onPressed: () => NavigationUtils.notificationSettingPage(context),
              icon: const Icon(Icons.settings))
        ],
      ),
      body: ListView(
        children: notificationViewModel.notifications == null
            ? List.empty()
            : List.generate(
                notificationViewModel.notifications!.keys.toList().length,
                (index) => NotificationWidget(index: index),
              ),
      ),
    );
  }
}
