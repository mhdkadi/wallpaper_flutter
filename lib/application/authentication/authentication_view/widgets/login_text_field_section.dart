import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular_mobx/application/authentication/auth_store/auth_store.dart';

class LoginTextFieldSection extends StatelessWidget {
  const LoginTextFieldSection(
      {Key? key, required this.isLogin,  this.authStore})
      : super(key: key);
  final isLogin;
  final AuthStore? authStore;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey,
                ),
              ),
            ),
            child: TextFormField(
              style: TextStyle(color: Colors.white),
              onChanged: authStore!.setEmail,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Email",
                errorText: authStore!.error.email,
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey,
                ),
              ),
            ),
            child: TextFormField(
              style: TextStyle(color: Colors.white),
              onChanged: authStore!.setPassword,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Password",
                  errorText: authStore!.error.password,
                  hintStyle: TextStyle(color: Colors.grey)),
            ),
          ),
          Visibility(
            visible: !isLogin,
            child: Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                  ),
                ),
              ),
              child: TextFormField(
                style: TextStyle(color: Colors.white),
                onChanged: authStore!.setConfirmPassword,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Confirm Password",
                    hintStyle: TextStyle(color: Colors.grey),
                    errorText: authStore!.error.confirmPassword
                    //    errorText:
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
