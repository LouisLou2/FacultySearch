import 'package:flutter/material.dart';
import 'package:teacher_search/const/app_param.dart';
import 'package:teacher_search/const/data_status.dart';
import 'package:teacher_search/datasource/imple/teacher_ds.dart';
import 'package:teacher_search/domain/req/tea_search_req.dart';
import 'package:teacher_search/presentation/helper/toast_helper.dart';
import 'package:teacher_search/state/prov_manager.dart';

import '../domain/entity/teacher.dart';
import '../domain/entity/teacher_brief.dart';
import '../domain/general/result.dart';
import '../domain/resp/tea_search_resp.dart';

class TeacherSearchProv with ChangeNotifier {
  int nowSum=0;
  int nowPageInd=0;
  /// *******************
  TeaSearchReq nowReq = TeaSearchReq(offset: 0, num: AppParam.pageSize);
  int selectedSchoolInd=0;
  int selectedMajorInd=0;
  int selectedTitleInd=0;
  int selectedGenderInd=0;// 不限， 男， 女
  int searchCount=0;
  /// *******************
  List<TeacherBrief> nowTeachers=[];
  /// *******************
  Teacher? nowTeacher;
  DataStatus _nowTeacherStatus = DataStatus.initial;

  DataStatus get nowTeacherStatus => _nowTeacherStatus;
  bool get isTeacherNull => nowTeacher==null;

  void setNowTeacherStatus(DataStatus status){
    _nowTeacherStatus = status;
    notifyListeners();
  }


  TeacherSearchProv(){
    nowSum=0;
    nowPageInd=0;
    nowReq = TeaSearchReq(offset: 0, num: AppParam.pageSize);
    nowTeachers=[];
    nowTeacher = null;
  }
  int get pageTotal{
    int total = (nowSum/AppParam.pageSize).ceil();
    return total==0?1:total;
  }

  void enterSearchPage() async {
    nowReq = TeaSearchReq(offset: 0, num: AppParam.pageSize);
    nowTeachers=[];
    nowTeacher = null;
    selectedSchoolInd = -1;
    selectedMajorInd = 0;
    selectedTitleInd=0;
    selectedGenderInd=0;
    searchCount=0;
    await ProvManager.baseInfoProv.getSchoolsFromNet();
    await searchTeachers(false);
    notifyListeners();
  }

  void setReqSchool(int ind){
    if(ind!=selectedSchoolInd){
      setReqMajor(-1);
    }
    selectedSchoolInd=ind;
    if(ind==-1){
      nowReq.schoolId = null;
      notifyListeners();
      return;
    }
    nowReq.schoolId = ProvManager.baseInfoProv.schools[ind].schoolId;
    notifyListeners();
  }

  void setReqMajor(int ind){
    if(ind==-1){
      nowReq.majorId = null;
      return;
    }
    nowReq.majorId = ProvManager.baseInfoProv.schools[selectedSchoolInd].majors[ind].majorId;
  }

  void setReqTitle(int ind){
    selectedTitleInd = ind;
    nowReq.title = ind==0 ? null: ind;
    notifyListeners();
  }

  void setReqGender(int ind){
    selectedGenderInd = ind;
    nowReq.gender = (ind==0) ? null: ind==1;
    notifyListeners();
  }

  void setReqName(String name){
    nowReq.name = name.isEmpty?null:name;
    print(nowReq.toJson());
  }

  void setReqPageAndSearch(int ind){
    nowPageInd = ind;
    nowReq.offset = ind * AppParam.pageSize;
    searchTeachers(true);
  }

  Future<void> searchTeachers(bool fromPageChange) async {
    if(!fromPageChange){
      nowPageInd = 0;
    }
    Result<TeaSearchResp> resp = await TeacherDs.getTeaSearchReq(nowReq);
    if(resp.isSuccess){
      nowSum = resp.data!.sum;
      nowTeachers = resp.data!.teachers;
      notifyListeners();
    }else{
      ToastHelper.showErrorWithouDesc('Failed');
    }
    ++searchCount;
    notifyListeners();
  }

  Future<void> tapATeacher(BuildContext context ,int ind) async {
    setNowTeacherStatus(DataStatus.loading);
    nowTeacher = null;
    Navigator.of(context).pushNamed('/teacher_intro');
    Result<Teacher> resp = await TeacherDs.getTeaInfo(nowTeachers[ind].teacherId);
    if(resp.isSuccess){
      nowTeacher = resp.data;
      setNowTeacherStatus(DataStatus.success);
    }else{
      ToastHelper.showErrorWithouDesc('Failed');
      setNowTeacherStatus(DataStatus.failure);
    }
  }

  Future<void> seeTeacherFromId(String teacherId) async {
    setNowTeacherStatus(DataStatus.loading);
    nowTeacher = null;
    Result<Teacher> resp = await TeacherDs.getTeaInfo(teacherId);
    if(resp.isSuccess){
      nowTeacher = resp.data;
      setNowTeacherStatus(DataStatus.success);
    }else{
      ToastHelper.showErrorWithouDesc('Failed');
      setNowTeacherStatus(DataStatus.failure);
    }
  }
}