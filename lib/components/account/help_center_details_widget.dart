import 'package:flutter/material.dart';

import '../../core/fonts.dart';

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
