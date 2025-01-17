import 'package:coffee_app/core/app_colors.dart';
import 'package:coffee_app/core/fonts.dart';
import 'package:coffee_app/core/size.dart';
import 'package:coffee_app/features/notification/view_models/notification_view_model.dart';
import 'package:coffee_app/route/navigation_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
          "Notification",
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
                (index) => _notificationWithDate(notificationViewModel, index),
              ),
      ),
    );
  }

  Widget _notificationWithDate(NotificationStateModel viewModel, int index) {
    if (viewModel.notifications == null) return const SizedBox();
    final group = viewModel.notifications!.keys.toList()[index];
    final notifications = viewModel.notifications![group]!;
    final size = MediaQuery.sizeOf(context);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Text(
              group,
              style: subtitleFont(fontWeight: FontWeight.w300),
            ),
          ),
          SizedBox(
              width: size.width * 0.6, child: const Divider(thickness: 0.1))
        ],
      ),
      ...List.generate(
          notifications.length,
          (index) => Padding(
                padding:
                    const EdgeInsets.only(bottom: 8, right: 2, left: 8, top: 8),
                child: ListTile(
                  title: Text(
                    notifications[index].title,
                    style: subtitleFont(
                        fontWeight: FontWeight.w700,
                        fontSize: 17,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white70
                            : Colors.black87),
                  ),
                  trailing: notifications[index].isRead
                      ? const Icon(Icons.arrow_forward_ios_rounded)
                      : const SizedBox(
                          width: 48,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircleAvatar(
                                  radius: 6,
                                  backgroundColor: AppColors.primaryColor),
                              width10,
                              Icon(Icons.arrow_forward_ios_rounded),
                            ],
                          ),
                        ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (notifications[index].subtitle != null)
                        Text(notifications[index].subtitle!,
                            style: subtitleFont())
                      else
                        height10,
                      Text(notifications[index].postTime,
                          style: subtitleFont(fontWeight: FontWeight.w300)),
                    ],
                  ),
                  leading: notifications[index].imageUrl == null
                      ? Container(
                          width: 60,
                          height: 100,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.secondaryColor(context)),
                          child: Icon(
                              IconData(
                                  int.parse(notifications[index].infoIcon!),
                                  fontFamily: 'MaterialIcons'),
                              size: 30),
                        )
                      : Container(
                          width: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.secondaryColor(context),
                              image: DecorationImage(
                                  image: AssetImage(
                                      notifications[index].imageUrl!),
                                  fit: BoxFit.fill)),
                        ),
                ),
              )),
    ]);
  }
}
