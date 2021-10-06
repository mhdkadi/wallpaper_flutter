import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_modular_mobx/application/authentication/auth_model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_modular_mobx/core/api_services/api_services.dart';

class AuthController {
  String? _token = '';
  DateTime? _expireDate;
  String? _userId;
  Timer? _authTimer;
  String? _refreshToken;
  final firebaseBaseUrl = "https://identitytoolkit.googleapis.com/v1/";
  final firebaseApikey = "AIzaSyDAqidPTcelLXRsOk1XCpBFZ_hqgYXb0Y0";
  ApiServices client;
  AuthController({required this.client});
  Future<User> _authenticate(
      String email, String password, String urlSegment) async {
    try {
      final response = await client.postRequest(
        data: {
          'email': email,
          'password': password,
          'returnSecureToken': true,
        },
        options: Options(headers: {'Content-Type': 'application/json'}),
        queryParameters: {"key": firebaseApikey},
        url: firebaseBaseUrl + urlSegment,
      );

      final data = response.data;
      _token = data['idToken'];
      _userId = data['localId'];
      _refreshToken = data['refreshToken'];
      _expireDate = DateTime.now().add(Duration(
        seconds: int.parse(data['expiresIn']),
      ));
      _autoLogout();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'refresh_token': _refreshToken,
        'expireDate': _expireDate!.toIso8601String(),
        'userId': _userId,
      });

      prefs.setString('userData', userData);
      return User(
          token: _token!,
          expireDate: _expireDate!,
          userId: _userId!,
          authTimer: _authTimer!,
          refreshToken: _refreshToken!);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> refreshSession() async {
    try {
      final response = await client.postRequest(
        data: {
          'grant_type': 'refresh_token',
          'refresh_token': _refreshToken,
        },
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/x-www-form-urlencoded'
          },
        ),
        queryParameters: {"key": firebaseApikey},
        url: firebaseBaseUrl + 'token',
      );
      final responseData = response.data;
      if (responseData['error'] != null) {
        throw Exception(responseData['error']['message']);
      }
      _token = responseData['id_token'];
      _refreshToken = responseData['refresh_token'];

      _expireDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expires_in'])));

      _autoLogout();

      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'refresh_token': _refreshToken,
        'userId': _userId,
        'expireDate': _expireDate!.toIso8601String(),
      });
      prefs.setString('userData', userData);
      return true;
    } catch (error) {
      return false;
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

  Future<User> signup(
    String? email,
    String? password,
  ) async {
    return _authenticate(email!, password!, 'accounts:signUp');
  }

  Future<User> login(
    String? email,
    String? password,
  ) async {
    return _authenticate(email!, password!, 'accounts:signInWithPassword');
  }

  Future<void> getSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('userData')) {
      final extractedUserData =
          json.decode(prefs.getString('userData')!) as Map<String, dynamic>;

      final expireDate =
          DateTime.parse(extractedUserData['expireDate'].toString());
      _token = extractedUserData['token'].toString();
      _refreshToken = extractedUserData['refresh_token'].toString();
      _userId = extractedUserData['userId'].toString();
      _expireDate = expireDate;
    }
  }

  Future<bool> get isAuth async {
    await getSharedPreferences();
    bool doneRefresh = false;
    if (_expireDate != null && _token != null && _refreshToken != null) {
      if (_expireDate!.isAfter(DateTime.now())) {
        return true;
      } else {
        refreshSession().then((value) => doneRefresh = value);
        if (doneRefresh) {
          return true;
        } else {
          return false;
        }
      }
    } else {
      return false;
    }
  }

  String? get token {
    if (_token != '' && _expireDate!.isAfter(DateTime.now())) return _token;

    return null;
  }

  Future<void> logout() async {
    _token = null;
    _refreshToken = null;
    _userId = null;
    _expireDate = null;
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userData');
  }
}
