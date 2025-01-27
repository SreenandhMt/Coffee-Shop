import 'package:flutter/material.dart';

class AppAssets {
  static String logo = 'assets/logo/logo.png';
  static String logoWithText(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? "assets/logo/logo-white.png"
        : "assets/logo/logo-black.png";
  }

  static String githubLogo(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? "assets/auth/github-white.png"
        : "assets/auth/github.png";
  }

  static String facebookLogo = "assets/auth/facebook-logo.png";
  static String googleLogo = "assets/auth/google-logo.png";
  static String twitterLogo = "assets/auth/twitter-logo.png";

  static String iceCoffee(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? "assets/coffee_type/ice-coffee-white.png"
        : "assets/coffee_type/ice-coffee.png";
  }

  static String hotCoffee(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? "assets/coffee_type/hot-coffee-white.png"
        : "assets/coffee_type/hot-coffee.png";
  }

  static String emoji(BuildContext context, int index) {
    return "assets/emojis/emoji-$index";
  }

  static String rewardedImage = "assets/reward-image.png";
}
