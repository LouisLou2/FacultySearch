import 'package:flutter/material.dart';
import 'package:teacher_search/state/prov_manager.dart';

class StyleScheme{
  static const String engFontFamily = 'GoogleSans';
  static const String cnFontFamily = 'NotoSansSC';
  static late final Color lightOnSurface;
  static late final Color darkOnSurface;
  static late final Color lightSurface;
  static late final Color darkSurface;

  static void setOnSuface({
    required Color lightOnSufColor,
    required Color darkOnSufColor,
    required Color lightSufColor,
    required Color darkSufColor,
  }){
    lightOnSurface = lightOnSufColor;
    darkOnSurface = darkOnSufColor;
    lightSurface = lightSufColor;
    darkSurface = darkSufColor;
  }

  static String getThemeText(ThemeMode mode){
    switch (mode) {
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
      case ThemeMode.system:
        return 'Auto';
    }
  }

  static cn_onSuf_500_LPN03({
    required double size,
    ThemeMode? mode,
    Color? color,
  }){
    mode ??= ProvManager.themeProv.mode;
    return TextStyle(
      fontFamily: cnFontFamily,
      fontWeight: FontWeight.w500,
      fontSize: size,
      letterSpacing: -0.3,
      color: color ?? (mode==ThemeMode.light ? lightOnSurface : darkOnSurface),
    );
  }

  static cn_suf_500_LPN03({
    required double size,
    ThemeMode? mode,
    Color? color,
  }){
    mode ??= ProvManager.themeProv.mode;
    return TextStyle(
      fontFamily: cnFontFamily,
      fontWeight: FontWeight.w500,
      letterSpacing: -0.3,
      fontSize: size,
      color: color ?? (mode==ThemeMode.light ? lightSurface : darkSurface),
    );
  }

  static eng_onSuf_500_LPN05({
    required double size,
    ThemeMode? mode,
    Color? color,
  }){
    mode ??= ProvManager.themeProv.mode;
    return TextStyle(
      fontFamily: engFontFamily,
      fontWeight: FontWeight.w500,
      letterSpacing: -0.5,
      fontSize: size,
      color: color ?? (mode==ThemeMode.light ? lightOnSurface : darkOnSurface),
    );
  }
}