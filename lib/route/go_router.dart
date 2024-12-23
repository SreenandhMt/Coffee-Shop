import 'package:coffee_app/features/auth/views/forgot_password/create_password_page.dart';
import 'package:coffee_app/features/auth/views/forgot_password/email_conform_page.dart';
import 'package:coffee_app/features/auth/views/forgot_password/otp_conform_page.dart';
import 'package:coffee_app/features/auth/views/profile_details_page.dart';
import 'package:coffee_app/features/auth/views/signin_page.dart';
import 'package:coffee_app/features/auth/views/signup_page.dart';
import 'package:coffee_app/features/auth/views/signup_success_page.dart';
import 'package:coffee_app/features/home/views/home_page.dart';
import 'package:coffee_app/features/introduction/views/introduction_pages.dart';
import 'package:coffee_app/features/introduction/views/splash_screen.dart';
import 'package:coffee_app/features/introduction/views/welcome_screen.dart';
import 'package:coffee_app/route/navigation_path.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: NavigationPath.splashScreen.path,
    routes: [
      GoRoute(
        path: NavigationPath.splashScreen.path,
        name: NavigationPath.splashScreen.name,
        builder: (context, state) => const SplashScreen(),
      ),
    GoRoute(
      name: NavigationPath.home.name,
      path: NavigationPath.home.path,
      builder: (context, state) => const HomePage(),
      routes: [
        GoRoute(
          path: "signupSuccess",
          builder: (context, state) => const SignupSuccessPage(),
        ),
      ]
    ),
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
          ]
        ),
        GoRoute(
          path: "/signup",
          builder: (context, state) => const SignupPage(),
          routes: [
            GoRoute(
              path: "profileDetails",
              builder: (context, state) => const ProfileDetailsPage(),
            ),
          ]
        ),
      ]
    )
  ]);
}