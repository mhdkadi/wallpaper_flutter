import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_modular_mobx/ApiService/api_service.dart';

class AuthRepository {
  String? _token = '';
  DateTime? _expireDate;
  String? _userId;
  Timer? _authTimer;
  String? _refreshToken;

  HttpService client = HttpService();
  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final String url =
        "https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyAK1H67FVMDZqbHSw8g006PcdT9M1RNHNU";
    try {
      final response = await client.postRequest(url,
          data: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true,
          }));

      final dataString = response.data.toString();
      final data = jsonDecode(dataString);
      _token = data['idToken'];
      _userId = data['localId'];
      _refreshToken = data['refreshToken'];
      _expireDate = DateTime.now().add(Duration(
        seconds: int.parse(data['expiresIn']),
      ));
      print(response.statusCode);
      if (response.statusCode == 403 || response.statusCode == 400) {}
        _autoLogout();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'refresh_token': _refreshToken,
        'expireDate': _expireDate!.toIso8601String(),
        'userId': _userId,
      });
      prefs.setString('userData', userData);
    } catch (e) {
      throw e;
    }
  }

  Future<void> refreshSession() async {
    try {
      final response = await client.postRequest(
          'https://securetoken.googleapis.com/v1/token?key=AIzaSyAK1H67FVMDZqbHSw8g006PcdT9M1RNHNU',
          data: {
            'grant_type': 'refresh_token',
            'refresh_token': _refreshToken,
          },
          options: Options(
            headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/x-www-form-urlencoded'
            },
          ));
      final responseData = json.decode(response.data);
      if (responseData['error'] != null) {
        throw Exception(responseData['error']['message']);
      }
      _token = responseData['id_token'];
      _refreshToken = responseData['refresh_token'];

      _expireDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expires_in'])));
      print('refresh:: $_expireDate');
      _autoLogout();

      // notifyListeners();

      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'refresh_token': _refreshToken,
        'userId': _userId,
        'expireDate': _expireDate!.toIso8601String(),
      });
      prefs.setString('userData', userData);
    } catch (error) {
      throw error;
    }
  }

  void _autoLogout() {
    if (_authTimer != null) _authTimer!.cancel();
    final timeToExpiry = _expireDate!.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), refreshSession);
  }

  Future<bool> autoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) return false;
    final userData2 = prefs.getString('userData').toString();
    final _data2 = jsonDecode(userData2);

    _token = _data2['token'];
    _userId = _data2['userId'];
    _refreshToken = _data2['refresh_token'];
    _expireDate = DateTime.parse(_data2['expireDate']);
    _autoLogout();
    if (_expireDate!.isBefore(DateTime.now())) {
      refreshSession();
    }
    return true;
  }

  Future<void> signup(
      String? email,
      String? password,
      ) async {
    return _authenticate(email!, password!, 'signUp');
  }

  Future<void> login(
      String? email,
      String? password,
      ) async {
    return _authenticate(email!, password!, 'signInWithPassword');
  }

  // bool get isAuth {
  //   return token != null;
  // }
  //
  // String? get token {
  //   if (_token != '' && _expireDate!.isAfter(DateTime.now())) return _token;
  //
  //   return null;
  // }
  //
  // String? get userId {
  //   return _userId;
  // }

}

