// ignore_for_file: avoid_print

import 'package:dio/dio.dart';

class ApiServices {
  final Dio dio;

  ApiServices({required this.dio});

  Future<List<dynamic>> getRequest({
    required String url,
    required Map<String, dynamic> queryParameters,
    Options? options,
  }) async {
    try {
      Response<dynamic> response = await dio
          .get(
            url,
            queryParameters: queryParameters,
            options: options,
          )
          .timeout(const Duration(seconds: 10));
      if (response.data is List) {
        return response.data;
      }
      return response.data['hits'];
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<bool> downloadRequest({
    required String url,
    required String fileName,
    required String savePath,
    required Map<String, dynamic> queryParameters,
    Options? options,
  }) async {
    try {
      print('$url  ${savePath + fileName} ');
      await dio.download(
        url,
        savePath + fileName,
        queryParameters: queryParameters,
        options: options,
      );
      print('done');
      return true;
    } on DioError catch (error) {
      print(error);
      return false;
    }
  }

  Future<Response> postRequest({
    required String url,
    required Map<String, dynamic> queryParameters,
    required Map<String, dynamic> data,
    Options? options,
  }) async {
    try {
      Response response = await dio
          .post(
            url,
            data: data,
            queryParameters: queryParameters,
            options: options,
          )
          .timeout(const Duration(seconds: 10));
      return response;
    } on DioError catch (e) {
      print(e.message);
      rethrow;
    }
  }
}

class Failure {
  final String message;

  Failure(this.message);

  @override
  String toString() => message;
}
