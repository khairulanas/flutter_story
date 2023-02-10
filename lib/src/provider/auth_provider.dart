import 'package:flutter/material.dart';

import 'package:flutter_story/src/core/data/repository.dart';
import 'package:flutter_story/src/core/domain/entities/user_entity.dart';

class AuthProvider extends ChangeNotifier {
  final Repository authRepository;

  AuthProvider(this.authRepository);

  bool isLoadingLogin = false;
  bool isLoadingLogout = false;
  bool isLoadingRegister = false;
  bool isLoggedIn = false;
  String? errMessage;
  late UserEntity userData;

  Future<bool> register(String email, String name, String password) async {
    isLoadingRegister = true;
    notifyListeners();

    final res = await authRepository.register(
        name: name, email: email, password: password);

    return res.fold((l) {
      isLoadingRegister = false;
      errMessage = l.message;
      notifyListeners();
      return false;
    }, (r) {
      isLoadingRegister = false;
      notifyListeners();
      return true;
    });
  }

  Future<bool> login(String email, String password) async {
    isLoadingLogin = true;
    notifyListeners();

    final res = await authRepository.login(email, password);
    res.fold((l) {
      isLoggedIn = false;
      errMessage = l.message;
    }, (r) {
      isLoggedIn = true;
      userData = r;
    });

    isLoadingLogin = false;
    notifyListeners();

    return isLoggedIn;
  }

  Future<bool> logout() async {
    isLoadingLogout = true;
    notifyListeners();

    final logout = await authRepository.logout();
    logout.fold((l) {
      errMessage = l.message;
    }, (r) => null);
    isLoggedIn = authRepository.isLoggedIn()!;

    isLoadingLogout = false;
    notifyListeners();

    return !isLoggedIn;
  }

  bool loadUserData() {
    final res = authRepository.getLoginData();
    return res.fold((l) {
      errMessage = l.message;
      notifyListeners();
      return false;
    }, (r) {
      userData = r;
      notifyListeners();
      return true;
    });
  }
}
