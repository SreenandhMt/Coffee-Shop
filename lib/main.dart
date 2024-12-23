import 'package:coffee_app/core/theme.dart';
import 'package:coffee_app/features/home/view_models/home_view_model.dart';
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
      ],
      child: MaterialApp.router(
          title: 'Coffee App',
          // darkTheme: AppTheme.darkTheme,
          theme: AppTheme.lightTheme,
          routerConfig: AppRouter.router,
        ),
    );
  }
}
