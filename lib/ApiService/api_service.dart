import 'dart:async';
import "package:dio/dio.dart";



class HttpService{
 late Dio _dio;



  HttpService(){
    _dio = Dio();

    initializeInterceptors();
  }


  Future<Response> getRequest(String endPoint) async{
    Response response;

    try {
      response = await _dio.get(endPoint


      );
    } on DioError catch (e) {
      print(e.message);
      throw Exception(e.message);
    }

    return response;

  }

 Future<Response> postRequest(String url, {data,
   Options? options,

 }) async{
   Response response;

   try {
     response = await _dio.post(url,
     data: data, options: options
     );
   } on DioError catch (e) {
     print(e.message);
     throw Exception(e.message);
   }

   return response;

 }


  initializeInterceptors(){
    _dio.interceptors.add(
        InterceptorsWrapper(
          onError: (e, handler) => print(e.message),
          onRequest: (request, handler) => print("${request.method} ${request.path}"),
          onResponse:  (response, handler) => print(response.data),



    ));
  }
}
