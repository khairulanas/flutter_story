import 'package:flutter_story/src/core/data/model/common_response.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/login_result.dart';

abstract class LocalDatasource {
  Future<CommonResponse> saveLoginData(LoginResult loginData);
  LoginResult getLoginData();
  Future<bool> deleteLoginData();
  bool? isLoggedIn();
  String getToken();
}

class LocalDatasourceImpl implements LocalDatasource {
  final SharedPreferences sharedPreferences;

  LocalDatasourceImpl(this.sharedPreferences);

  final String isLoginKey = "isLogin";
  final String userIdKey = "userIdKey";
  final String nameKey = "nameKey";
  final String tokenKey = "tokenKey";

  @override
  Future<CommonResponse> saveLoginData(LoginResult loginData) async {
    final isLoginSaved = await sharedPreferences.setBool(isLoginKey, true);
    final isUserIdSaved =
        await sharedPreferences.setString(userIdKey, loginData.userId);
    final isNameSaved =
        await sharedPreferences.setString(nameKey, loginData.name);
    final isTokenSaved =
        await sharedPreferences.setString(tokenKey, loginData.token);
    if (isLoginSaved && isUserIdSaved && isTokenSaved && isNameSaved) {
      return CommonResponse(false, "success");
    }
    throw Exception("fail to save data login");
  }

  @override
  LoginResult getLoginData() {
    final isLogin = sharedPreferences.getBool(isLoginKey) ?? false;
    if (!isLogin) {
      throw Exception("user not logged in");
    }
    final userId = sharedPreferences.getString(userIdKey);
    final name = sharedPreferences.getString(nameKey);
    final token = sharedPreferences.getString(tokenKey);
    return LoginResult(userId!, name!, token!);
  }

  @override
  Future<bool> deleteLoginData() async {
    final isLoginRemoved = await sharedPreferences.remove(isLoginKey);
    final isUserIdRemoved = await sharedPreferences.remove(userIdKey);
    final isNameRemoved = await sharedPreferences.remove(nameKey);
    final isTokenRemoved = await sharedPreferences.remove(tokenKey);
    if (isLoginRemoved && isUserIdRemoved && isTokenRemoved && isNameRemoved) {
      return true;
    }
    throw Exception("fail to remove data login");
  }

  @override
  bool? isLoggedIn() {
    return sharedPreferences.getBool(isLoginKey);
  }

  @override
  String getToken() {
    return sharedPreferences.getString(tokenKey)!;
  }
}
