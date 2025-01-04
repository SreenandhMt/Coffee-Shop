import 'package:coffee_app/route/go_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'navigation_path.dart';

class ContextLessNavigationUtils {
  static replaceHomePage() => AppRouter.router.go(NavigationPath.home.path);
  static showHomeSuccessPage() => AppRouter.router.go("/signupSuccess");
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
}
