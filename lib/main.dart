import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_ma/common/app_themes.dart';
import 'package:hotel_ma/core/firebase.dart';
import 'package:hotel_ma/core/locator_service.dart';
import 'package:hotel_ma/feature/data/repositories/auth_repository.dart';
import 'package:hotel_ma/feature/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:hotel_ma/feature/presentation/bloc/rooms_bloc/rooms_bloc.dart';
import 'feature/presentation/bloc/booking_bloc/booking_bloc.dart';
import 'feature/presentation/bloc/login_phone_cubit/login_phone_cubit.dart';
import 'feature/presentation/screens/router_screen.dart';
import 'package:flutter_stripe/flutter_stripe.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = "pk_test_51KzoBqB80MaXbORHYNqCSCaseL5WbwEXhmRc5povmp9iKtA1F2ABQBKjRWngW1LAHvAupIZSvAHfPpC07jf4qDNy00uZm3cdQI";
  await FireBase.initialize();
  await setup();
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
        BlocProvider(create: (context) => locator<BookingBloc>()),
      ],
      child: MaterialApp(
          builder: BotToastInit(),
          navigatorObservers: [BotToastNavigatorObserver()],
          debugShowCheckedModeBanner: false,
          title: 'Hotel App',
          themeMode: ThemeMode.system,
          theme: MyThemes.lightTheme,
          darkTheme: MyThemes.darkTheme,
          home: const RouterScreen(
            page: null,
          )),
    );
  }
}
