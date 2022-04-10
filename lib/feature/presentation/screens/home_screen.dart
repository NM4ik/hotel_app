import 'dart:developer';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:hotel_ma/common/app_icons.dart';
import 'package:hotel_ma/core/locator_service.dart';
import 'package:hotel_ma/feature/data/datasources/shared_preferences_methods.dart';
import 'package:hotel_ma/feature/presentation/screens/chat_screen.dart';

import 'package:hotel_ma/feature/presentation/screens/main_screen.dart';
import 'package:hotel_ma/feature/presentation/screens/office_screen.dart';
import 'package:hotel_ma/feature/presentation/screens/profile_screen.dart';
import 'package:hotel_ma/feature/presentation/screens/room_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPageIndex = 0;
  PersonStatus personStatus = PersonStatus(sharedPreferences: locator.get());


  @override
  void initState() {
    super.initState();
    log(personStatus.getAuthStatus().toString(), name: 'STATUS');
  }

  final screens = [
    MainScreen(),
    const RoomScreen(),
    const OfficeScreen(),
    const ChatScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: PageTransitionSwitcher(
        transitionBuilder: (child, primaryAnimation, secondaryAnimation) => FadeThroughTransition(
          animation: primaryAnimation,
          secondaryAnimation: secondaryAnimation,
          child: child,
        ),
        child: screens[currentPageIndex],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black,
              blurRadius: 200,
              spreadRadius: -32,
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          currentIndex: currentPageIndex,
          onTap: (index) => setState(() => currentPageIndex = index),
          selectedItemColor: const Color(0xFFADADAD),
          unselectedItemColor: Colors.black12,
          items: const [
            BottomNavigationBarItem(icon: Icon(CustomIcons.home), label: "Главная"),
            BottomNavigationBarItem(icon: Icon(CustomIcons.rooms), label: "Номера"),
            BottomNavigationBarItem(icon: Icon(CustomIcons.services), label: "Кабинет"),
            BottomNavigationBarItem(icon: Icon(CustomIcons.chat), label: "Чат"),
            BottomNavigationBarItem(icon: Icon(CustomIcons.profile), label: "Профиль"),
          ],
        ),
      ),
    );
  }
}
