import 'package:flutter_story/src/core/data/model/common_response.dart';
import 'package:flutter_story/src/core/data/model/login_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDatasource {
  final SharedPreferences sharedPreferences;

  LocalDatasource(this.sharedPreferences);

  Future<CommonResponse> saveLoginData(
      String userId, String name, String token) async {
    final isLoginSaved = await sharedPreferences.setBool("isLogin", true);
    final isUserIdSaved = await sharedPreferences.setString("userId", userId);
    final isNameSaved = await sharedPreferences.setString("name", name);
    final isTokenSaved = await sharedPreferences.setString("token", token);
    if (isLoginSaved && isUserIdSaved && isTokenSaved && isNameSaved) {
      return CommonResponse(false, "success");
    }
    throw Exception("fail to save data login");
  }

  Future<LoginResult> getLoginData(String name, String token) async {
    final isLogin = sharedPreferences.getBool("isLogin") ?? false;
    if (!isLogin) {
      throw Exception("user not logged in");
    }
    final userId = sharedPreferences.getString("userId");
    final name = sharedPreferences.getString("name");
    final token = sharedPreferences.getString("token");
    return LoginResult(userId!, name!, token!);
  }

  Future<bool> deleteLoginData() async {
    final isLoginRemoved = await sharedPreferences.remove("isLogin");
    final isUserIdRemoved = await sharedPreferences.remove("userId");
    final isNameRemoved = await sharedPreferences.remove("name");
    final isTokenRemoved = await sharedPreferences.remove("token");
    if (isLoginRemoved && isUserIdRemoved && isTokenRemoved && isNameRemoved) {
      return true;
    }
    throw Exception("fail to remove data login");
  }
}
