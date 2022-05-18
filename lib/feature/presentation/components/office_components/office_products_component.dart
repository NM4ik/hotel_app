import 'package:flutter/material.dart';

import '../../widgets/default_appbar_widget.dart';

class OfficeProductComponent extends StatefulWidget {
  const OfficeProductComponent({Key? key, required this.type}) : super(key: key);
  final String type;

  @override
  _OfficeProductComponentState createState() => _OfficeProductComponentState();
}

class _OfficeProductComponentState extends State<OfficeProductComponent> {
  DateTime dateTimeFirst = DateTime.now();
  late DateTime dateTimeSecond = dateTimeFirst.add(const Duration(days: 1));

  void getDateValues(DateTime dateTimeFirst, DateTime dateTimeSecond) {
    setState(() {
      this.dateTimeFirst = dateTimeFirst;
      this.dateTimeSecond = dateTimeSecond;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: widget.type,
      ),
    );
  }
}
