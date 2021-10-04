import 'package:flutter/cupertino.dart';
import 'package:flutter_modular_mobx/application/authentication/auth_repository/auth_repository.dart';
import 'package:flutter_modular_mobx/application/authentication/models/user_model.dart';
import 'package:mobx/mobx.dart';
import 'package:validators/validators.dart';
part 'auth_store.g.dart';

class AuthStore extends _AuthStore with _$AuthStore{
  AuthStore({required AuthRepository authRepository}):super(authRepository:  authRepository);
}

enum StoreState{initial, loading, loaded}

abstract class _AuthStore with Store {
  final AuthRepository authRepository;
  late List<ReactionDisposer> _disposers;

  _AuthStore( {required this.authRepository});
  void setupValidations() {
    _disposers = [
      if (!isLogin) reaction((_) => confirmPassword, validateConfirmPassword),
      reaction((_) => email, validateEmail),
      reaction((_) => password, validatePassword)
    ];
  }

  void dispose() {
    _disposers.forEach((d) => d());
  }

  FormErrorState error = FormErrorState();

  @observable
  UserInformation? userInformation;

  @observable
  ObservableFuture<UserInformation>? _userInformation;

  @observable
  String confirmPassword = '';

  @observable
  String email = '';

  @observable
  String password = '';

  @observable
  bool isLogin = true;

  @action
  void setConfirmPassword(String value) => confirmPassword = value;

  @action
  void setEmail(String value) => email = value;

  @action
  void setPassword(String value) => password = value;

  @action
  void validateEmail(String value) =>
      error.email = isEmail(value) ? null : 'Not a valid email';

  @action
  void validatePassword(String value) =>
      error.password = isAlphanumeric(value) && value.length<5 ? null : 'Should be alphaNumeric';

  void validateConfirmPassword(String value) => error.confirmPassword =
      value == password ? null : 'The passwords does not match';

  void validateAll() {
    if (!isLogin)
    validateConfirmPassword(confirmPassword);
    validateEmail(email);
    validateConfirmPassword(confirmPassword);
  }

  @action
  void switchAuthMode() => isLogin = !isLogin;

  @computed
  StoreState get state {
if(_userInformation == null || _userInformation!.status == FutureStatus.rejected )return StoreState.initial;
return _userInformation!.status == FutureStatus.pending ? StoreState.loading : StoreState.loaded;
  }
}



class FormErrorState = _FormErrorState with _$FormErrorState;

abstract class _FormErrorState with Store {
  @observable
  String? confirmPassword;

  @observable
  String? email;

  @observable
  String? password;

  @computed
  bool get loginHasErrors =>
     email != null || password != null;

  @computed
  bool get RegisterHasErrors =>
      confirmPassword != null || email != null || password != null;


}
