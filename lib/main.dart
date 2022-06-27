import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_ma/common/app_themes.dart';
import 'package:hotel_ma/core/firebase_config_hotel.dart';
import 'package:hotel_ma/core/locator_service.dart';
import 'package:hotel_ma/feature/data/models/user_model.dart';
import 'package:hotel_ma/feature/data/repositories/auth_repository.dart';
import 'package:hotel_ma/feature/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:hotel_ma/feature/presentation/bloc/rooms_bloc/rooms_bloc.dart';
import 'package:hotel_ma/feature/presentation/screens/onboarding.dart';
import 'feature/presentation/bloc/login_phone_cubit/login_phone_cubit.dart';
import 'feature/presentation/bloc/office_bloc/office_bloc.dart';
import 'feature/presentation/bloc/service_rent_bloc/service_rent_bloc.dart';
import 'feature/presentation/screens/router_screen.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:intl/date_symbol_data_local.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FireBase.initialize();
  await setup();
  UserModel.updateUser();
  initializeDateFormatting();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthenticationRepository authenticationRepository = AuthenticationRepository();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => locator<RoomsBloc>()),
        BlocProvider(create: (context) => locator<AuthBloc>()..add(AuthUserChangedEvent(authenticationRepository.currentUser))),
        BlocProvider(create: (context) => locator<LoginPhoneCubit>()),
        BlocProvider(create: (context) => locator<ServiceRentBloc>()),
        BlocProvider(create: (context) => locator<OfficeBloc>()..add(OfficeCheckoutEvent())),
      ],
      child: MaterialApp(
          builder: BotToastInit(),
          navigatorObservers: [BotToastNavigatorObserver()],
          debugShowCheckedModeBanner: false,
          title: 'Hotel App',
          themeMode: ThemeMode.system,
          theme: MyThemes.lightTheme,
          darkTheme: MyThemes.darkTheme,
          // home: const RouterScreen(
          //   page: null,
          // )),
    home: Onboarding()),
    );
  }
}
