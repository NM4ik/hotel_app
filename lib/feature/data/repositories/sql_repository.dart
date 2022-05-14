import 'dart:developer';

import 'package:hotel_ma/feature/data/datasources/sql_methods.dart';
import 'package:hotel_ma/feature/data/models/user_model.dart';

class SqlRepository {
  final SqlMethods sqlMethods;

  SqlRepository({required this.sqlMethods});

  void userToSql(UserModel userModel) {
    log(userModel.toString(), name: "TOSQL");
    sqlMethods.writePersonToCache(userModel);
  }

  UserModel userFromSql() {
    return sqlMethods.getPersonFromCache();
  }
}
