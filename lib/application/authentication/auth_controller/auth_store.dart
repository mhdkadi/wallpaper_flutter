// ignore_for_file: avoid_print

import 'package:flutter_modular_mobx/application/authentication/auth_controller/auth_controller.dart';
import 'package:flutter_modular_mobx/application/authentication/auth_model/user_model.dart';
import 'package:mobx/mobx.dart';
part 'auth_store.g.dart';

class AuthStore extends _AuthStore with _$AuthStore {
  AuthStore(AuthController authController) : super(authController);
}

enum StoreStateLog { initial, loading, loaded }
enum AuthState { initial, loading, loaded }

abstract class _AuthStore with Store {
  final AuthController authController;

  _AuthStore(this.authController);
  @observable
  String confirmPassword = '';

  @observable
  String email = '';

  @observable
  User? userInformation;

  @observable
  bool isLogin = true;

  @observable
  bool isAuth = false;

  @observable
  ObservableFuture<bool>? isAuthFuture;

  @observable
  String password = '';

  @observable
  ObservableFuture<User>? _userInformation;

  @action
  void switchAuthMode() => isLogin = !isLogin;

  @action
  void setConfirmPassword(String value) => confirmPassword = value;

  @action
  void setEmail(String value) => email = value;

  @action
  void setPassword(String value) => password = value;

  @computed
  bool get isEmailValid =>
      RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  @computed
  bool get isPasswordValid => password.length > 5;
  @computed
  bool get isConfirmPasswordValid => password == confirmPassword;
  @computed
  bool get isFormValid {
    if (isLogin) {
      return isEmailValid && isPasswordValid;
    } else {
      return isEmailValid && isPasswordValid && isConfirmPasswordValid;
    }
  }

  @computed
  StoreStateLog get state {
    if (_userInformation == null ||
        _userInformation!.status == FutureStatus.rejected) {
      return StoreStateLog.initial;
    }
    return _userInformation!.status == FutureStatus.pending
        ? StoreStateLog.loading
        : StoreStateLog.loaded;
  }

  @action
  Future loginOrRegister() async {
    try {
      if (isLogin) {
        _userInformation =
            ObservableFuture(authController.login(email, password));
      } else {
        _userInformation =
            ObservableFuture(authController.signup(email, password));
      }
      userInformation = await _userInformation;
    } catch (e) {
      print('loginOrRegister $e');
    }
  }

  @action
  Future autoLogIn() async {
    try {
      isAuthFuture = ObservableFuture(authController.isAuth);

      isAuth = (await isAuthFuture)!;
      print(isAuth);
    } catch (e) {
      print('isAuthController $e');
    }
  }

  @action
  Future logOut() async {
    authController.logout();
    isAuth = false;
  }

  @computed
  AuthState get authState {
    if (isAuthFuture == null || isAuthFuture!.status == FutureStatus.rejected) {
      return AuthState.initial;
    }
    return isAuthFuture!.status == FutureStatus.pending
        ? AuthState.loading
        : AuthState.loaded;
  }
}
