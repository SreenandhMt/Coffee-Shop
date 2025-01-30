import 'dart:developer';

import 'package:coffee_app/features/account/views/about_caffely_page.dart';
import 'package:coffee_app/features/account/views/help_center.dart';
import 'package:coffee_app/localization/locales.dart';
import 'package:flutter_localization/flutter_localization.dart';

import '/features/account/views/account_page.dart';
import '../features/payment/views/add_payment_method_page.dart';
import '/features/account/views/caffely_rewards.dart';
import '/features/account/views/favorite_coffee_page.dart';
import '../features/address/views/fill_address_details_page.dart';
import '/features/account/views/language_settings_page.dart';
import '../features/address/views/manage_address_page.dart';
import '../features/payment/views/manage_payments_page.dart';
import '../features/address/views/new_address_page.dart';
import '/features/account/views/notification_settings_page.dart';
import '/features/account/views/personal_info_page.dart';
import '/features/account/views/security_settings_page.dart';
import '/features/checkout/views/checkout_page.dart';
import '../features/address/views/choose_address.dart';
import '/features/checkout/views/choose_delivery.dart';
import '../features/payment/views/choose_payment.dart';
import '../features/orders/views/driver_profile.dart';
import '/features/checkout/views/searching_driver.dart';
import '../features/checkout/views/vouchers_page.dart';
import '/features/coffee_shops/views/coffee_shops_page.dart';
import '/features/orders/views/cancel_order_page.dart';
import '/features/orders/views/order_details.dart';
import '/features/orders/views/orders_page.dart';
import '/features/orders/views/point_reward_page.dart';
import '/features/orders/views/rating_driver_page.dart';
import '/features/orders/views/rating_shop_page.dart';
import '../features/orders/views/tip_driver_page.dart';
import '/features/orders/views/check_mood_page.dart';
import '/features/orders/views/video_call_page.dart';
import '/features/orders/views/voice_call_page.dart';
import '/features/wallet/views/top_up_page.dart';
import '/features/wallet/views/transaction_history.dart';
import '/features/wallet/views/wallet_page.dart';
import 'package:flutter/material.dart';

import '../features/account/views/caffely_points_page.dart';
import '../features/orders/views/chat_driver_page.dart';
import '/features/auth/views/forgot_password/create_password_page.dart';
import '/features/auth/views/forgot_password/email_conform_page.dart';
import '/features/auth/views/forgot_password/otp_conform_page.dart';
import '/features/auth/views/profile_details_page.dart';
import '/features/auth/views/signin_page.dart';
import '/features/auth/views/signup_page.dart';
import '/features/auth/views/signup_success_page.dart';
import '/features/buying/views/buying_page.dart';
import '/features/coffee_shop_details/views/about_shop.dart';
import '/features/coffee_shop_details/views/coffee_shop_details_page.dart';
import '/features/coffee_shop_details/views/offers_page.dart';
import '/features/coffee_shop_details/views/review_page.dart';
import '/features/home/views/home_page.dart';
import '/features/home/views/nearby_shops.dart';
import '/features/home/views/offer_details_page.dart';
import '/features/introduction/views/introduction_pages.dart';
import '/features/introduction/views/splash_screen.dart';
import '../features/auth/views/welcome_screen.dart';
import '/features/notification/views/notification_page.dart';
import '/route/navigation_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../features/home/views/popular_menu_page.dart';

