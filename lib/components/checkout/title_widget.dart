import 'package:coffee_app/core/app_colors.dart';
import 'package:flutter/material.dart';

import '../../core/fonts.dart';

class CheckoutTitleWidget extends StatefulWidget {
  const CheckoutTitleWidget({
    super.key,
    required this.text,
    this.action,
    required this.child,
  });
  final String text;
  final Widget? action;
  final Widget child;

  @override
  State<CheckoutTitleWidget> createState() => CheckoutTitleWidgetState();
}

class CheckoutTitleWidgetState extends State<CheckoutTitleWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.secondaryColor(context)),
            borderRadius: BorderRadius.circular(10)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Text(widget.text,
                    style: subtitleFont(
                        fontSize: 19, fontWeight: FontWeight.bold)),
              ),
              if (widget.action != null) ...[const Spacer(), widget.action!]
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Divider(thickness: 0.1),
          ),
          widget.child
        ]));
  }
}
