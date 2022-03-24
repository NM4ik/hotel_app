import 'package:flutter/material.dart';

import '../../common/app_constants.dart';
import '../components/room_screen_components/filters.dart';
import '../components/room_screen_components/header.dart';

class RoomScreen extends StatelessWidget {
  const RoomScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kEdgeHorizontalPadding, vertical: kEdgeVerticalPadding),
          child: Column(
            children: const [
              Header(),
              SizedBox(height: kEdgeVerticalPadding,),
              Filters(),
            ],
          ),
        ),
      ),
    ));
  }
}
