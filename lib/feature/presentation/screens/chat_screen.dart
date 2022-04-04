import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:hotel_ma/common/app_constants.dart';
import 'package:hotel_ma/feature/presentation/screens/conversation_screen.dart';
import 'package:hotel_ma/feature/presentation/screens/faq_screen.dart';
import 'package:hotel_ma/feature/presentation/screens/product_screen.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  final String imageRoot = "assets/images/car_2.png";

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

            SizedBox(
              height: 110,
              child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => _cardWidget(context, index),
                  separatorBuilder: (context, index) => const SizedBox(
                        width: 15,
                      ),
                  itemCount: 6),
            ),

            const SizedBox(
              height: kEdgeVerticalPadding / 2,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ConversationScreen()));
              },

              child: Card(
                margin: EdgeInsets.zero,
                color: Colors.transparent,
                elevation: 0,
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: Container(
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
                      title: Text('Поддержка', style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 16)),
                      subtitle: Text(
                        'Какое-то непрочитанное с...',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 12),
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _cardWidget(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  FaqScreen(index: index, imageRoot: imageRoot),));

      },
      child: SizedBox(
        width: 74,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(kEdgeMainBorder),
              child: Image.asset(
                imageRoot,
                fit: BoxFit.cover,
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
      ),
    );
  }
}
