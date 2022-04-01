import 'package:flutter/material.dart';
import 'package:hotel_ma/feature/components/room_screen_components/card_room.dart';
import 'package:hotel_ma/feature/screens/product_screen.dart';

import '../../common/app_constants.dart';
import '../components/room_screen_components/filters.dart';
import '../components/room_screen_components/header.dart';
import '../widgets/default_text_field.dart';
import '../widgets/square_button.dart';

class RoomScreen extends StatefulWidget {
  const RoomScreen({Key? key}) : super(key: key);

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  final GlobalKey _scaffold = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.only(right: kEdgeHorizontalPadding, left: kEdgeHorizontalPadding, top: kEdgeVerticalPadding),
      child: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            leading: const SquareButton(color: kMainBlueColor, icon: Icons.no_accounts_outlined, iconColor: Colors.white),
            title: Text(
              'Никита',
              style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 14, fontWeight: FontWeight.w400),
            ),
            actions: [
              Row(
                children: [
                  Icon(
                    Icons.keyboard_arrow_down_outlined,
                    color: Theme.of(context).primaryColor,
                  ),
                  Text(
                    'Русский',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 14),
                  ),
                  Icon(
                    Icons.outlined_flag_outlined,
                    color: Theme.of(context).primaryColor,
                  )
                ],
              ),
            ],
          ),

          /// Filters for free rooms
          SliverToBoxAdapter(
            child: Filters(),
          ),

          /// Grid free rooms
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: kEdgeVerticalPadding, bottom: kEdgeVerticalPadding / 2),
              child: Align(
                child: Text(
                  "Доступные номера",
                  style: Theme.of(context).textTheme.headline3,
                ),
                alignment: Alignment.centerLeft,
              ),
            ),
          ),

          // SizedBox(height: kEdgeVerticalPadding/2,),

          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 1.55),
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          _scaffold.currentContext!,
                          MaterialPageRoute(
                              builder: (context) => ProductScreen(
                                    index: index,
                                  )));
                    },
                    child: CardRoom());
              },
              childCount: 5,
            ),
          ),
        ],
      ),
    ));
  }
}
