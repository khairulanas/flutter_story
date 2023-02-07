import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final Function() onLogin;
  final Function() onRegister;

  const LoginScreen({
    Key? key,
    required this.onLogin,
    required this.onRegister,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LoginScreen'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("LoginScreen"),
          TextButton(
            onPressed: onLogin,
            child: const Text("onLogin"),
          ),
          TextButton(
            onPressed: onRegister,
            child: const Text("onRegister"),
          ),
        ],
      ),
    );
  }
}
