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
        },
      ),
    );
  }

  // to get data
  static Future<Response> getData({
    required String url,
  }) async {
    return await dio!.get(
      url,
    );
    //psot data
  }

  // to post data
  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
  }) async {
    return await dio!.post(
      url,
      data: data,
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
