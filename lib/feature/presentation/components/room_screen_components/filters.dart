import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_ma/core/locator_service.dart';
import 'package:hotel_ma/core/platform/network_info.dart';
import 'package:hotel_ma/feature/data/models/room_type_model.dart';
import 'package:hotel_ma/feature/data/repositories/auth_repository.dart';
import 'package:hotel_ma/feature/presentation/bloc/rooms_bloc/rooms_bloc.dart';
import 'package:hotel_ma/feature/presentation/widgets/calendar_button_widget.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../../../common/app_constants.dart';
import '../../../data/models/room_model.dart';
import '../../widgets/default_text_field_widget.dart';
import '../../widgets/square_button_widget.dart';

class Filters extends StatefulWidget {
  const Filters({Key? key, required this.changeDateTime, required this.dateTimeFirst, required this.dateTimeSecond}) : super(key: key);
  final Function changeDateTime;
  final DateTime dateTimeFirst;
  final DateTime dateTimeSecond;

  @override
  State<Filters> createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  final items = ['Цена по убыванию', 'Цена по возрастанию'];
  String? value;
  late DateFormat dateFormat;

  @override
  void initState() {
    initializeDateFormatting();
    dateFormat = DateFormat.MMMEd("ru");
    super.initState();
  }

  void changeDateTimeFirst(DateTime? dateTime) {
    if (dateTime == null) return;
    setState(() {
      dateTimeFirst = dateTime;

      if (dateTimeFirst.day >= dateTimeSecond.day) {
        dateTimeSecond = dateTimeFirst.add(const Duration(days: 1));
      }
    });
    widget.changeDateTime(dateTimeFirst, dateTimeSecond);
  }

  void changeDateTimeSecond(DateTime? dateTime) {
    if (dateTime == null) return;
    setState(() {
      dateTimeSecond = dateTime;

      if (dateTimeSecond.day == dateTimeFirst.day) {
        dateTimeFirst = dateTimeSecond.subtract(const Duration(days: 1));
      }
      if (dateTimeSecond.day < dateTimeFirst.day) {
        dateTimeFirst = dateTimeSecond.subtract(const Duration(days: 1));
      }
      widget.changeDateTime(dateTimeFirst, dateTimeSecond);
    });
  }

  var result = false;
  DateTime now = DateTime.now();
  late DateTime dateTimeFirst = widget.dateTimeFirst;

  // late DateTime dateTimeSecond = dateTimeFirst.add(const Duration(days: 1));
  late DateTime dateTimeSecond = widget.dateTimeSecond;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RoomsBloc, RoomsState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is RoomsLoadedState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: kEdgeVerticalPadding,
              ),
              Row(
                children:  const [
                  Expanded(child: DefaultTextFieldWidget(text: 'Поиск по номерам')),
                  SizedBox(
                    width: kEdgeHorizontalPadding / 2,
                  ),

                  // GestureDetector(
                  //     onTap: () async {
                  //       // print(FirebaseAuth.instance.currentUser.toString());
                  //       // BotToast.showSimpleNotification(title: 'qwe');
                  //
                  //       // setState(() {
                  //       //   final List<RoomModel> rooms = state.rooms;
                  //       // });
                  //       // rooms.sort((a,b) => b.price.compareTo(a.price));
                  //
                  //       // emit(RoomsLoadedState(rooms: rooms));
                  //
                  //       final rooms = state.rooms;
                  //       rooms.sort((a, b) => b.price.compareTo(a.price));
                  //       context.read<RoomsBloc>().add(RoomsUpdateEvent(rooms: rooms));
                  //     },
                  //     child:
                  //         SquareButtonWidget(color: Theme.of(context).primaryColorLight, icon: Icons.filter_list_rounded, iconColor: const Color(0xFFBDBDBD))),
                ],
              ),
              const SizedBox(
                height: kEdgeHorizontalPadding,
              ),
              Container(
                decoration: BoxDecoration(color: Theme.of(context).primaryColorLight, borderRadius: BorderRadius.circular(kEdgeMainBorder)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 10.0),
                  child: DropdownButton(
                    items: items.map(buildMenuItem).toList(),
                    onChanged: (value) => setState(() => {this.value = value.toString(), _updateRooms(value.toString(), state.rooms)}),
                    value: value,
                    icon: const Padding(
                      padding: EdgeInsets.only(left: 3.0),
                      child: Icon(
                        Icons.filter_list_rounded,
                        color: kMainGreyColor,
                      ),
                    ),
                    hint: const Text(
                      'Сортировать',
                      style: TextStyle(color: kMainGreyColor, fontFamily: 'Inter', fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                    style: const TextStyle(color: kMainGreyColor, fontFamily: 'Inter', fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              const SizedBox(
                height: kEdgeHorizontalPadding,
              ),
              Row(
                children: [
                  CalendarButtonWidget(
                    text: dateFormat.format(dateTimeFirst),
                    changeDateTime: changeDateTimeFirst,
                    initialDate: dateTimeFirst,
                  ),

                  /// refactor, https://gallery.flutter.dev/ = find calendar picker
                  const SizedBox(
                    width: kEdgeHorizontalPadding,
                  ),
                  CalendarButtonWidget(text: dateFormat.format(dateTimeSecond), changeDateTime: changeDateTimeSecond, initialDate: dateTimeSecond),
                ],
              )
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        child: Text(item),
        value: item,
      );

  _updateRooms(String value, List<RoomModel> stateRooms) {
    final rooms = stateRooms;
    if (value == 'Цена по убыванию') {
      rooms.sort((a, b) => b.price.compareTo(a.price));
    } else {
      rooms.sort((a, b) => a.price.compareTo(b.price));
    }
    context.read<RoomsBloc>().add(RoomsUpdateEvent(rooms: rooms));
  }
}
