import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:teacher_search/const/device.dart';
import 'package:teacher_search/init_affairs.dart';
import 'package:teacher_search/presentation/page/faculty/faculty_search.dart';
import 'package:teacher_search/presentation/page/faculty/teacher_intro.dart';
import 'package:teacher_search/state/prov_manager.dart';
import 'package:teacher_search/state/theme_prov.dart';
import 'package:teacher_search/style/theme_vault.dart';
import 'package:toastification/toastification.dart';
import 'package:url_launcher/url_launcher.dart';

// ...

void main(){
  String myurl = Uri.base.toString(); //get complete url
  // String para1 = Uri.base.queryParameters["para1"]; //get parameter with attribute "para1"
  // String para2 = Uri.base.queryParameters["para2"]; //get parameter with attribute "para2"
  print('此网站不需要用户登录，所以不会有从其他网站跳转到这里的可能, 给出此网站的url: $myurl');
  // Future.delayed(const Duration(seconds: 10), () async {
  //   launchUrl(Uri.http('www.google.com', '/search', {'q': 'dart'}), webOnlyWindowName: '_self');
  // });
  initBeforeRun();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget{
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: DeviceDesignDraft.desktop,
      child: MultiProvider(
        providers: ProvManager.getProvList,
        child: Selector<ThemeProv, ThemeMode>(
          selector: (_, themeProv) => themeProv.mode,
          shouldRebuild: (prev, next) => prev != next,
          builder: (_, mode, __) {
            return ToastificationWrapper(
              child: ShadApp.material(
                routes: {
                  '/faculty_search': (context) => const FacultySearch(),
                  '/teacher_intro': (context) => const TeacherIntro(),
                },
                materialThemeBuilder: (context, theme) {
                  if (theme.brightness == Brightness.light) {
                    return theme.copyWith(
                      primaryColorLight: ThemeVault.light.primaryColorLight,
                      primaryColorDark: ThemeVault.light.primaryColorDark,
                      textTheme: ThemeVault.light.textTheme,
                      colorScheme: ThemeVault.light.colorScheme,
                    );
                  }
                  return theme.copyWith(
                    primaryColorLight: ThemeVault.dark.primaryColorLight,
                    primaryColorDark: ThemeVault.dark.primaryColorDark,
                    textTheme: ThemeVault.dark.textTheme,
                    colorScheme: ThemeVault.dark.colorScheme,
                  );
                },
                themeMode: ProvManager.themeProv.mode,
                home: const FacultySearch(),
              ),
            );
          },
        ),
      ),
    );
  }
}