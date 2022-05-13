import 'dart:developer';

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
  DateTime dateTimeFirst = DateTime.now();
  late DateTime dateTimeSecond = dateTimeFirst.add(const Duration(days: 1));
  void getDateValues(DateTime dateTimeFirst, DateTime dateTimeSecond){
    setState(() {
      this.dateTimeFirst = dateTimeFirst;
      this.dateTimeSecond = dateTimeSecond;
    });
  }

  @override
  Widget build(BuildContext context) {
    context.read<RoomsBloc>().add(RoomsCheckConnectionEvent());

    return BlocConsumer<RoomsBloc, RoomsState>(
        listener: (context, state) {
          if(state is RoomsLoadedState){
            log('update');
          }
        },
        builder: (context, state) {
          if (state is RoomsLoadingState) {
            return const Center(
              child: CircularProgressIndicator(
                color: kMainBlueColor,
              ),
            );
          }

          if (state is RoomsEmptyState) {
            return const Center(
              child: Text('Свободных номеров нет'),
            );
          }

          if (state is RoomsLoadingErrorState) {
            return const Center(
              child: Text('Номена не загрузились'),
            );
          }

          if (state is RoomsLoadedState) {
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
                  SliverToBoxAdapter(
                    child: Filters(
                      dateTimeFirst: dateTimeFirst,
                      dateTimeSecond: dateTimeSecond,
                      changeDateTime: getDateValues,
                    ),
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
                        return CardRoom(
                          dateTimeSecond: dateTimeSecond,
                          dateTimeFirst: dateTimeFirst,
                          roomModel: state.rooms[index],
                        );
                      },
                      childCount: state.rooms.length,
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
