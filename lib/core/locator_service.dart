import 'package:get_it/get_it.dart';
import 'package:hotel_ma/core/platform/network_info.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final locator = GetIt.instance;

void setup() {
  /// Core
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfo(locator()));
  // locator.registerLazySingletonAsync<NetworkInfo>(() async{
  //   final networkInfo = NetworkInfoImpl(locator());
  //   networkInfo.isConnected;
  //   return networkInfo;
  // });

  /// External
  locator.registerLazySingleton(() => InternetConnectionChecker());
}
