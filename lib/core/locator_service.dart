import 'package:get_it/get_it.dart';
import 'package:hotel_ma/core/platform/network_info.dart';
import 'package:hotel_ma/feature/data/datasources/shared_preferences_methods.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;

void setup() async{
  /// Core
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfo(locator()));
  locator.registerLazySingleton<PersonStatus>(
          () => PersonStatus(sharedPreferences: locator()));

  /// External
  SharedPreferences preferences = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => preferences);
  locator.registerLazySingleton(() => InternetConnectionChecker());
}
