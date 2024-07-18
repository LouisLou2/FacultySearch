import 'package:flutter/material.dart';
import 'package:teacher_search/datasource/imple/basic_info_ds.dart';

import '../const/data_status.dart';
import '../domain/entity/school.dart';
import '../domain/general/result.dart';
import '../presentation/helper/toast_helper.dart';

class BaseInfoProv extends ChangeNotifier {

  DataStatus _status = DataStatus.initial;

  List <School> schools = [];

  DataStatus get status => _status;

  void setStatus(DataStatus status){
    _status = status;
    notifyListeners();
  }

  Future<void> getSchoolsFromNet() async {
    if(schools.isNotEmpty){
      return;
    }
    setStatus(DataStatus.loading);
    Result<List<School>> resp = await BaseInfoDs.getSchoolMajor();
    if(resp.isSuccess){
      schools = resp.data!;
      setStatus(DataStatus.success);
    }else{
      ToastHelper.showErrorWithouDesc('Failed Loading Schools');
      setStatus(DataStatus.failure);
    }
  }
}