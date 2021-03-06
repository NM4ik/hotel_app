import 'package:flutter/material.dart';
import 'package:hotel_ma/feature/presentation/widgets/page_animation.dart';

import '../../../common/app_constants.dart';

class HelpTile extends StatelessWidget {
  const HelpTile({Key? key, required this.whereTo, required this.title, required this.icon}) : super(key: key);

  final Widget whereTo;
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kEdgeVerticalPadding/4),
      child: GestureDetector(
        onTap: () => Navigator.of(context).push(createRouteAnimFromBottom(whereTo)),
        child: Row(
          children: [
            Icon(
              icon,
              color: kMainBlueColor,
            ),
            const SizedBox(
              width: 15,
            ),
            Text(title, style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
