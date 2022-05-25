import 'dart:convert';

import 'package:hotel_ma/feature/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SqlMethods {
  final SharedPreferences sharedPreferences;

  SqlMethods({required this.sharedPreferences});

  bool getAuthStatus() {
    bool? value = sharedPreferences.getBool('authStatus');
    value ??= false;
    return value;
  }

  Future<bool> writePersonToCache(UserModel userModel) async{
    String person = jsonEncode(userModel);
    return await sharedPreferences.setString('personCache', person);
  }

  UserModel getPersonFromCache() {
    String? json = sharedPreferences.getString('personCache');
    UserModel userModel = UserModel.empty;
    if (json != null) {
      userModel = UserModel.fromJson(jsonDecode(json));
    }
    return userModel;
  }
}
