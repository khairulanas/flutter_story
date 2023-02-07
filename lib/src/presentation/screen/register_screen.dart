import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  final Function() onRegister;
  final Function() onLogin;

  const RegisterScreen({
    Key? key,
    required this.onRegister,
    required this.onLogin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RegisterScreen'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("RegisterScreen"),
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
