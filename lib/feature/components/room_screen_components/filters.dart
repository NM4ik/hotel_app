import 'package:flutter/material.dart';

import '../../../common/app_constants.dart';
import '../../widgets/default_text_field.dart';
import '../../widgets/square_button.dart';

class Filters extends StatelessWidget {
  const Filters({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: DefaultTextField(text: 'Поиск по номерам', textEditingController: TextEditingController())),
            SizedBox(
              width: 20,
            ),
            SquareButton(color: Theme.of(context).primaryColorLight, icon: Icons.settings, iconColor: Color(0xFFBDBDBD)),
          ],
        )
      ],
    );
  }
}
