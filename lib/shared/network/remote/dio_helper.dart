import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
        BaseOptions(
          baseUrl: 'https://student.valuxapps.com/api/',
          receiveDataWhenStatusError: true,
        )
    );
  }
  // ======================> POST DATA  <===========================
  static Future<Response> postData({
    required String url,
    required Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    String? token,
    String lang = 'en',
  }) async
  {
    dio.options.headers = {
      'Authorization' : token,
      'lang' : lang,
    };
    return await dio.post(
        url,
        data: data,
        queryParameters: query,
    );
  }

  //=======================> GET DATA <===========================

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String? token,
    String lang = 'en',
  }) async
  {
    dio.options.headers = {
      'Content-Type' : 'application/json',
      'Authorization' : token,
      'lang' : lang,
    };
    return await dio.get(
      url,
      queryParameters: query,
    );
  }

  //=======================> PUT DATA <===========================
  static Future<Response> putData({
    required String url,
    required Map<String, dynamic>? data,
    String? token,
    String lang = 'en',
})async
  {
    dio.options.headers ={
      'Content-Type' : 'application/json',
      'Authorization' : token,
      'lang' : lang,
    };
    return await dio.put(
        url,
      queryParameters: data,
    );
  }


}