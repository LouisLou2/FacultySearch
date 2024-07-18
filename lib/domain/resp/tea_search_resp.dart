import 'package:teacher_search/domain/entity/teacher_brief.dart';

class TeaSearchResp{
  int sum;
  List<TeacherBrief> teachers;

  TeaSearchResp({required this.sum, required this.teachers});

  TeaSearchResp.fromJson(Map<String, dynamic> json):
    sum = json['sum'],
    teachers = (json['teacherDetailVOList'] as List).map((e) => TeacherBrief.fromJson(e)).toList();
}