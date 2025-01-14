import 'package:coffee_app/route/go_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'navigation_path.dart';

class ContextLessNavigationUtils {
  static replaceHomePage() => AppRouter.router.go(NavigationPath.home.path);
  static showHomeSuccessPage() => AppRouter.router.go(
      "/signupSuccess/You're All Set!/Your coffee adventure begins!/Start Exploring");
}

class NavigationUtils {
  static notificationPage(BuildContext context) =>
      context.push("/notification");

  static nearbyShopsPage(BuildContext context) => context.push("/nearby-shops");

  static popularMenuPage(BuildContext context) => context.push("/popular-menu");

  static offerDetailsPage(BuildContext context) =>
      context.push("/offer-details");

  static coffeeShopDetailsPage(BuildContext context, {required String shopId}) {
    context.push("/shop-details/$shopId");
  }

  static coffeeShopAboutPage(BuildContext context, {required String shopId}) =>
      context.push("/shop-details/$shopId/about");

  static buyingPage(BuildContext context, String id, bool isShopPage) =>
      context.push("/buying-page/$id/$isShopPage");

  static reviewAndRatingPage(BuildContext context, {required String shopId}) =>
      context.push("/shop-details/$shopId/review-rating");

  static offersPage(BuildContext context, {required String shopId}) =>
      context.push("/shop-details/$shopId/offers");

  static checkoutPage(BuildContext context) => context.push("/check-out");

  static chooseAddressPage(BuildContext context) =>
      context.push("/check-out/choose-address");

  static choosePaymentPage(BuildContext context) =>
      context.push("/check-out/choose-payment");

  static chooseDeliveryPage(BuildContext context) =>
      context.push("/check-out/choose-delivery");
  static chooseVouchersPage(BuildContext context) =>
      context.push("/check-out/vouchers");
  static searchingDriverPage(BuildContext context) =>
      context.push("/check-out/success");
  static driverProfilePage(BuildContext context) =>
      context.push("/check-out/driver-profile");
  static chatDriverPage(BuildContext context) =>
      context.push("/orders/chat-driver");
  static videoCallDriverPage(BuildContext context) =>
      context.push("/orders/video-call");
  static voiceCallDriverPage(BuildContext context) =>
      context.push("/orders/voice-call");
  static rewardPintDriverPage(BuildContext context) =>
      context.push("/orders/reward-point");
  static userResponsePage(BuildContext context) =>
      context.push("/orders/check-mood");
  static ratingDriverPage(BuildContext context) =>
      context.push("/orders/rating-driver");
  static tipDriverPage(BuildContext context) =>
      context.push("/orders/tip-driver");
  static ratingShopPage(BuildContext context) =>
      context.push("/orders/rating-shop");
  static showHomeSuccessPage(BuildContext context) => context.go(
      "/signupSuccess/Thank you for your feedback/see you on the next order!/OK");
  static cancelOrderPage(BuildContext context) =>
      context.push("/orders/cancel");
}
