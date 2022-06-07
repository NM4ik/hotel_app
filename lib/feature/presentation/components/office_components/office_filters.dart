import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_ma/core/locator_service.dart';
import 'package:hotel_ma/core/platform/network_info.dart';
import 'package:hotel_ma/feature/data/models/room_type_model.dart';
import 'package:hotel_ma/feature/data/repositories/auth_repository.dart';
import 'package:hotel_ma/feature/presentation/bloc/rooms_bloc/rooms_bloc.dart';
import 'package:hotel_ma/feature/presentation/widgets/calendar_button_widget.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../../../common/app_constants.dart';
import '../../../data/models/room_model.dart';
import '../../widgets/default_text_field_widget.dart';
import '../../widgets/square_button_widget.dart';

class OfficeFilters extends StatefulWidget {
  const OfficeFilters({Key? key, required this.changeDateTime, required this.dateTimeFirst, required this.dateTimeSecond}) : super(key: key);
  final Function changeDateTime;
  final DateTime dateTimeFirst;
  final DateTime dateTimeSecond;

  @override
  State<OfficeFilters> createState() => _OfficeFiltersState();
}

class _OfficeFiltersState extends State<OfficeFilters> {
  late DateFormat dateFormat;

  @override
  void initState() {
    initializeDateFormatting();
    dateFormat = DateFormat.MMMEd("ru");
    super.initState();
  }

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

  DateTime now = DateTime.now();
  late DateTime dateTimeFirst = widget.dateTimeFirst;

  // late DateTime dateTimeSecond = dateTimeFirst.add(const Duration(days: 1));
  late DateTime dateTimeSecond = widget.dateTimeSecond;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // CalendarButtonWidget(
        //   text: dateFormat.format(dateTimeFirst),
        //   changeDateTime: changeDateTimeFirst,
        //   initialDate: dateTimeFirst,
        // ),
        //
        // /// refactor, https://gallery.flutter.dev/ = find calendar picker
        // const SizedBox(
        //   width: kEdgeHorizontalPadding,
        // ),
        // CalendarButtonWidget(text: dateFormat.format(dateTimeSecond), changeDateTime: changeDateTimeSecond, initialDate: dateTimeSecond),
      ],
    );
  }
}
