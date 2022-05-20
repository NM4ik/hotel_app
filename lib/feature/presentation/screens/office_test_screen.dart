import 'package:flutter/material.dart';
import 'package:hotel_ma/common/app_constants.dart';

class OfficeTestScreen extends StatelessWidget {
  const OfficeTestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: kEdgeVerticalPadding, horizontal: kEdgeHorizontalPadding),
      child: SafeArea(
        child: Text('qwe'),
      ),
    );
  }
}
