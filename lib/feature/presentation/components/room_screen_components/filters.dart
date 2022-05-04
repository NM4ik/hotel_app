import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hotel_ma/core/locator_service.dart';
import 'package:hotel_ma/core/platform/network_info.dart';
import 'package:hotel_ma/feature/data/repositories/auth_repository.dart';
import 'package:hotel_ma/feature/presentation/widgets/calendar_button_widget.dart';
import 'package:intl/intl.dart';

import '../../../../common/app_constants.dart';
import '../../widgets/default_text_field_widget.dart';
import '../../widgets/square_button_widget.dart';

class Filters extends StatefulWidget {
  const Filters({Key? key, required this.changeDateTime, required this.dateTimeFirst, required this.dateTimeSecond}) : super(key: key);
  final Function changeDateTime;
  final DateTime dateTimeFirst;
  final DateTime dateTimeSecond;


  @override
  State<Filters> createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  void changeDateTimeFirst(DateTime? dateTime) {
    if (dateTime == null) return;
    setState(() {
      dateTimeFirst = dateTime;

      if (dateTimeFirst.day >= dateTimeSecond.day) {
        dateTimeSecond = dateTimeFirst.add(const Duration(days: 1));
      }
    });
    widget.changeDateTime(dateTimeFirst, dateTimeSecond);
  }

  void changeDateTimeSecond(DateTime? dateTime) {
    if (dateTime == null) return;
    setState(() {
      dateTimeSecond = dateTime;

      if (dateTimeSecond.day == dateTimeFirst.day) {
        dateTimeFirst = dateTimeSecond.subtract(const Duration(days: 1));
      }
      if (dateTimeSecond.day < dateTimeFirst.day) {
        dateTimeFirst = dateTimeSecond.subtract(const Duration(days: 1));
      }
      widget.changeDateTime(dateTimeFirst, dateTimeSecond);
    });
  }


  var result = false;
  final dateFormat = DateFormat("MMMEd");
  DateTime now = DateTime.now();
  late DateTime dateTimeFirst = widget.dateTimeFirst;
  // late DateTime dateTimeSecond = dateTimeFirst.add(const Duration(days: 1));
  late DateTime dateTimeSecond = widget.dateTimeSecond;


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: kEdgeVerticalPadding,
        ),
        Row(
          children: [
            Expanded(child: DefaultTextFieldWidget(text: 'Поиск по номерам', textEditingController: TextEditingController())),
            const SizedBox(
              width: kEdgeHorizontalPadding,
            ),
            GestureDetector(
                onTap: () async {
                  print(FirebaseAuth.instance.currentUser.toString());
                  BotToast.showSimpleNotification(title: 'qwe');

                },
                child: SquareButtonWidget(color: Theme.of(context).primaryColorLight, icon: Icons.settings, iconColor: const Color(0xFFBDBDBD))),
          ],
        ),
        const SizedBox(
          height: kEdgeHorizontalPadding,
        ),
        const SizedBox(
          height: kEdgeHorizontalPadding,
        ),
        Row(
          children: [
            CalendarButtonWidget(
              text: dateFormat.format(dateTimeFirst),
              changeDateTime: changeDateTimeFirst,
              initialDate: dateTimeFirst,
            ),

            /// refactor, https://gallery.flutter.dev/ = find calendar picker
            const SizedBox(
              width: kEdgeHorizontalPadding,
            ),
            CalendarButtonWidget(text: dateFormat.format(dateTimeSecond), changeDateTime: changeDateTimeSecond, initialDate: dateTimeSecond),
          ],
        )
      ],
    );
  }
}
