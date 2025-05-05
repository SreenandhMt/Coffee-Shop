import 'package:coffee_app/core/loading_widget.dart';
import 'package:flutter/material.dart';

class WalletLoadingPage extends StatelessWidget {
  const WalletLoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const Padding(
          padding: EdgeInsets.all(15),
          child: Skelton(
            width: double.infinity,
            height: 210,
          ),
        ),
        ...List.generate(
          10,
          (index) => const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Skelton(
              width: double.infinity,
              height: 60,
            ),
          ),
        ),
      ],
    );
  }
}
