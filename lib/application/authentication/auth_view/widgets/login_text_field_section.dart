import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../auth_controller/auth_store.dart';
import 'package:provider/provider.dart';

class LoginTextFieldSection extends StatelessWidget {
  const LoginTextFieldSection({Key? key, required this.isLogin, this.authStore})
      : super(key: key);
  final bool isLogin;
  final AuthStore? authStore;

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthStore>(builder: (_, auth, __) {
      return Observer(
        builder: (_) => Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                  ),
                ),
              ),
              child: TextFormField(
                style: const TextStyle(color: Colors.white),
                onChanged: (value) {
                  auth.setEmail(value);
                },
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Email",
                  // errorText: auth.error.email,
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                  ),
                ),
              ),
              child: TextFormField(
                style: const TextStyle(color: Colors.white),
                onChanged: (value) {
                  auth.setPassword(value);
                },
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Password",
                    //errorText: auth.error.password,
                    hintStyle: TextStyle(color: Colors.grey)),
              ),
            ),
            Visibility(
              visible: !auth.isLogin,
              child: Container(
                padding: const EdgeInsets.all(10.0),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
                child: TextFormField(
                  style: const TextStyle(color: Colors.white),
                  onChanged: (value) {
                    auth.setConfirmPassword(value);
                  },
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Confirm Password",
                    hintStyle: TextStyle(color: Colors.grey),
                    //errorText: auth.error.confirmPassword
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
