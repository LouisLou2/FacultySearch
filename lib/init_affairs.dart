import 'package:flutter/material.dart';
import 'package:teacher_search/state/prov_manager.dart';
import 'package:teacher_search/style/style_scheme.dart';
import 'package:teacher_search/style/theme_vault.dart';

void uiInit(){
  ThemeVault.light = ThemeVault.light.copyWith(
    colorScheme: ThemeVault.light.colorScheme.copyWith(
      onInverseSurface: const Color(0xfff6f6f9),
      surfaceContainerHighest: const Color(0xfff8f8f9),
      surfaceContainerHigh: const Color(0xfff8f8f9),
    ),
  );
  StyleScheme.setOnSuface(
    lightOnSufColor: ThemeVault.light.colorScheme.onSurface,
    darkOnSufColor: ThemeVault.dark.colorScheme.onSurface,
    lightSufColor: ThemeVault.light.colorScheme.surface,
    darkSufColor: ThemeVault.dark.colorScheme.surface,
  );
}

void initBeforeRun(){
  uiInit();
  ProvManager.init();
  ProvManager.themeProv.setThemeMode(ThemeMode.dark);
}