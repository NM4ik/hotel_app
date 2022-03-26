import 'package:flutter/material.dart';
import 'package:hotel_ma/feature/widgets/calendar_button.dart';

import '../../../common/app_constants.dart';
import '../../widgets/default_text_field.dart';
import '../../widgets/square_button.dart';

class Filters extends StatelessWidget {
  const Filters({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: kEdgeVerticalPadding,),

        Row(
          children: [
            Expanded(child: DefaultTextField(text: 'Поиск по номерам', textEditingController: TextEditingController())),
            const SizedBox(
              width: kEdgeHorizontalPadding,
            ),
            SquareButton(color: Theme.of(context).primaryColorLight, icon: Icons.settings, iconColor: const Color(0xFFBDBDBD)),
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
