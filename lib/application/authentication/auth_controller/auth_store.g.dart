// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AuthStore on _AuthStore, Store {
  Computed<bool>? _$isEmailValidComputed;

  @override
  bool get isEmailValid =>
      (_$isEmailValidComputed ??= Computed<bool>(() => super.isEmailValid,
              name: '_AuthStore.isEmailValid'))
          .value;
  Computed<bool>? _$isPasswordValidComputed;

  @override
  bool get isPasswordValid =>
      (_$isPasswordValidComputed ??= Computed<bool>(() => super.isPasswordValid,
              name: '_AuthStore.isPasswordValid'))
          .value;
  Computed<bool>? _$isConfirmPasswordValidComputed;

  @override
  bool get isConfirmPasswordValid => (_$isConfirmPasswordValidComputed ??=
          Computed<bool>(() => super.isConfirmPasswordValid,
              name: '_AuthStore.isConfirmPasswordValid'))
      .value;
  Computed<bool>? _$isFormValidComputed;

  @override
  bool get isFormValid =>
      (_$isFormValidComputed ??= Computed<bool>(() => super.isFormValid,
              name: '_AuthStore.isFormValid'))
          .value;
  Computed<StoreStateLog>? _$stateComputed;

  @override
  StoreStateLog get state => (_$stateComputed ??=
          Computed<StoreStateLog>(() => super.state, name: '_AuthStore.state'))
      .value;
  Computed<AuthState>? _$authStateComputed;

  @override
  AuthState get authState =>
      (_$authStateComputed ??= Computed<AuthState>(() => super.authState,
              name: '_AuthStore.authState'))
          .value;

  final _$confirmPasswordAtom = Atom(name: '_AuthStore.confirmPassword');

  @override
  String get confirmPassword {
    _$confirmPasswordAtom.reportRead();
    return super.confirmPassword;
  }

  @override
  set confirmPassword(String value) {
    _$confirmPasswordAtom.reportWrite(value, super.confirmPassword, () {
      super.confirmPassword = value;
    });
  }

  final _$emailAtom = Atom(name: '_AuthStore.email');

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  final _$userInformationAtom = Atom(name: '_AuthStore.userInformation');

  @override
  User? get userInformation {
    _$userInformationAtom.reportRead();
    return super.userInformation;
  }

  @override
  set userInformation(User? value) {
    _$userInformationAtom.reportWrite(value, super.userInformation, () {
      super.userInformation = value;
    });
  }

  final _$isLoginAtom = Atom(name: '_AuthStore.isLogin');

  @override
  bool get isLogin {
    _$isLoginAtom.reportRead();
    return super.isLogin;
  }

  @override
  set isLogin(bool value) {
    _$isLoginAtom.reportWrite(value, super.isLogin, () {
      super.isLogin = value;
    });
  }

  final _$isAuthAtom = Atom(name: '_AuthStore.isAuth');

  @override
  bool get isAuth {
    _$isAuthAtom.reportRead();
    return super.isAuth;
  }

  @override
  set isAuth(bool value) {
    _$isAuthAtom.reportWrite(value, super.isAuth, () {
      super.isAuth = value;
    });
  }

  final _$isAuthFutureAtom = Atom(name: '_AuthStore.isAuthFuture');

  @override
  ObservableFuture<bool>? get isAuthFuture {
    _$isAuthFutureAtom.reportRead();
    return super.isAuthFuture;
  }

  @override
  set isAuthFuture(ObservableFuture<bool>? value) {
    _$isAuthFutureAtom.reportWrite(value, super.isAuthFuture, () {
      super.isAuthFuture = value;
    });
  }

  final _$passwordAtom = Atom(name: '_AuthStore.password');

  @override
  String get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  final _$_userInformationAtom = Atom(name: '_AuthStore._userInformation');

  @override
  ObservableFuture<User>? get _userInformation {
    _$_userInformationAtom.reportRead();
    return super._userInformation;
  }

  @override
  set _userInformation(ObservableFuture<User>? value) {
    _$_userInformationAtom.reportWrite(value, super._userInformation, () {
      super._userInformation = value;
    });
  }

  final _$loginOrRegisterAsyncAction =
      AsyncAction('_AuthStore.loginOrRegister');

  @override
  Future<dynamic> loginOrRegister() {
    return _$loginOrRegisterAsyncAction.run(() => super.loginOrRegister());
  }

  final _$autoLogInAsyncAction = AsyncAction('_AuthStore.autoLogIn');

  @override
  Future<dynamic> autoLogIn() {
    return _$autoLogInAsyncAction.run(() => super.autoLogIn());
  }

  final _$logOutAsyncAction = AsyncAction('_AuthStore.logOut');

  @override
  Future<dynamic> logOut() {
    return _$logOutAsyncAction.run(() => super.logOut());
  }

  final _$_AuthStoreActionController = ActionController(name: '_AuthStore');

  @override
  void switchAuthMode() {
    final _$actionInfo = _$_AuthStoreActionController.startAction(
        name: '_AuthStore.switchAuthMode');
    try {
      return super.switchAuthMode();
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setConfirmPassword(String value) {
    final _$actionInfo = _$_AuthStoreActionController.startAction(
        name: '_AuthStore.setConfirmPassword');
    try {
      return super.setConfirmPassword(value);
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setEmail(String value) {
    final _$actionInfo =
        _$_AuthStoreActionController.startAction(name: '_AuthStore.setEmail');
    try {
      return super.setEmail(value);
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPassword(String value) {
    final _$actionInfo = _$_AuthStoreActionController.startAction(
        name: '_AuthStore.setPassword');
    try {
      return super.setPassword(value);
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
confirmPassword: ${confirmPassword},
email: ${email},
userInformation: ${userInformation},
isLogin: ${isLogin},
isAuth: ${isAuth},
isAuthFuture: ${isAuthFuture},
password: ${password},
isEmailValid: ${isEmailValid},
isPasswordValid: ${isPasswordValid},
isConfirmPasswordValid: ${isConfirmPasswordValid},
isFormValid: ${isFormValid},
state: ${state},
authState: ${authState}
    ''';
  }
}
