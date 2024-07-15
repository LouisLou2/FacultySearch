import 'package:dio/dio.dart';
import 'package:teacher_search/const/rescode.dart';
import 'package:teacher_search/datasource/manage/net_config.dart';
import 'package:teacher_search/datasource/manage/network_manager.dart';
import 'package:teacher_search/datasource/manage/network_path_collector.dart';
import 'package:teacher_search/domain/entity/school.dart';
import 'package:teacher_search/helper/global_exception_handler.dart';
import '../../domain/general/resp.dart';
import '../../domain/general/result.dart';

class BaseInfoDs {
  static final _baseDio = NetworkManager.normalDio;

  static Future<Result<List<School>>> getSchoolMajor() async {
    try{
      Response response = await _baseDio.get(
        NetworkPathCollector.school_major,
        options: NetworkConfig.json_json,
      );
      Resp resp = Resp.fromJson(response.data);
      if(ResCode.isOk(resp.code)) {
        final data = resp.data['school_major_list'];
        return Result.success(
          (data as List).map((e) => School.fromJson(e)).toList(),
        );
      }
      return Result.abnormal(resp.code);
    } catch(e){
      return GlobalExceptionHelper.getErrorResInfo(e);
    }
  }
}