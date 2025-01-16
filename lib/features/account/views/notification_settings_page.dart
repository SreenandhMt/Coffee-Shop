import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
        title: Text("Notification", style: appBarTitleFont),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        itemCount: texts.length,
        itemBuilder: (context, index) => TextWithSwitch(text: texts[index]),
      ),
    );
  }
}

class TextWithSwitch extends StatefulWidget {
  const TextWithSwitch({
    super.key,
    required this.text,
  });
  final String text;

  @override
  State<TextWithSwitch> createState() => _TextWithSwitchState();
}

class _TextWithSwitchState extends State<TextWithSwitch> {
  bool value = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.text,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
          ),
          const Spacer(),
          CupertinoSwitch(
            value: value,
            onChanged: (value) {
              setState(() {
                this.value = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
