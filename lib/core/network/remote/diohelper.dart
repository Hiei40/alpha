import 'package:dio/dio.dart';

import '../../constans/constants.dart';
import '../local/cachehelper.dart';

class DioHelper {
  static late Dio dio;

  static void reset() {
    dio.close(force: true);
  }

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: CacheHelper.getData(key: 'baseUrl'),
        receiveDataWhenStatusError: true,
        headers: {
          'Accept': 'application/json',
          'Accept-Language': 'ar',
          'Authorization': "Basic $sign",

          // 'Content-Type': 'multipart/form-data',
        },
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
  }) async {
    return await dio.get(url, queryParameters: query);
  }

  static Future<Response> postData({
    required String url,
    dynamic data,
    String? token,
  }) async {
    return dio.post(url, data: data);
  }

  static Future<Response> putData({
    required String url,
    dynamic data,
    String? token,
  }) async {
    return dio.put(url, data: data);
  }

  static Future<Response> deleteData({required String url}) async {
    return dio.delete(url);
  }
}
