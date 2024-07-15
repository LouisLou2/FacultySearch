import 'package:dio/dio.dart';
import 'package:teacher_search/const/rescode.dart';
import 'package:teacher_search/datasource/manage/net_config.dart';
import 'package:teacher_search/datasource/manage/network_manager.dart';
import 'package:teacher_search/datasource/manage/network_path_collector.dart';
import 'package:teacher_search/domain/req/tea_search_req.dart';
import 'package:teacher_search/helper/global_exception_handler.dart';

import '../../domain/entity/teacher.dart';
import '../../domain/general/resp.dart';
import '../../domain/general/result.dart';
import '../../domain/resp/tea_search_resp.dart';

class TeacherDs {
  static final _baseDio = NetworkManager.normalDio;

  static Future<Result<TeaSearchResp>> getTeaSearchReq(TeaSearchReq req) async {
    try{
      Response response = await _baseDio.get(
        NetworkPathCollector.search,
        data: req.toJson(),
        options: NetworkConfig.json_json,
      );
      Resp resp = Resp.fromJson(response.data);
      if(ResCode.isOk(resp.code)) {
        return Result.success(TeaSearchResp.fromJson(resp.data));
      }
      return Result.abnormal(resp.code);
    } catch(e){
      return GlobalExceptionHelper.getErrorResInfo(e);
    }
  }

  static Future<Result<Teacher>> getTeaInfo(String teacherId) async {
    try{
      Response response = await _baseDio.get(
        NetworkPathCollector.info,
        data: {
          'teacherId': teacherId,
        },
        options: NetworkConfig.json_json,
      );
      Resp resp = Resp.fromJson(response.data);
      if(ResCode.isOk(resp.code)) {
        return Result.success(Teacher.fromJson(resp.data));
      }
      return Result.abnormal(resp.code);
    } catch(e){
      return GlobalExceptionHelper.getErrorResInfo(e);
    }
  }
}