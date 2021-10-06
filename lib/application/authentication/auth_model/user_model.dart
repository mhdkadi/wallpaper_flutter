import 'dart:async';

class User {
  final String token;
  final DateTime expireDate;
  final String userId;
  final Timer authTimer;
  final String refreshToken;

  User(
      {required this.token,
      required this.expireDate,
      required this.userId,
      required this.authTimer,
      required this.refreshToken});
}
