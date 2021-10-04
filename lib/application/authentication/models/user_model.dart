import 'dart:async';

class UserInformation {
  final String token;
  final DateTime expireDate;
  final String userId;
  final Timer authTimer;
  final String refreshToken;

  UserInformation(
      {required this.token,
      required this.expireDate,
      required this.userId,
      required this.authTimer,
      required this.refreshToken}
      );
}
