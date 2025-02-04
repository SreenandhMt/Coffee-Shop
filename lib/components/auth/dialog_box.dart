import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../core/app_colors.dart';
import '../../core/fonts.dart';
import '../../core/size.dart';

class DialogBox extends StatefulWidget {
  const DialogBox({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.autoFunction,
    this.child,
  });
  final IconData icon;
  final String title;
  final String subtitle;
  final Function()? autoFunction;
  final Widget? child;

  @override
  State<DialogBox> createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), widget.autoFunction);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(28)),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            height20,
            CircleAvatar(
              radius: 60,
              backgroundColor: AppColors.primaryColor,
              child: Icon(
                widget.icon,
                size: 60,
              ),
            ),
            height30,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                widget.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: AppColors.primaryColor),
              ),
            ),
            height25,
            Padding(
              padding: const EdgeInsets.symmetric(),
              child: Text(
                widget.subtitle,
                textAlign: TextAlign.center,
                style: subtitleFont(fontSize: 16),
              ),
            ),
            if (widget.child != null) ...[
              height20,
              widget.child!
            ] else ...[
              height35,
              const SizedBox(
                  width: 70,
                  height: 70,
                  child: LoadingIndicator(
                    indicatorType: Indicator.ballRotateChase,
                    colors: [AppColors.primaryColor],
                  )),
            ]
          ],
        ),
      ),
    );
  }
}
