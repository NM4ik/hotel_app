import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:hotel_ma/core/firebase.dart';
import 'package:hotel_ma/core/platform/network_info.dart';
import 'package:hotel_ma/feature/data/datasources/firestore_methods.dart';
import 'package:hotel_ma/feature/data/datasources/sql_methods.dart';
import 'package:hotel_ma/feature/data/repositories/auth_repository.dart';
import 'package:hotel_ma/feature/data/repositories/firestore_repository.dart';
import 'package:hotel_ma/feature/data/repositories/sql_repository.dart';
import 'package:hotel_ma/feature/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:hotel_ma/feature/presentation/bloc/booking_bloc/booking_bloc.dart';
import 'package:hotel_ma/feature/presentation/bloc/login_phone_cubit/login_phone_cubit.dart';
import 'package:hotel_ma/feature/data/repositories/payment_controller.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../feature/presentation/bloc/rooms_bloc/rooms_bloc.dart';

final locator = GetIt.instance;

Future<void> setup() async {
  /// data
  locator.registerLazySingleton<FirestoreMethods>(() => FirestoreMethods());

  /// repo
  locator.registerLazySingleton<AuthenticationRepository>(() => AuthenticationRepository());
  locator.registerLazySingleton<SqlRepository>(() => SqlRepository(sqlMethods: locator()));
  locator.registerLazySingleton<FirestoreRepository>(() => FirestoreRepository(firestoreMethods: locator()));

  /// Bloc & Cubit
  locator.registerFactory(() => RoomsBloc());
  locator.registerFactory(() => LoginPhoneCubit());
  locator.registerFactory(() => AuthBloc(authenticationRepository: locator()));
  locator.registerFactory(() => BookingBloc());

  /// Core
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfo(locator()));
  locator.registerLazySingleton<SqlMethods>(() => SqlMethods(sharedPreferences: locator()));

  /// External
  SharedPreferences preferences = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => preferences);
  locator.registerLazySingleton(() => InternetConnectionChecker());
  locator.registerLazySingletonAsync<FirebaseApp>(() async => await FireBase.initialize());
  locator.registerLazySingleton<PaymentController>(() => PaymentController());
}
