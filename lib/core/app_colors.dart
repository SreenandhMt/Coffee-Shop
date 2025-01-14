import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color.fromRGBO(2, 170, 100, 1);
  static Color themeColor(context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black;
  }

  static Color themeTextColor(context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.white54
        : Colors.black54;
  }

  static Color backgroundColor(context) {
    return Theme.of(context).brightness == Brightness.light
        ? Colors.white
        : Colors.black;
  }

  static Color secondaryColor(context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.grey.shade900
        : Colors.grey.shade300;
  }
}
