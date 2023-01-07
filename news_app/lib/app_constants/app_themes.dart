import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/app_constants/app_constants.dart';

/// Styles class holding app theming information
class AppThemes {
  /// Light theme data of the app
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      fontFamily: AppTextStyles.fontFamily,
      primaryColor: AppColors.getMaterialColorFromColor(AppColors.primary),
      textTheme: TextThemes.textTheme,
      primaryTextTheme: TextThemes.primaryTextTheme,
      colorScheme: ColorScheme.light(
        primary: AppColors.getMaterialColorFromColor(AppColors.primary),
        onPrimaryContainer: AppColors.white,
        secondary: AppColors.getMaterialColorFromColor(AppColors.secondary),
        tertiary: AppColors.getMaterialColorFromColor(AppColors.tertiary),
        onTertiaryContainer: AppColors.white,
      ),
      backgroundColor: AppColors.getMaterialColorFromColor(AppColors.tertiary),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.white,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppColors.white,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.white,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.tertiary,
        showSelectedLabels: true,
        showUnselectedLabels: false,
      ),
    );
  }
}

/// Styles class holding app text theming information
class TextThemes {
  /// Main text theme
  static TextTheme get textTheme {
    return const TextTheme(
      bodyText1: AppTextStyles.bodyLg,
      bodyText2: AppTextStyles.body,
      subtitle1: AppTextStyles.bodySm,
      subtitle2: AppTextStyles.bodyXs,
      headline1: AppTextStyles.h1,
      headline2: AppTextStyles.h2,
      headline3: AppTextStyles.h3,
      headline4: AppTextStyles.h4,
    );
  }

  /// Dark text theme
  static TextTheme get darkTextTheme {
    return TextTheme(
      bodyText1: AppTextStyles.bodyLg.copyWith(color: AppColors.white),
      bodyText2: AppTextStyles.body.copyWith(color: AppColors.white),
      subtitle1: AppTextStyles.bodySm.copyWith(color: AppColors.white),
      subtitle2: AppTextStyles.bodyXs.copyWith(color: AppColors.white),
      headline1: AppTextStyles.h1.copyWith(color: AppColors.white),
      headline2: AppTextStyles.h2.copyWith(color: AppColors.white),
      headline3: AppTextStyles.h3.copyWith(color: AppColors.white),
      headline4: AppTextStyles.h4.copyWith(color: AppColors.white),
    );
  }

  /// Primary text theme
  static TextTheme get primaryTextTheme {
    return TextTheme(
      bodyText1: AppTextStyles.bodyLg.copyWith(color: AppColors.black),
      bodyText2: AppTextStyles.body.copyWith(color: AppColors.black),
      subtitle1: AppTextStyles.bodySm.copyWith(color: AppColors.primary),
      subtitle2: AppTextStyles.bodyXs.copyWith(color: AppColors.tertiary),
      headline1: AppTextStyles.h1.copyWith(color: AppColors.black),
      headline2: AppTextStyles.h2.copyWith(color: AppColors.black),
      headline3: AppTextStyles.h3.copyWith(color: AppColors.black),
      headline4: AppTextStyles.h4.copyWith(color: AppColors.black),
    );
  }
}
