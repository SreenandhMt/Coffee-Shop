import 'package:coffee_app/core/loading_widget.dart';
import 'package:flutter/material.dart';

class NotificationLoading extends StatelessWidget {
  const NotificationLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => const Padding(
        padding: EdgeInsets.all(8.0),
        child: ListTile(
          leading: Skelton(width: 60, height: null),
          title: Padding(
            padding: EdgeInsets.all(8.0),
            child: Skelton(width: 100, height: 35),
          ),
          subtitle: Padding(
            padding: EdgeInsets.only(top: 5, bottom: 5, right: 40, left: 8),
            child: Skelton(width: 200, height: 30),
          ),
        ),
      ),
      itemCount: 10,
    );
  }
}
