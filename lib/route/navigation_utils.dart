import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'navigation_path.dart';

class NavigationUtils {
  //! starting screen
  //*Introduction
  static introductionPage(BuildContext context) {
    return context.go(NavigationPath.intro.path);
  }

  //*auth
  static showAuthSuccessPage(BuildContext context) => context.go(
      "/signupSuccess/You're All Set!/Your coffee adventure begins!/Start Exploring");

  //!main screens
  //*Home
  static replaceHomePage(BuildContext context) {
    return context.go(NavigationPath.home.path);
  }

  static notificationPage(BuildContext context) {
    return context.push("/notification");
  }

  static nearbyShopsPage(BuildContext context) => context.push("/nearby-shops");
  static popularMenuPage(BuildContext context) => context.push("/popular-menu");
  static offerDetailsPage(BuildContext context) {
    return context.push("/offer-details");
  }
  //*

  //*shops
  //?empty
  //*

  //*orders
  static cancelOrderPage(BuildContext context, bool isFormCheckout) =>
      context.push("/orders/cancel/$isFormCheckout");
  static orderDetailsPagePickup(BuildContext context) =>
      context.push("/orderDetails/true");
  static orderDetailsPageDelivery(BuildContext context) =>
      context.push("/orderDetails/false");
  //*orders -> conformation
  static driverProfilePage(BuildContext context, bool isFormOrderDetails) =>
      context.push("/orders/driver-profile/$isFormOrderDetails");
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
  //*

  //*wallet
  static chooseTopUpPaymentPage(BuildContext context) =>
      context.push("/top-up/choose-payment");
  static topUpPage(BuildContext context) => context.push("/top-up");
  static transactionHistoryPage(BuildContext context) =>
      context.push("/transaction-history");
  //*

  //*account
  static caffelyPointsPage(BuildContext context) => context.push("/points");
  static navigateRewardPage(BuildContext context) =>
      context.push("/caffely-reward");
  static navigateFavoriteCoffeePage(BuildContext context) =>
      context.push("/favorite-coffee");
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
  //*

  //!sub screens
  //*shop details
  static coffeeShopDetailsPage(BuildContext context, {required String shopId}) {
    context.push("/shop-details/$shopId");
  }

  static coffeeShopAboutPage(BuildContext context, {required String shopId}) =>
      context.push("/shop-details/$shopId/about");

  static reviewAndRatingPage(BuildContext context, {required String shopId}) =>
      context.push("/shop-details/$shopId/review-rating");
  //*

  //*buying page
  static buyingPage(BuildContext context, String id, bool isShopPage) =>
      context.push("/buying-page/$id/$isShopPage");
  //*

  //* checkout
  static checkoutPage(BuildContext context, String shopid) =>
      context.push("/check-out/$shopid");
  static offersPage(BuildContext context) => context.push("/offers");
  static vouchersPage(BuildContext context, String shopid) =>
      context.push("/check-out/$shopid/vouchers");
  static vouchersAndDiscountPage(BuildContext context) =>
      context.push("/vouchers-discount");
  static chooseAddressPage(BuildContext context, String shopid) =>
      context.push("/check-out/$shopid/choose-address");
  static choosePaymentPage(BuildContext context, String shopid) =>
      context.push("/check-out/$shopid/choose-payment");
  static chooseDeliveryPage(BuildContext context, String shopid) =>
      context.push("/check-out/$shopid/choose-delivery");
  static chooseVouchersPage(BuildContext context, String shopid) =>
      context.push("/check-out/$shopid/vouchers");
  static searchingDriverPage(BuildContext context, String shopid) =>
      context.push("/check-out/$shopid/success");
  //*

  //* address
  static navigateManageAddressPage(BuildContext context) =>
      context.push("/manage-address");
  static addNewAddressPage(BuildContext context) =>
      context.push("/manage-address/add-address");
  static fillUpAddressPage(BuildContext context) =>
      context.push("/manage-address/fill-address");
  static managePaymentsPage(BuildContext context) =>
      context.push("/manage-payments");
}
