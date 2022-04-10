import 'dart:convert';

import 'package:hotel_ma/feature/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonStatus {
  final SharedPreferences sharedPreferences;

  PersonStatus({required this.sharedPreferences});

  bool getAuthStatus() {
    bool? value = sharedPreferences.getBool('authStatus');
    value ??= false;
    return value;
  }

  void setAuthStatus(bool value) {
    value == true ? sharedPreferences.setBool('authStatus', true) : sharedPreferences.setBool('authStatus', false);
  }

  void writePersonToCache(UserModel userModel) {
    String person = jsonEncode(userModel);
    sharedPreferences.setString('personCache', person);
  }


  String? getPersonFromCache(){
    String? json = sharedPreferences.getString('personCache');
    print('Loaded data: $json');
    return json;
  }

  bool? getNotifications() {
    bool? value = sharedPreferences.getBool('notificationStatus');
    value ??= true;
    return value;
  }

  void setNotificationStatus(bool value) {
    sharedPreferences.setBool('notificationStatus', value);
  }
}
