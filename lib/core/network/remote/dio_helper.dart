import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import 'api_constant.dart';

abstract class INetworkHelper {
  Future<Response> fetchData(
      {required String url, Map<String, dynamic>? query, String? token});

  Future<Response> postData(
      {required String url, required Map<String, dynamic> data, String? token});
}

class DioHelper implements INetworkHelper {
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

  @override
  Future<Response> fetchData(
      {required String url, Map<String, dynamic>? query, String? token}) async {
    final options = token != null
        ? Options(
            headers: {'Authorization': 'Bearer $token'},
          )
        : null;

    return await dio!.get(
      url,
      queryParameters: query,
      options: options,
    );
  }

  @override
  Future<Response> postData(
      {required String url,
      required Map<String, dynamic> data,
      String? token}) async {
    final options = token != null
        ? Options(
            headers: {'Authorization': 'Bearer $token'},
          )
        : null;

    return await dio!.post(
      url,
      data: data,
      options: options,
    );
  }
}

class HttpHelper implements INetworkHelper {
  @override
  Future<Response<dynamic>> fetchData(
      {required String url, Map<String, dynamic>? query, String? token}) async {
    final uri = Uri.parse(url).replace(queryParameters: query);
    final headers = token != null ? {'Authorization': 'Bearer $token'} : null;

    return await http.get(uri, headers: headers) as Response<dynamic>;
  }

  @override
  Future<Response<dynamic>> postData({
    required String url,
    required Map<String, dynamic> data,
    String? token,
  }) async {
    final headers = token != null ? {'Authorization': 'Bearer $token'} : null;
    return await http.post(Uri.parse(url), body: data, headers: headers)
        as Response<dynamic>;
  }
}
