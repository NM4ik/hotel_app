import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_ma/common/app_themes.dart';
import 'package:hotel_ma/core/locator_service.dart';
import 'package:hotel_ma/feature/presentation/bloc/profile_bloc/profile_bloc.dart';

import 'feature/presentation/screens/home_screen.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ProfileBloc()),
        // BlocProvider(create: (context) => ChatsCubit(fireStoreMethods)),
        // BlocProvider(create: (context) => ConversationBloc()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Hotel App',
          themeMode: ThemeMode.system,
          theme: MyThemes.lightTheme,
          darkTheme: MyThemes.darkTheme,
          // home: Onboarding());
          // home: HomeScreen());
          home: HomeScreen()),
    );

  }
}
