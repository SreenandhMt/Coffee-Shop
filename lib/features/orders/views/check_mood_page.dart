import 'package:coffee_app/core/app_colors.dart';
import 'package:coffee_app/core/size.dart';
import 'package:coffee_app/features/auth/views/forgot_password/email_conform_page.dart';
import 'package:coffee_app/route/navigation_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CheckUserMoodPage extends StatefulWidget {
  const CheckUserMoodPage({super.key});

  @override
  State<CheckUserMoodPage> createState() => _CheckUserMoodPageState();
}

class _CheckUserMoodPageState extends State<CheckUserMoodPage> {
  List<String> emojis = [
    "😍",
    "😃",
    "😎",
    "😆",
    "😖",
    "😶",
    "🥲",
    "😵‍💫",
    "😭",
    "😌",
    "😟",
    "😡",
    "🥴",
    "🤢",
    "🤮",
    "🤧",
    "🥺",
    "🤕"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const Text(
            "What's Your Mood!",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
          ),
          const Text("about this order?"),
          height20,
          Expanded(
            child: SingleChildScrollView(
              child: Wrap(
                runSpacing: 10,
                spacing: 15,
                alignment: WrapAlignment.spaceBetween,
                children: List.generate(
                  emojis.length,
                  (index) => Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: index != 1
                            ? null
                            : Border.all(
                                width: 4, color: AppColors.primaryColor),
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      emojis[index],
                      style: const TextStyle(fontSize: 80),
                    ),
                  ),
                ),
              ),
            ),
          ),
          height10,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor.withOpacity(0.2),
                  shadowColor: Colors.transparent,
                  fixedSize:
                      Size((MediaQuery.sizeOf(context).width / 2) * 0.9, 60),
                ),
                onPressed: () {
                  NavigationUtils.ratingDriverPage(context);
                },
                child: const Text("Cancel",
                    style:
                        TextStyle(color: AppColors.primaryColor, fontSize: 17)),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  fixedSize:
                      Size((MediaQuery.sizeOf(context).width / 2) * 0.9, 60),
                ),
                onPressed: () {
                  NavigationUtils.ratingDriverPage(context);
                },
                child: const Text("Submit",
                    style: TextStyle(color: Colors.white, fontSize: 17)),
              ),
            ],
          ),
          height10,
        ],
      ),
    );
  }
}
