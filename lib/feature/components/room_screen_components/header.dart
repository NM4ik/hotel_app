import 'package:flutter/material.dart';
import 'package:hotel_ma/common/app_constants.dart';
import 'package:hotel_ma/feature/widgets/square_button.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            /// avatar
            const SquareButton(color: kMainBlueColor, icon: Icons.no_accounts_outlined, iconColor: Colors.white),


            const SizedBox(
              width: kEdgeHorizontalPadding,
            ),

            /// name

            Text(
              'Никита',
              style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 14, fontWeight: FontWeight.w400),
            )
          ],
        ),
        Row(
          children: [
            const Icon(Icons.keyboard_arrow_down_outlined),
            Text(
              'Русский',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 14),
            ),
            const Icon(Icons.outlined_flag_outlined)
          ],
        )
      ],
    );
  }
}
