
import 'package:dio/dio.dart';

import '../../const/config.dart';

class NetworkConfig{

  static Duration defaultTimeout = const Duration(milliseconds: Configs.CONNECT_TIMEOUT);
  static Duration longerTimeout = const Duration(milliseconds: Configs.CONNECT_TIMEOUT*2);
  // 请求与返回类型的枚举
  static Options get formdata_json => Options(
    contentType: Headers.multipartFormDataContentType,
    responseType: ResponseType.json,
  );
  static Options get  json_json => Options(
    contentType: Headers.jsonContentType,
    responseType: ResponseType.json,
  );
}