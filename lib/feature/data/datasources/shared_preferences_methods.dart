import 'package:shared_preferences/shared_preferences.dart';

class PersonStatus{
  final SharedPreferences sharedPreferences;

  PersonStatus({required this.sharedPreferences});

  bool? getAuthStatus () {
    bool? value = sharedPreferences.getBool('authStatus');
    return value;
  }

  void setStatus(bool value){
    value == true ? sharedPreferences.setBool('authStatus', true) : sharedPreferences.setBool('authStatus', false);
  }

}