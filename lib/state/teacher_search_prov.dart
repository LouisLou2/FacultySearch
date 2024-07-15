import 'package:flutter/material.dart';
import 'package:teacher_search/const/app_param.dart';
import 'package:teacher_search/const/teacher_title.dart';
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
  bool get isTeacherNull => nowTeacher==null;

  TeacherSearchProv(){
    nowSum=0;
    nowPageInd=0;
    nowReq = TeaSearchReq(offset: 0, num: AppParam.pageSize);
    nowTeachers=[];
    nowTeacher = null;
  }

  int get pageTotal => (nowSum/AppParam.pageSize).ceil();

  void setReqSchool(int ind){
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
    if(selectedSchoolInd==-1){
      nowReq.majorId = null;
      notifyListeners();
      return;
    }
    nowReq.majorId = ProvManager.baseInfoProv.schools[selectedSchoolInd].majors[ind].majorId;
    notifyListeners();
  }

  void setReqTitle(int ind){
    selectedTitleInd = ind;
    nowReq.title = ind==0 ? null: ind-1;
    notifyListeners();
  }

  void setReqGender(int ind){
    selectedGenderInd = ind;
    nowReq.gender = (ind==0) ? null: ind==1;
    notifyListeners();
  }

  void setReqName(String name){
    nowReq.name = name.isEmpty?null:name;
  }

  void setReqPageAndSearch(int ind){
    nowPageInd = ind;
    nowReq.offset = ind * AppParam.pageSize;
    searchTeachers();
  }

  void searchTeachers() async {
    Result<TeaSearchResp> resp = await TeacherDs.getTeaSearchReq(nowReq);
    if(resp.isSuccess){
      nowSum = resp.data!.sum;
      nowTeachers = resp.data!.teachers;
      notifyListeners();
    }else{
      ToastHelper.showFaultToast('Failed');
    }
    ++searchCount;
    notifyListeners();
  }

  void tapATeacher(BuildContext context ,int ind) async {
    nowTeacher = null;
    Navigator.of(context).pushNamed('/teacher_intro');
    Result<Teacher> resp = await TeacherDs.getTeaInfo(nowTeachers[ind].teacherId);
    if(resp.isSuccess){
      nowTeacher = resp.data;
      notifyListeners();
    }else{
      ToastHelper.showFaultToast('Failed');
    }
  }
}