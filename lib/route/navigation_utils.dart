import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'navigation_path.dart';

class NavigationUtils {
  static replaceHomePage(BuildContext context) =>
      context.go(NavigationPath.home.path);
  static introductionPage(BuildContext context) =>
      context.go(NavigationPath.intro.path);
  static notificationPage(BuildContext context) =>
      context.push("/notification");
  static showAuthSuccessPage(BuildContext context) => context.go(
      "/signupSuccess/You're All Set!/Your coffee adventure begins!/Start Exploring");

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

  static offersPage(BuildContext context) => context.push("/offers");
  static vouchersPage(BuildContext context, String shopid) =>
      context.push("/check-out/$shopid/vouchers");
  static vouchersAndDiscountPage(BuildContext context) =>
      context.push("/vouchers-discount");

  static checkoutPage(BuildContext context, String shopid) =>
      context.push("/check-out/$shopid");

  static chooseAddressPage(BuildContext context, String shopid) =>
      context.push("/check-out/$shopid/choose-address");

  static choosePaymentPage(BuildContext context, String shopid) =>
      context.push("/check-out/$shopid/choose-payment");
  static chooseTopUpPaymentPage(BuildContext context) =>
      context.push("/top-up/choose-payment");

  static chooseDeliveryPage(BuildContext context, String shopid) =>
      context.push("/check-out/$shopid/choose-delivery");
  static chooseVouchersPage(BuildContext context, String shopid) =>
      context.push("/check-out/$shopid/vouchers");
  static searchingDriverPage(BuildContext context, String shopid) =>
      context.push("/check-out/$shopid/success");
  static driverProfilePage(BuildContext context) =>
      context.push("/check-out/99/driver-profile");
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
  static orderDetailsPagePickup(BuildContext context) =>
      context.push("/orderDetails/true");
  static orderDetailsPageDelivery(BuildContext context) =>
      context.push("/orderDetails/false");
  static topUpPage(BuildContext context) => context.push("/top-up");
  static transactionHistoryPage(BuildContext context) =>
      context.push("/transaction-history");
  static caffelyPointsPage(BuildContext context) => context.push("/points");
  static navigateRewardPage(BuildContext context) =>
      context.push("/caffely-reward");
  static navigateFavoriteCoffeePage(BuildContext context) =>
      context.push("/favorite-coffee");

  static navigateManageAddressPage(BuildContext context) =>
      context.push("/manage-address");
  static addNewAddressPage(BuildContext context) =>
      context.push("/manage-address/add-address");
  static fillUpAddressPage(BuildContext context) =>
      context.push("/manage-address/fill-address");
  static managePaymentsPage(BuildContext context) =>
      context.push("/manage-payments");

  static addNewPaymentMethodPage(BuildContext context) =>
      context.push("/manage-payments/add-payment");

  static personalInfoPage(BuildContext context) =>
      context.push("/personal-info");

  static notificationSettingPage(BuildContext context) =>
      context.push("/notification-settings");

  static securitySettingsPage(BuildContext context) =>
      context.push("/security-settings");
  static languageSettingPage(BuildContext context) =>
      context.push("/language-settings");

  static helpCenterPage(BuildContext context) => context.push("/help-center");
  static aboutCaffelyPage(BuildContext context) => context.push("/about-us");
}
