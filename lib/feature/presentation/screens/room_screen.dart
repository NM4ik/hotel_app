import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_ma/feature/presentation/bloc/rooms_bloc/rooms_bloc.dart';
import 'package:hotel_ma/feature/presentation/components/room_screen_components/card_room.dart';
import 'package:hotel_ma/feature/presentation/screens/product_screen.dart';

import '../../../common/app_constants.dart';
import '../components/room_screen_components/filters.dart';
import '../components/room_screen_components/header.dart';
import '../components/room_screen_components/rooms_usic_screen.dart';
import '../widgets/default_text_field_widget.dart';
import '../widgets/square_button_widget.dart';

class RoomScreen extends StatefulWidget {
  const RoomScreen({Key? key}) : super(key: key);

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RoomsBloc, RoomsState>(listener: (context, state) {
      // TODO: implement listener
    }, builder: (context, state) {
      if (state is RoomsSICState) {
        return SafeArea(
            child: Padding(
          padding: const EdgeInsets.only(right: kEdgeHorizontalPadding, left: kEdgeHorizontalPadding, top: kEdgeVerticalPadding),
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                leading: const SquareButtonWidget(color: kMainBlueColor, icon: Icons.no_accounts_outlined, iconColor: Colors.white),
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
              /// refactor, https://gallery.flutter.dev/ = find calendar picker
              const SliverToBoxAdapter(
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
                  (gridContext, index) {
                    return GestureDetector(
                        onTap: () {
                          Navigator.of(gridContext).push(MaterialPageRoute(builder: (gridContext) => ProductScreen(index: index)));
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
      if (state is RoomsUSICState) {
        return const RoomsUsicScreen();
      } else {
        return Center(
          child: Column(
            children: [
              Text(
                'Что-то пошло не так, неизвестная ошибка',
                style: Theme.of(context).textTheme.headline1,
              )
            ],
          ),
        );
      }
    });
  }
}
