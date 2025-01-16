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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text(widget.text)],
      ),
    );
  }
}
