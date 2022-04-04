import 'package:flutter/material.dart';
import 'package:hotel_ma/core/locator_service.dart';
import 'package:hotel_ma/core/platform/network_info.dart';
import 'package:hotel_ma/feature/presentation/widgets/calendar_button.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../../common/app_constants.dart';
import '../../widgets/default_text_field.dart';
import '../../widgets/square_button.dart';

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
            Expanded(child: DefaultTextField(text: 'Поиск по номерам', textEditingController: TextEditingController())),
            const SizedBox(
              width: kEdgeHorizontalPadding,
            ),
            GestureDetector(
                onTap: () async {
                  print(await locator.get<NetworkInfo>().getIsConnected());
                },
                child: SquareButton(color: Theme.of(context).primaryColorLight, icon: Icons.settings, iconColor: const Color(0xFFBDBDBD))),
          ],
        ),
        const SizedBox(
          height: kEdgeHorizontalPadding,
        ),
        Row(
          children: const [
            CalendarButton(text: 'пн, 8 нояб.'),
            SizedBox(
              width: kEdgeHorizontalPadding,
            ),
            CalendarButton(text: 'пн, 8 нояб.'),
          ],
        )
      ],
    );
  }
}
