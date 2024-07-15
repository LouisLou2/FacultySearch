import 'package:provider/provider.dart';
import 'package:teacher_search/state/teacher_search_prov.dart';
import 'package:teacher_search/state/theme_prov.dart';
import 'base_info_prov.dart';
import 'package:nested/nested.dart';

class ProvManager {
  static late ThemeProv themeProv;
  static late TeacherSearchProv teacherSearchProv;
  static late BaseInfoProv baseInfoProv;

  static void init(){
    themeProv = ThemeProv();
    teacherSearchProv = TeacherSearchProv();
    baseInfoProv = BaseInfoProv();
  }

  static List<SingleChildWidget>  get getProvList => [
      ChangeNotifierProvider.value(value: themeProv),
      ChangeNotifierProvider.value(value: teacherSearchProv),
      ChangeNotifierProvider.value(value: baseInfoProv),
    ];
}