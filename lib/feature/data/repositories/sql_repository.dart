import 'dart:developer';

import 'package:hotel_ma/feature/data/datasources/sql_methods.dart';
import 'package:hotel_ma/feature/data/models/user_model.dart';

class SqlRepository {
  final SqlMethods sqlMethods;

  SqlRepository({required this.sqlMethods});

  Future<bool> userToSql(UserModel userModel) async{
    return await sqlMethods.writePersonToCache(userModel);
  }

  UserModel getUserFromSql() {
    return sqlMethods.getPersonFromCache();
  }
}
