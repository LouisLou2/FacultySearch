import '../../const/config.dart';

class NetworkPathCollector {
  static const String host = Configs.BaseUrl;// server host
  static const String restfulAPI = "/api/teacher"; // restful api

  static const String userApi = "$host$restfulAPI";// dio的baseUrl，客户端一切请求都是基于这个baseUrl的
  /*------------------分类-------------------*/
  static const search = "/search";
  static const info = "/info";
  static const school_major = "/school_major";
}
