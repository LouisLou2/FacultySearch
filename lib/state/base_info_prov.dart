import 'package:flutter/material.dart';
import 'package:teacher_search/datasource/imple/basic_info_ds.dart';

import '../domain/entity/school.dart';
import '../domain/general/result.dart';
import '../presentation/helper/toast_helper.dart';

class BaseInfoProv extends ChangeNotifier {
  List <School> schools = [];

  Future<void> getSchoolsFromNet() async {
    Result<List<School>> resp = await BaseInfoDs.getSchoolMajor();
    if(resp.isSuccess){
      schools = resp.data!;
      notifyListeners();
    }else{
      ToastHelper.showFaultToast('Failed Loading Schools');
    }
  }


  void _setSchools(List<School> schools){
    this.schools = schools;
    notifyListeners();
  }

  void _decodeSchools(List<Map<String, dynamic>> json){
    schools = json.map((e) => School.fromJson(e)).toList();
    notifyListeners();
  }
}