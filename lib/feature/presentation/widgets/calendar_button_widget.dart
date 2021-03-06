import 'package:flutter/material.dart';

import '../../../common/app_constants.dart';

class CalendarButtonWidget extends StatefulWidget {
  const CalendarButtonWidget({Key? key, required this.text,  required this.changeDateTime, required this.initialDateRange})
      : super(key: key);
  final String text;
  final Function changeDateTime;
  // final DateTime initialDate;
  final DateTimeRange initialDateRange;

  @override
  State<CalendarButtonWidget> createState() => _CalendarButtonWidgetState();
}

class _CalendarButtonWidgetState extends State<CalendarButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 47,
        width: double.infinity,
        child: TextButton(
          onPressed: () async {
            // DateTime? newDate = await showDatePicker(
            //     context: context, initialDate: widget.initialDate, firstDate: DateTime.now(), lastDate: DateTime.now().add(const Duration(days: 365)));

            DateTimeRange? _dateTimeRange = await showDateRangePicker(
                context: context,
                initialDateRange: widget.initialDateRange,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365)));

            if (_dateTimeRange == null) return;

            widget.changeDateTime(_dateTimeRange);

            // setState(() => dateTimeRange = _dateTimeRange);

            // if (newDate == null) return;
            //
            // widget.changeDateTime(newDate);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Expanded(
                flex: 1,
                child: Icon(
                  Icons.calendar_today_outlined,
                  color: kMainGreyColor,
                ),
              ),
              Expanded(
                  flex: 3,
                  child: Text(widget.text.toString(), style: const TextStyle(color: kMainGreyColor, fontFamily: 'Inter', fontSize: 16, fontWeight: FontWeight.w400))),
            ],
          ),
          style: ElevatedButton.styleFrom(
              primary: Theme.of(context).primaryColorLight, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kEdgeMainBorder))),
        ),
      ),
    );
  }
}
