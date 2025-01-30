import 'package:flutter/material.dart';

class TabbarItem extends StatefulWidget {
  const TabbarItem({
    super.key,
    required this.text,
  });
  final String text;

  @override
  State<TabbarItem> createState() => _TabbarItemState();
}

class _TabbarItemState extends State<TabbarItem> {
  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: Text(
            widget.text,
            maxLines: 1,
          ))
        ],
      ),
    );
  }
}