class AppRouter {
  static final navigationKey = GlobalKey<NavigatorState>();
  static GoRouter routerConfig(bool isAuth) {
    return GoRouter(
        navigatorKey: navigationKey,
        initialLocation: NavigationPath.splashScreen.path,
        redirect: (context, state) {
          return null;
        },
        routes: [
          GoRoute(
            path: NavigationPath.splashScreen.path,
            name: NavigationPath.splashScreen.name,
            builder: (context, state) => const SplashScreen(),
          ),
          StatefulShellRoute.indexedStack(
            builder: (context, state, navigationShell) => Scaffold(
              body: navigationShell,
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: navigationShell.currentIndex,
                onTap: (index) => navigationShell.goBranch(index),
                selectedItemColor: Colors.green,
                unselectedItemColor: Colors.grey,
                showUnselectedLabels: true,
                type: BottomNavigationBarType.fixed,
                items: [
                  BottomNavigationBarItem(
                    icon: const Icon(CupertinoIcons.home),
                    label: LocaleData.home.getString(context),
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(CupertinoIcons.shopping_cart),
                    label: LocaleData.shop.getString(context),
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(CupertinoIcons.doc_text),
                    label: LocaleData.orders.getString(context),
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.account_balance_wallet_outlined),
                    label: LocaleData.wallet.getString(context),
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(CupertinoIcons.person),
                    label: LocaleData.account.getString(context),
                  ),
                ],
              ),
            ),
            branches: [
              StatefulShellBranch(routes: [
                GoRoute(
                  name: NavigationPath.home.name,
                  path: NavigationPath.home.path,
                  builder: (context, state) => const HomePage(),
                ),
              ]),
              StatefulShellBranch(routes: [
                GoRoute(
                  path: "/shops",
                  builder: (context, state) {
                    return const CoffeeShopsPage();
                  },
                ),
              ]),
              StatefulShellBranch(routes: [
                GoRoute(
                  path: "/orders",
                  builder: (context, state) {
                    return const OrdersPage();
                  },
                ),
              ]),
              StatefulShellBranch(routes: [
                GoRoute(
                  path: "/wallet",
                  builder: (context, state) {
                    return const WalletPage();
                  },
                ),
              ]),
              StatefulShellBranch(routes: [
                GoRoute(
                  path: "/account",
                  builder: (context, state) {
                    return const AccountPage();
                  },
                ),
              ])
            ],
          ),
          GoRoute(
              path: "/top-up",
              builder: (context, state) {
                return const TopUpPage();
              },
              routes: [
                GoRoute(
                  path: "/choose-payment",
                  builder: (context, state) => const ChoosePaymentPage(
                    isTopUpPage: true,
                  ),
                ),
              ]),
          GoRoute(
            path: "/transaction-history",
            builder: (context, state) => const TransactionHistory(),
          ),
          GoRoute(
            path: "/OrderDetails/:isPickup",
            builder: (context, state) {
              final page = bool.parse(state.pathParameters["isPickup"]!);
              return OrderDetailsPage(isPickUp: page);
            },
          ),
          GoRoute(
            path: "/help-center",
            builder: (context, state) => const HelpCenterPage(),
          ),
          GoRoute(
            path: "/about-us",
            builder: (context, state) => const AboutCaffelyPage(),
          ),
          GoRoute(
            path: "/offers",
            builder: (context, state) => const OffersPage(),
          ),
          GoRoute(
            path: "/caffely-reward",
            builder: (context, state) => const CaffelyRewardsPage(),
          ),
          GoRoute(
            path: "/favorite-coffee",
            builder: (context, state) => const FavoriteCoffeePage(),
          ),
          GoRoute(
            path: "/points",
            builder: (context, state) => const CaffelyPointsPage(),
          ),
          GoRoute(
            path: "/buying-page/:id/:route",
            builder: (context, state) {
              return BuyingPage(
                  id: state.pathParameters["id"]!,
                  shopPageOpened:
                      bool.tryParse(state.pathParameters["route"]!));
            },
          ),
          GoRoute(
            path: "/signupSuccess/:title/:subtitle/:button",
            builder: (context, state) => SignupSuccessPage(
              title: state.pathParameters["title"],
              subtitle: state.pathParameters["subtitle"],
              buttonText: state.pathParameters["button"],
            ),
          ),
          GoRoute(
            path: "/notification",
            builder: (context, state) => const NotificationPage(),
          ),
          GoRoute(
            path: "/nearby-shops",
            builder: (context, state) => const NearbyShopsPage(),
          ),
          GoRoute(
            path: "/popular-menu",
            builder: (context, state) => const PopularMenuPage(),
          ),
          GoRoute(
            path: "/offer-details",
            builder: (context, state) => const OfferDetailsPage(),
          ),
          GoRoute(
            path: "/shop-details/:shopid",
            builder: (context, state) {
              return CoffeeShopDetailsPage(
                shopId: state.pathParameters["shopid"]!,
              );
            },
            routes: [
              GoRoute(
                path: "/about",
                builder: (context, state) => const AboutShopPage(),
              ),
              GoRoute(
                path: "/review-rating",
                builder: (context, state) => const RatingAndReviews(),
              ),
            ],
          ),
          GoRoute(
            path: "/personal-info",
            builder: (context, state) => const PersonalInfoPage(),
          ),
          GoRoute(
            path: "/notification-settings",
            builder: (context, state) => const NotificationSettingsPage(),
          ),
          GoRoute(
            path: "/security-settings",
            builder: (context, state) => const SecuritySettingsPage(),
          ),
          GoRoute(
            path: "/language-settings",
            builder: (context, state) => const LanguageSettingsPage(),
          ),
          GoRoute(
            path: "/vouchers-discount",
            builder: (context, state) => const VouchersAndDiscountPage(),
          ),
          GoRoute(
              path: "/manage-payments",
              builder: (context, state) => const ManagePaymentsPage(),
              routes: [
                GoRoute(
                  path: "/add-payment",
                  builder: (context, state) => const AddPaymentMethodPage(),
                ),
              ]),
          GoRoute(
              path: "/manage-address",
              builder: (context, state) => const ManageAddressPage(),
              routes: [
                GoRoute(
                    path: "/add-address",
                    builder: (context, state) {
                      return const AddNewAddressPage();
                    }),
                GoRoute(
                    path: "/fill-address",
                    builder: (context, state) {
                      return const FillUpAddressDetailsPage();
                    }),
              ]),
          GoRoute(
            path: "/check-out/:shopId",
            builder: (context, state) {
              return CheckoutPage(shopID: state.pathParameters["shopId"]!);
            },
            routes: [
              GoRoute(
                path: "/choose-address",
                builder: (context, state) => const ChooseAddressPage(),
              ),
              GoRoute(
                path: "/choose-payment",
                builder: (context, state) => const ChoosePaymentPage(),
              ),
              GoRoute(
                path: "/choose-delivery",
                builder: (context, state) => const ChooseDeliveryPage(),
              ),
              GoRoute(
                path: "/vouchers",
                builder: (context, state) =>
                    const VouchersAndDiscountPage(isBuyingPage: true),
              ),
              GoRoute(
                path: "/success",
                builder: (context, state) => const SearchingDriverPage(),
              ),
            ],
          ),
          GoRoute(
              path: "/orders",
              builder: (context, state) => const SizedBox(),
              routes: [
                GoRoute(
                  path: "/driver-profile",
                  builder: (context, state) => const DriverProfilePage(),
                ),
                GoRoute(
                  path: "/chat-driver",
                  builder: (context, state) => const ChatDriverPage(),
                ),
                GoRoute(
                  path: "/video-call",
                  builder: (context, state) => const VideoCallPage(),
                ),
                GoRoute(
                  path: "/voice-call",
                  builder: (context, state) => const VoiceCallPage(),
                ),
                GoRoute(
                  path: "/reward-point",
                  builder: (context, state) => const PointRewardPage(),
                ),
                GoRoute(
                  path: "/check-mood",
                  builder: (context, state) => const CheckUserMoodPage(),
                ),
                GoRoute(
                  path: "/rating-driver",
                  builder: (context, state) => const RatingPage(),
                ),
                GoRoute(
                  path: "/tip-driver",
                  builder: (context, state) => const TipDriver(),
                ),
                GoRoute(
                  path: "/rating-shop",
                  builder: (context, state) => const RatingShopPage(),
                ),
                GoRoute(
                  path: "/cancel",
                  builder: (context, state) => const CancelOrderPage(),
                ),
              ]),
          GoRoute(
            name: NavigationPath.intro.name,
            path: NavigationPath.intro.path,
            builder: (context, state) => const IntroductionPage(),
          ),
          GoRoute(
              path: NavigationPath.welcomeScreen.path,
              name: NavigationPath.welcomeScreen.name,
              builder: (context, state) => const WelcomeScreen(),
              routes: [
                GoRoute(
                    path: "/signin",
                    builder: (context, state) => const SigninPage(),
                    routes: [
                      GoRoute(
                        path: "/resetPassword-step-1",
                        builder: (context, state) => const EmailConformPage(),
                      ),
                      GoRoute(
                        path: "/resetPassword-step-2",
                        builder: (context, state) => const OTPConformPage(),
                      ),
                      GoRoute(
                        path: "/resetPassword-step-3",
                        builder: (context, state) => const CreatePasswordPage(),
                      ),
                    ]),
                GoRoute(
                    path: "/signup",
                    builder: (context, state) => const SignupPage(),
                    routes: [
                      GoRoute(
                        path: "profileDetails",
                        builder: (context, state) => const ProfileDetailsPage(),
                      ),
                    ]),
              ])
        ]);
  }
}
