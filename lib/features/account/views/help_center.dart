import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:coffee_app/core/app_colors.dart';
import 'package:coffee_app/core/fonts.dart';
import 'package:coffee_app/core/size.dart';

class HelpCenterPage extends StatefulWidget {
  const HelpCenterPage({super.key});

  @override
  State<HelpCenterPage> createState() => _HelpCenterPageState();
}

class _HelpCenterPageState extends State<HelpCenterPage> {
  List<String> helpCenterType = [
    "General",
    "Account",
    "Orders",
    "Coffee",
    "Tea",
    "Milk",
    "Juice",
    "Water",
  ];

  List<String> generalHelps = [
    "What is Caffely?",
    "Where is Caffely location?",
    "What type of coffee Caffely serve?",
    "Can i customize my coffee order?",
    "Is Wi-Fi available in Caffely shop?",
    "Do Caffely have a loyalty program?"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Help Center",
          style: appBarTitleFont,
        ),
      ),
      body: ListView(
        children: [
          LimitedBox(
            maxHeight: 55,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              scrollDirection: Axis.horizontal,
              itemCount: helpCenterType.length,
              itemBuilder: (context, index) => Container(
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 3),
                alignment: Alignment.center,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.grey),
                    color: index == 0 ? AppColors.primaryColor : null),
                child: Text(
                  helpCenterType[index],
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: index == 0 ? Colors.white : null),
                ),
              ),
            ),
          ),
          height5,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: TextFormField(
              decoration: InputDecoration(
                  hintText: "Search",
                  hintStyle: const TextStyle(color: Colors.grey),
                  prefixIcon:
                      const Icon(CupertinoIcons.search, color: Colors.grey),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none),
                  filled: true,
                  fillColor:
                      AppColors.secondaryColor(context).withOpacity(0.3)),
            ),
          ),
          height10,
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => HelpCenterDetailsWidget(
                  title: generalHelps[index], index: index),
              itemCount: generalHelps.length)
        ],
      ),
    );
  }
}

class HelpCenterDetailsWidget extends StatefulWidget {
  const HelpCenterDetailsWidget({
    super.key,
    required this.title,
    required this.index,
  });
  final String title;
  final int index;

  @override
  State<HelpCenterDetailsWidget> createState() =>
      _HelpCenterDetailsWidgetState();
}

class _HelpCenterDetailsWidgetState extends State<HelpCenterDetailsWidget> {
  late bool isExpanded;

  @override
  void initState() {
    isExpanded = widget.index == 0 ? true : false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 0.25),
          borderRadius: BorderRadius.circular(15)),
      width: double.infinity,
      child: Column(
        spacing: 10,
        children: [
          Row(
            children: [
              Text(
                widget.title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                  icon: Icon(!isExpanded
                      ? Icons.keyboard_arrow_down_rounded
                      : Icons.keyboard_arrow_up_rounded))
            ],
          ),
          if (isExpanded) ...[
            const Divider(
              thickness: 0.2,
            ),
            Text(
              "Caffely is a vibrant coffee destination dedicated to crafting exceptional coffee experiences. We offer a wide range of premium coffee blends, beverages, and treats. all prepared with passion and expertise.",
              style: subtitleFont(fontSize: 15, fontWeight: FontWeight.w500),
            )
          ]
        ],
      ),
    );
  }
}
