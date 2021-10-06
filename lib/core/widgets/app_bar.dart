import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular_mobx/application/authentication/auth_controller/auth_store.dart';

AppBar appbar(BuildContext context, AuthStore authStore) {
  return AppBar(
    actions: [
      IconButton(
          onPressed: () {
            authStore.logOut();
            Modular.to.pushReplacementNamed('/authenticationView');
          },
          icon: const Icon(
            Icons.logout,
            color: Colors.blue,
          ))
    ],
    elevation: 0.0,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          width: 25,
        ),
        const Text('Wallpaper'),
        Text(
          'Flutter',
          style: TextStyle(color: Theme.of(context).highlightColor),
        ),
      ],
    ),
  );
}
