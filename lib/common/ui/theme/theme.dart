import 'package:easy_beck/common/ui/theme/backgrounds.dart';
import 'package:easy_beck/common/ui/theme/borders.dart';
import 'package:easy_beck/common/ui/theme/colors.dart';
import 'package:flutter/material.dart';

abstract class AppColors {
  static const primary = Color(0xffA0C49D);
  static const background = Color(0xffC4D7B2);
  static const surfaceTint = Color(0xffF4F2DE);
  static const surface = Color(0xffF7FFE5);
  static const opaqueSelection = Colors.white24;
  static const primaryLight = Color(0xffDBE4CB);
}

abstract class AppFontFamilies {
  static const common = "Itim";
  static const display = "AmaticSC";
}

final themeData = ThemeData(
    extensions: [
      const Backgrounds(selected: AppColors.opaqueSelection),
      Borders(
          thin: Border.all(width: 0.5),
          regular: Border.all(width: 1),
          bold: Border.all(width: 2)),
      const ExtraColors(
          modalBarrier: Colors.black38,
          inactive: Colors.grey,
          backgroundVariant: AppColors.primaryLight,
          backgroundDark: AppColors.primary)
    ],
    colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary, background: AppColors.background),
    cardTheme: const CardTheme(
        surfaceTintColor: AppColors.surfaceTint, color: AppColors.surface),
    useMaterial3: true,
    fontFamily: AppFontFamilies.common,
    textTheme: const TextTheme(
        displayLarge: TextStyle(fontSize: 64),
        headlineLarge: TextStyle(
            fontFamily: AppFontFamilies.display,
            fontSize: 32,
            fontWeight: FontWeight.bold),
        headlineMedium: TextStyle(
            fontFamily: AppFontFamilies.display,
            fontSize: 24,
            fontWeight: FontWeight.bold),
        headlineSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        titleMedium: TextStyle(fontSize: 20),
        labelLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        )));
