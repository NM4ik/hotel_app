import 'package:flutter/material.dart';
import 'package:hotel_ma/core/locator_service.dart';
import 'package:hotel_ma/core/platform/network_info.dart';
import 'package:hotel_ma/feature/presentation/widgets/calendar_button_widget.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../../common/app_constants.dart';
import '../../widgets/default_text_field_widget.dart';
import '../../widgets/square_button_widget.dart';

class Filters extends StatefulWidget {
  const Filters({Key? key}) : super(key: key);

  @override
  State<Filters> createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  var result = false;

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
                  print(await locator.get<NetworkInfo>().getIsConnected());
                },
                child: SquareButtonWidget(color: Theme.of(context).primaryColorLight, icon: Icons.settings, iconColor: const Color(0xFFBDBDBD))),
          ],
        ),
        const SizedBox(
          height: kEdgeHorizontalPadding,
        ),
        Row(
          children: const [
            CalendarButtonWidget(text: 'пн, 8 нояб.'), /// refactor, https://gallery.flutter.dev/ = find calendar picker
            SizedBox(
              width: kEdgeHorizontalPadding,
            ),
            CalendarButtonWidget(text: 'пн, 8 нояб.'),
          ],
        )
      ],
    );
  }
}
