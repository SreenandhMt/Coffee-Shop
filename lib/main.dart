import 'package:coffee_app/core/theme.dart';
import 'package:coffee_app/firebase_options.dart';
import 'package:coffee_app/localization/locales.dart';
import 'package:coffee_app/route/go_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterLocalization.instance.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FlutterLocalization flutterLocalization = FlutterLocalization.instance;

  @override
  void initState() {
    configLocalization();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp.router(
        title: 'Caffely',
        debugShowCheckedModeBanner: false,
        darkTheme: AppTheme.darkTheme,
        theme: AppTheme.lightTheme,
        supportedLocales: flutterLocalization.supportedLocales,
        localizationsDelegates: flutterLocalization.localizationsDelegates,
        routerConfig: AppRouter.routerConfig(false),
      ),
    );
  }

  void configLocalization() {
    flutterLocalization.init(
      initLanguageCode: 'en',
      mapLocales: LOCALES,
    );
    flutterLocalization.onTranslatedLanguage = (locale) {
      setState(() {});
    };
  }
}
