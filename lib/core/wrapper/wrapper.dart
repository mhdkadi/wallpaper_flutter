import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular_mobx/application/authentication/auth_controller/auth_store.dart';
import 'package:flutter_modular_mobx/application/authentication/auth_view/authentication_view.dart';
import 'package:flutter_modular_mobx/application/wallpapers/wallpaper_view/home.dart';
import 'package:flutter_modular_mobx/core/widgets/loading.dart';
import 'package:flutter_modular_mobx/core/widgets/no_internet.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthStore>(
      builder: (_, auth, __) {
        return auth.isAuth
            ? const HomePage()
            : Observer(
                builder: (context) {
                  return FutureBuilder(
                    future: auth.autoLogIn(),
                    builder: (context, snapshot) {
                      switch (auth.authState) {
                        case AuthState.initial:
                          return const NoInternetConnection();
                        case AuthState.loading:
                          return const Loading();
                        case AuthState.loaded:
                          return auth.isAuth
                              ? const HomePage()
                              : const AuthenticationView();
                      }
                    },
                  );
                },
              );
      },
    );
  }
}
