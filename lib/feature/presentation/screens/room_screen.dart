import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_ma/feature/presentation/bloc/rooms_bloc/rooms_bloc.dart';
import 'package:hotel_ma/feature/presentation/components/room_screen_components/card_room.dart';
import 'package:hotel_ma/feature/presentation/components/room_screen_components/room_detail_screen.dart';
import 'package:hotel_ma/feature/presentation/widgets/calendar_button_widget.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../../common/app_constants.dart';
import '../components/room_screen_components/filters.dart';
import '../components/room_screen_components/rooms_usic_screen.dart';
import '../widgets/build_shimmer.dart';
import '../widgets/square_button_widget.dart';

class RoomScreen extends StatefulWidget {
  const RoomScreen({Key? key}) : super(key: key);

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  DateTime dateTimeFirst = DateTime.now();
  late DateTime dateTimeSecond = dateTimeFirst.add(const Duration(days: 1));
  late DateFormat dateFormat;

  @override
  void initState() {
    initializeDateFormatting();
    dateFormat = DateFormat.MMMEd("ru");
    super.initState();
  }

  void getDateValues(DateTimeRange dateTimeRange) {
    setState(() {
      this.dateTimeRange = dateTimeRange;
    });
  }

  DateTimeRange dateTimeRange = DateTimeRange(start: DateTime.now(), end: DateTime.now().add(const Duration(days: 1)));

  @override
  Widget build(BuildContext context) {
    context.read<RoomsBloc>().add(RoomsCheckConnectionEvent());

    return BlocConsumer<RoomsBloc, RoomsState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is RoomsLoadingState) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: kEdgeVerticalPadding, horizontal: kEdgeHorizontalPadding),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 1.55),
                ),
                itemBuilder: (context, index) => const BuildShimmer(width: double.infinity, height: 100),
                itemCount: 8,
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
                    leading: const SquareButtonWidget(color: kMainBlueColor, icon: Icons.account_circle_outlined, iconColor: Colors.white),
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

                  SliverToBoxAdapter(
                      child: Row(
                    children: [
                      CalendarButtonWidget(
                        text: dateFormat.format(dateTimeRange.start),
                        initialDateRange: dateTimeRange,
                        changeDateTime: getDateValues,
                      ),
                      const SizedBox(
                        width: kEdgeHorizontalPadding,
                      ),
                      CalendarButtonWidget(
                        text: dateFormat.format(dateTimeRange.end),
                        initialDateRange: dateTimeRange,
                        changeDateTime: getDateValues,
                      ),
                    ],
                  )),

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
                            context
                                .read<RoomsBloc>()
                                .add(RoomsChooseEvent(room: state.rooms[index], firstDate: dateTimeRange.start, lastDate: dateTimeRange.end));
                            Navigator.of(context).push(MaterialPageRoute(builder: (gridContext) => const RoomDetailScreen()));
                          },
                          child: CardRoom(
                            roomModel: state.rooms[index],
                          ),
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
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  color: kMainBlueColor,
                ),
              ),
            );
          }
        });
  }
}
