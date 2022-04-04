import 'package:flutter/material.dart';

import '../../../common/app_constants.dart';

class CalendarButton extends StatelessWidget {
  const CalendarButton({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 47,
        width: double.infinity,
        child: TextButton(
          onPressed: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.calendar_today_outlined,
                color: kMainGreyColor,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(text, style: const TextStyle(color: kMainGreyColor, fontFamily: 'Inter', fontSize: 16, fontWeight: FontWeight.w400)),
            ],
          ),
          style: ElevatedButton.styleFrom(
              primary: Theme.of(context).primaryColorLight, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kEdgeMainBorder))),
        ),
      ),
    );
  }
}
