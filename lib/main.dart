import 'package:coffee_app/core/theme.dart';
import 'package:coffee_app/features/buying/view_models/buying_view_model.dart';
import 'package:coffee_app/features/checkout/view_models/checkout_view_model.dart';
import 'package:coffee_app/features/coffee_shop_details/view_models/coffee_shop_view_model.dart';
import 'package:coffee_app/features/coffee_shops/view_models/coffee_shops_view_model.dart';
import 'package:coffee_app/features/home/view_models/home_view_model.dart';
import 'package:coffee_app/features/notification/view_models/notification_view_model.dart';
import 'package:coffee_app/route/go_router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'features/auth/view_models/auth_view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeViewModel()),
        ChangeNotifierProvider(create: (context) => AuthViewModel()),
        ChangeNotifierProvider(create: (context) => NotificationViewModel()),
        ChangeNotifierProvider(create: (context) => BuyingViewModel()),
        ChangeNotifierProvider(
            create: (context) => CoffeeShopDetailsViewModel()),
        ChangeNotifierProvider(create: (context) => CheckoutViewModel()),
        ChangeNotifierProvider(create: (context) => CoffeeShopsViewModel()),
      ],
      child: MaterialApp.router(
        title: 'Coffee App',
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,
        darkTheme: AppTheme.darkTheme,
        theme: AppTheme.lightTheme,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
