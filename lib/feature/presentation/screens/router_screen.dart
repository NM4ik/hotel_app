import 'dart:developer';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:hotel_ma/common/app_icons.dart';
import 'package:hotel_ma/core/locator_service.dart';
import 'package:hotel_ma/feature/data/datasources/sql_methods.dart';
import 'package:hotel_ma/feature/presentation/screens/chat_screen.dart';

import 'package:hotel_ma/feature/presentation/screens/home_screen.dart';
import 'package:hotel_ma/feature/presentation/screens/office_screen.dart';
import 'package:hotel_ma/feature/presentation/screens/office_test_screen.dart';
import 'package:hotel_ma/feature/presentation/screens/profile_screen.dart';
import 'package:hotel_ma/feature/presentation/screens/room_screen.dart';
import 'package:hotel_ma/feature/data/repositories/payment_controller.dart';

class RouterScreen extends StatefulWidget {
  const RouterScreen({Key? key, required this.page}) : super(key: key);
  final int? page;

  @override
  State<RouterScreen> createState() => _RouterScreenState();
}

class _RouterScreenState extends State<RouterScreen> {
  int currentPageIndex = 0;
  SqlMethods personStatus = SqlMethods(sharedPreferences: locator.get());

  @override
  void initState() {
    currentPageIndex = widget.page ?? 0;
    super.initState();
    log(personStatus.getAuthStatus().toString(), name: 'STATUS');
  }

  final screens = [
    HomeScreen(),
    const RoomScreen(),
    const OfficeScreen(),
    const ChatScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .scaffoldBackgroundColor,
      body: PageTransitionSwitcher(
        transitionBuilder: (child, primaryAnimation, secondaryAnimation) =>
            FadeThroughTransition(
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
          backgroundColor: Theme
              .of(context)
              .scaffoldBackgroundColor,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          currentIndex: currentPageIndex,
          onTap: (index) =>
              setState(() {
                currentPageIndex = index;
              }),
          selectedItemColor: const Color(0xFFADADAD),
          unselectedItemColor: Colors.black12,
          items: const [
            BottomNavigationBarItem(icon: Icon(CustomIcons.home), label: "??????????????"),
            BottomNavigationBarItem(icon: Icon(CustomIcons.rooms), label: "????????????"),
            BottomNavigationBarItem(icon: Icon(CustomIcons.services), label: "??????????????"),
            BottomNavigationBarItem(icon: Icon(CustomIcons.chat), label: "??????"),
            BottomNavigationBarItem(icon: Icon(CustomIcons.profile), label: "??????????????"),
          ],
        ),
      ),
    );
  }
}
