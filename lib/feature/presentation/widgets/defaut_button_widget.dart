import 'package:flutter/material.dart';

import '../../../common/app_constants.dart';

class DefaultButtonWidget extends StatelessWidget {
  const DefaultButtonWidget({Key? key, required this.press, required this.title}) : super(key: key);
  final VoidCallback press;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(99)),
            primary: kMainBlueColor,
          ),
          onPressed: press,
          child: Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400, fontFamily: "Inter"),
          )),
    );
  }
}
