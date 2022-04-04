import 'package:flutter/material.dart';

import '../../../common/app_constants.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({Key? key, required this.press}) : super(key: key);
  final VoidCallback press;

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
          child: const Text(
            "Далее",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, fontFamily: "Inter"),
          )),
    );
  }
}
