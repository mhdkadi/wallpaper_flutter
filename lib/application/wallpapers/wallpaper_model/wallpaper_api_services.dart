// ignore_for_file: avoid_print

import 'package:dio/dio.dart';

class ApiServices {
  final Dio dioUnsplash =
      Dio(BaseOptions(baseUrl: 'https://api.unsplash.com/'));

  Future<List<dynamic>> getHttpClient(
      {required String url,
      required Map<String, dynamic> queryParameters}) async {
    try {
      Response<dynamic> response = await dioUnsplash
          .get(url, queryParameters: queryParameters)
          .timeout(const Duration(seconds: 10));
      if (response.data is List) {
        return response.data;
      }
      return response.data['results'];
    } on DioError catch (error) {
      print(error);
      rethrow;
    }
  }
}
