import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular_mobx/application/authentication/auth_controller/auth_store.dart';
import 'package:flutter_modular_mobx/core/widgets/loading.dart';
import 'widgets/login_text_field_section.dart';
import 'package:provider/provider.dart';

class AuthenticationView extends StatefulWidget {
  const AuthenticationView({Key? key}) : super(key: key);

  @override
  _AuthenticationViewState createState() => _AuthenticationViewState();
}

class _AuthenticationViewState extends State<AuthenticationView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff21254A),
      body: SingleChildScrollView(
        child: Consumer<AuthStore>(builder: (_, auth, __) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 200,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      child: Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/images/1.png"),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Observer(
                      builder: (_) => Text(
                        auth.isLogin
                            ? "Hello there, \nwelcome back"
                            : "Create account",
                        style: const TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.transparent,
                      ),
                      child: Form(
                        key: _formKey,
                        child: const LoginTextFieldSection(
                          isLogin: true,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Observer(builder: (context) {
                      return Center(
                        child: TextButton(
                          child: Observer(builder: (_) {
                            switch (auth.state) {
                              case StoreStateLog.initial:
                                return Text(
                                  auth.isLogin ? "Login" : "Register",
                                  style: const TextStyle(color: Colors.white),
                                );
                              case StoreStateLog.loading:
                                return const Loading();
                              case StoreStateLog.loaded:
                                return const Text('done');
                            }
                          }),
                          onPressed: auth.isFormValid
                              ? () {
                                  auth.loginOrRegister();
                                  Modular.to.pushNamed('/homeScreen');
                                }
                              : null,
                          style: TextButton.styleFrom(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              backgroundColor: Colors.blueGrey),
                        ),
                      );
                    }),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          auth.switchAuthMode();
                        },
                        child: Observer(
                          builder: (_) => Text(
                            auth.isLogin ? "Create Account" : "Login",
                            style: TextStyle(
                              color: Colors.pink[200],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
