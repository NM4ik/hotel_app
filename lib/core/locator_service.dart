import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:hotel_ma/core/firebase.dart';
import 'package:hotel_ma/core/platform/network_info.dart';
import 'package:hotel_ma/feature/data/datasources/firestore_data.dart';
import 'package:hotel_ma/feature/data/datasources/shared_preferences_methods.dart';
import 'package:hotel_ma/feature/data/repositories/auth_repository.dart';
import 'package:hotel_ma/feature/data/repositories/firestore_repository.dart';
import 'package:hotel_ma/feature/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../feature/presentation/bloc/profile_bloc/profile_bloc.dart';
import '../feature/presentation/bloc/rooms_bloc/rooms_bloc.dart';

final locator = GetIt.instance;

Future<void> setup() async {
  /// data
  locator.registerLazySingleton<FirestoreData>(() => FirestoreData());

  /// repo
  locator.registerLazySingleton<AuthenticationRepository>(() => AuthenticationRepository());
  locator.registerLazySingleton<FirestoreRepository>(() => FirestoreRepository(firestoreData: locator()));

  /// Bloc & Cubit
  locator.registerFactory(() => ProfileBloc());
  locator.registerFactory(() => RoomsBloc());
  locator.registerFactory(() => AuthBloc(authenticationRepository: locator()));

  /// Core
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfo(locator()));
  locator.registerLazySingleton<PersonStatus>(() => PersonStatus(sharedPreferences: locator()));

  /// External
  SharedPreferences preferences = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => preferences);
  locator.registerLazySingleton(() => InternetConnectionChecker());
  locator.registerLazySingletonAsync<FirebaseApp>(() async => await FireBase.initialize());
}
