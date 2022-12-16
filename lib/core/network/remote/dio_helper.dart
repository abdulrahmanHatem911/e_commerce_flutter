import 'dart:io';

import 'package:dio/dio.dart';
import 'api_constant.dart';

class DioHelper {
  static Dio? dio;
  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstant.BASE_URL,
        receiveDataWhenStatusError: true,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': "*/*",
          'connection': 'keep-alive',
          'Accept-Encoding': 'gzip, deflate, br',
          'Accept-Language': 'en-US,en;q=0.9',
          'Cache-Control': 'no-cache',
          'Pragma': 'no-cache',
          'User-Agent':
              'Mozilla/5.0 (Linux; Android 10; SM-A107F) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.105 Mobile Safari/537.36',
        },
      ),
    );
  }

  // to get data
  static Future<Response> getData(
      {required String url, Map<String, dynamic>? query}) async {
    return await dio!.get(
      url,
      queryParameters: query,
    );
    //psot data
  }

  static Future<Response> getDataUseToken({
    required String url,
    required String token,
  }) async {
    return await dio!.get(
      url,
      options: Options(
        headers: {
          'Authorization ': 'Bearer $token',
        },
      ),
    );
  }

  // to post data
  static Future<Response> postData(
      {required String url,
      required Map<String, dynamic> data,
      Map<String, dynamic>? query}) async {
    return await dio!.post(
      url,
      data: data,
      queryParameters: query,
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
