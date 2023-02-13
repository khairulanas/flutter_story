import 'package:flutter/material.dart';
import 'package:flutter_story/src/core/common/localization.dart';
import 'package:flutter_story/src/presentation/widget/dropdown_language.dart';
import 'package:flutter_story/src/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  final Function() onLogin;
  final Function() onRegister;

  const LoginScreen({
    Key? key,
    required this.onLogin,
    required this.onRegister,
  }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.login),
        actions: const [DropdownButtonHideUnderline(child: DropdownLanguage())],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 300),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Text(
                      "Story App",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!
                            .pleaseEnterYourEmail;
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: "Email",
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.password,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!
                            .pleaseEnterYourPassword;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  context.watch<AuthProvider>().isLoadingLogin
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              final scaffoldMessenger =
                                  ScaffoldMessenger.of(context);

                              final authRead = context.read<AuthProvider>();

                              final result = await authRead.login(
                                  emailController.text,
                                  passwordController.text);
                              if (result) {
                                widget.onLogin();
                              } else {
                                scaffoldMessenger.showSnackBar(
                                  SnackBar(
                                    content: Text(authRead.errMessage ?? ""),
                                  ),
                                );
                              }
                            }
                          },
                          child: Text(AppLocalizations.of(context)!.login),
                        ),
                  const SizedBox(height: 8),
                  OutlinedButton(
                    onPressed: () => widget.onRegister(),
                    child: Text(AppLocalizations.of(context)!.register),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
