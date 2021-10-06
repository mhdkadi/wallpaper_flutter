// ignore_for_file: avoid_print

// import 'dart:async';

// import "package:dio/dio.dart";

// class HttpService {
//   final Dio _dio = Dio();

//   Future<Response> getRequest(String endPoint) async {
//     Response response;

//     try {
//       response = await _dio.get(endPoint);
//     } on DioError catch (e) {
//       print(e.message);
//       throw Exception(e.message);
//     }

//     return response;
//   }

//   Future<Response> postRequest(
//     String url, {
//     data,
//     Options? options,
//   }) async {
//     Response response;

//     try {
//       response = await _dio.post(
//           "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyBi40rU6t_U-LA_OM1H3J9T0G5NS_0ePz0",
//           data: {
//             'email': 'muhammaf@gmail.com',
//             'password': 'wdsdasdsa',
//             'returnSecureToken': true,
//           },
//           options: Options(headers: {'Content-Type': 'application/json'}));
//       print(response.data);
//     } on DioError catch (e) {
//       print(e.message);
//       throw Exception(e.message);
//     }

//     return response;
//   }

//   Future<void> post() async {
//     Response response;
//     try {
//       response = await _dio.post(
//           "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyDAqidPTcelLXRsOk1XCpBFZ_hqgYXb0Y0",
//           data: {
//             'email': 'muhammaf@gmail.com',
//             'password': 'wdsdasdsa',
//             'returnSecureToken': true,
//           },
//           options: Options(headers: {'Content-Type': 'application/json'}));
//       print(response.data);
//     } on DioError catch (e) {
//       print(e.message);
//     }
//   }
// }
