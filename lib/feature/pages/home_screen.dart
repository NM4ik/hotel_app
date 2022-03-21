import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
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
    RoomScreen(),
    OfficeScreen(),
    ChatScreen(),
    ProfileScreen(),
  ];

  dynamic imagePath(int index) => Padding(
        padding: const EdgeInsets.only(bottom: 4.0),
        child: Image.asset("assets/images/item-$index-bottomBar-unselected.png"),
      );

  dynamic imagePath2(int index) => Padding(
        padding: const EdgeInsets.only(bottom: 4.0),
        child: Image.asset("assets/images/item-$index-bottomBar-selected.png"),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: screens[currentPageIndex],
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
          selectedItemColor: Color(0xFFADADAD),
          unselectedItemColor: Color(0xFFADADAD),
          // showSelectedLabels: false,
          // showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(icon: imagePath(1), label: "Главная", activeIcon: imagePath2(1)),
            BottomNavigationBarItem(icon: imagePath(2), label: "Номера", activeIcon: imagePath2(2)),
            BottomNavigationBarItem(icon: imagePath(3), label: "Кабинет", activeIcon: imagePath2(3)),
            BottomNavigationBarItem(icon: imagePath(4), label: "Чат", activeIcon: imagePath2(4)),
            BottomNavigationBarItem(icon: imagePath(5), label: "Профиль", activeIcon: imagePath2(5)),
          ],
        ),
      ),
    );
  }
}
