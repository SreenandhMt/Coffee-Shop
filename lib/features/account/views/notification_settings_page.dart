import 'package:coffee_app/localization/locales.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

import '../../../components/account/text_and_switch.dart';
import '../../../core/fonts.dart';

class NotificationSettingsPage extends StatefulWidget {
  const NotificationSettingsPage({super.key});

  @override
  State<NotificationSettingsPage> createState() =>
      _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  List<String> texts = [
    "Order Updates",
    "Exclusive Offers",
    "New Coffee Releases",
    "Nearby Shop Alerts",
    "Reminders for Favorite Orders",
    "Low Balance in Wallet",
    "Upcoming Events",
    "Weather-Based Suggestions",
    "Rate and Review Request",
    "Referral Rewards",
    "Refunds and Cancellation",
    "Coffee Tips and Fun Facts",
    "App Updates",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(LocaleData.accountNotificationTitle.getString(context),
            style: appBarTitleFont),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        itemCount: texts.length,
        itemBuilder: (context, index) => TextWithSwitch(text: texts[index]),
      ),
    );
  }
}
