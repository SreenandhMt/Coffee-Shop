import 'package:coffee_app/features/checkout/views/checkout_page.dart';
import 'package:coffee_app/features/checkout/views/choose_address.dart';
import 'package:coffee_app/features/checkout/views/choose_delivery.dart';
import 'package:coffee_app/features/checkout/views/choose_payament.dart';
import 'package:coffee_app/features/checkout/views/driver_profile.dart';
import 'package:coffee_app/features/checkout/views/searching_driver.dart';
import 'package:coffee_app/features/coffee_shops/views/coffee_shops_page.dart';
import 'package:coffee_app/features/orders/views/cancel_order_page.dart';
import 'package:coffee_app/features/orders/views/orders_page.dart';
import 'package:coffee_app/features/orders/views/point_reward_page.dart';
import 'package:coffee_app/features/orders/views/rating_driver_page.dart';
import 'package:coffee_app/features/orders/views/rating_shop_page.dart';
import 'package:coffee_app/features/orders/views/tip_page.dart';
import 'package:coffee_app/features/orders/views/check_mood_page.dart';
import 'package:coffee_app/features/orders/views/video_call_page.dart';
import 'package:coffee_app/features/orders/views/voice_call_page.dart';
import 'package:flutter/material.dart';

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
import '/features/introduction/views/welcome_screen.dart';
import '/features/notification/views/notification_page.dart';
import '/route/navigation_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../features/home/views/popular_menu_page.dart';

class AppRouter {
  static final navigationKey = GlobalKey<NavigatorState>();
  static final router = GoRouter(
      navigatorKey: navigationKey,
      initialLocation: NavigationPath.home.path,
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
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.home),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.shopping_cart),
                  label: "Shop",
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.doc_text),
                  label: "Orders",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_balance_wallet_outlined),
                  label: "Wallet",
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.person),
                  label: "Account",
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
                  routes: [
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
                            builder: (context, state) =>
                                const RatingAndReviews(),
                          ),
                          GoRoute(
                            path: "/offers",
                            builder: (context, state) => const OffersPage(),
                          ),
                        ]),
                  ]),
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
            ])
          ],
        ),
        GoRoute(
          path: "/buying-page/:id/:route",
          builder: (context, state) {
            return BuyingPage(
                id: state.pathParameters["id"]!,
                shopPageOpened: bool.tryParse(state.pathParameters["route"]!));
          },
        ),
        GoRoute(
          path: "/check-out",
          builder: (context, state) {
            return const CheckoutPage();
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
                  const OffersPage(isVouchersPage: true),
            ),
            GoRoute(
              path: "/success",
              builder: (context, state) => const SearchingDriverPage(),
            ),
            GoRoute(
              path: "/driver-profile",
              builder: (context, state) => const DriverProfilePage(),
            ),
          ],
        ),
        GoRoute(
            path: "/orders",
            builder: (context, state) => const SizedBox(),
            routes: [
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
