import 'package:flutter/material.dart';

import '../../core/size.dart';

class PointHistoryWidget extends StatelessWidget {
  const PointHistoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 10),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Your Earn Points",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
              ),
              Spacer(),
              Text(
                "+ 25",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
              ),
            ],
          ),
          height5,
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Dec 22, 2023"),
              width5,
              Icon(
                Icons.circle,
                size: 5,
              ),
              width5,
              Text("09:41:23 AM"),
            ],
          ),
          height10,
          Divider(
            thickness: 0.1,
          )
        ],
      ),
    );
  }
}
