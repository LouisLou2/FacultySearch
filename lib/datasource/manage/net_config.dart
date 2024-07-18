
import 'package:dio/dio.dart';

import '../../const/config.dart';

class NetworkConfig{

  static Duration defaultTimeout = const Duration(milliseconds: Configs.CONNECT_TIMEOUT);
  static Duration longerTimeout = const Duration(milliseconds: Configs.CONNECT_TIMEOUT*2);

  static Options get  json_json => Options(
    contentType: Headers.jsonContentType,
    responseType: ResponseType.json,
  );
  static Options get json_form => Options(
    contentType: Headers.formUrlEncodedContentType,
    responseType: ResponseType.json,
  );
}