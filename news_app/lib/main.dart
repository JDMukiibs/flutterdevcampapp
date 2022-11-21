import 'package:device_preview/device_preview.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/app_constants/app_constants.dart';
import 'package:news_app/firebase_options.dart';
import 'package:news_app/home_page.dart';

const kEnableDevicePreview = false;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.debug,
  );
  runApp(
    ProviderScope(
      child: DevicePreview(
        enabled: kEnableDevicePreview,
        builder: (context) => const NewsApp(),
      ),
    ),
  );
}

class NewsApp extends StatelessWidget {
  const NewsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: MaterialApp(
        useInheritedMediaQuery: kEnableDevicePreview,
        builder: DevicePreview.appBuilder,
        title: OldAppStrings.appName,
        debugShowCheckedModeBanner: false,
        theme: AppThemes.lightTheme,
        home: const HomePage(),
        supportedLocales: const [
          Locale('en', 'GB'),
          Locale('es', 'ES'),
        ],
        localizationsDelegates: const [
          AppStringsDelegate.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
      ),
    );
  }
}
