import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular_mobx/application/authentication/auth_repository/auth_repository.dart';
import 'package:flutter_modular_mobx/application/authentication/auth_store/auth_store.dart';
import 'package:flutter_modular_mobx/application/authentication/authentication_view/widgets/login_text_field_section.dart';

class AuthenticationView extends StatefulWidget {
  const AuthenticationView({Key? key}) : super(key: key);

  @override
  _AuthenticationViewState createState() => _AuthenticationViewState();
}

class _AuthenticationViewState extends State<AuthenticationView> {
  AuthStore? _authStore;
  @override
  void initState() {
    AuthRepository authRepository = AuthRepository();
    AuthStore _authStore = AuthStore(authRepository:  authRepository);
    super.initState();
    _authStore.setupValidations();
  }

  @override
  void dispose() {
    _authStore!.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        //   resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xff21254A),
        body: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
              Container(
                  height: 200,
                  child: Stack(children: <Widget>[
                    Positioned(
                        child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/images/1.png"),
                    ))))
                  ])),
              SizedBox(
                height: 20,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Observer(
                          builder:(_)=> Text(_authStore!.isLogin?"Hello there, \nwelcome back":"Create account",
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.transparent,
                            ),
                            child: Form(
                               child: Observer(builder:(_)=> LoginTextFieldSection(isLogin: _authStore!.isLogin,authStore: _authStore,)))),

                        SizedBox(
                          height: 20.0,
                        ),
                        Center(
                          child: TextButton(
                            child: Observer(
                              builder:(_)=> Text(
                                _authStore!.isLogin? "Login":"Register",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            onPressed: ()=>_authStore!.validateAll(),
                            style: TextButton.styleFrom(
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                backgroundColor: Colors.blueGrey),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Center(
                          child: TextButton(
                              onPressed: (){
                            _authStore!.switchAuthMode();
                              },
                              child: Observer(
                                builder:(_)=> Text(_authStore!.isLogin?"Create Account":"Login",
                                    style: TextStyle(
                                      color: Colors.pink[200],
                                    )),
                              )),
                        )
                      ]))
            ])));
  }
}
