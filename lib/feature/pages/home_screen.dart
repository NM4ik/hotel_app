import 'dart:developer';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:hotel_ma/common/app_icons.dart';
import 'package:hotel_ma/feature/pages/chat_screen.dart';

import 'package:hotel_ma/feature/pages/main_screen.dart';
import 'package:hotel_ma/feature/pages/office_screen.dart';
import 'package:hotel_ma/feature/pages/profile_screen.dart';
import 'package:hotel_ma/feature/pages/room_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPageIndex = 0;

  final screens = [
    MainScreen(),
    const RoomScreen(),
    const OfficeScreen(),
    const ChatScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    log(Theme.of(context).scaffoldBackgroundColor.toString());
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
