import 'package:flutter/material.dart';
import 'package:hotel_ma/common/app_constants.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: kEdgeVerticalPadding, horizontal: kEdgeHorizontalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// title
            Text(
              "Чаты",
              style: Theme.of(context).textTheme.headline1!.copyWith(fontSize: 36),
            ),

            const SizedBox(
              height: kEdgeVerticalPadding,
            ),

            /// FAG BLOCk
            Text(
              "Частые вопросы",
              style: Theme.of(context).textTheme.headline1!.copyWith(fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: kEdgeVerticalPadding / 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _cardWidget(context),
                _cardWidget(context),
                _cardWidget(context),
                _cardWidget(context),
              ],
            ),

            const SizedBox(
              height: kEdgeVerticalPadding,
            ),
            Row(
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: kMainBlueColor,
                    borderRadius: BorderRadius.circular(kEdgeMainBorder),
                  ),
                  child: const Icon(
                    Icons.person_pin,
                    color: Colors.white,
                    size: 35,
                  ),
                ),
                const SizedBox(width: kEdgeVerticalPadding/2,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    Text('Поддержка', style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 16)),
                    const SizedBox(height: kEdgeVerticalPadding/2,),
                    Text('Какое-то непрочитанное с...', style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 12)),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  _cardWidget(BuildContext context) {
    return SizedBox(
      width: 74,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(kEdgeMainBorder)),
            child: Image.asset(
              "assets/images/room_card_example.png",
              fit: BoxFit.fill,
              width: 74,
              height: 74,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            'Как оплатить автомобиль',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText2!.copyWith(fontWeight: FontWeight.w400, fontSize: 11),
          ),
        ],
      ),
    );
  }
}
