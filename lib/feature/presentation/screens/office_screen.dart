import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:hotel_ma/common/app_constants.dart';
import 'package:hotel_ma/feature/presentation/components/office_components/office_room_components/office_room_component.dart';
import 'package:hotel_ma/feature/presentation/components/office_components/service_rent/office_rent_component.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../bloc/office_bloc/office_bloc.dart';

class OfficeScreen extends StatefulWidget {
  const OfficeScreen({Key? key}) : super(key: key);

  @override
  State<OfficeScreen> createState() => _OfficeScreenState();
}

class _OfficeScreenState extends State<OfficeScreen> with TickerProviderStateMixin {
  bool isNotifications = true;
  late DateFormat dateFormat;

  @override
  void initState() {
    initializeDateFormatting();
    dateFormat = DateFormat.MMMEd("ru");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.read<OfficeBloc>().add(OfficeCheckoutEvent());
    TabController _tabController = TabController(length: 4, vsync: this);

    return BlocConsumer<OfficeBloc, OfficeState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is OfficeLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is OfficeUnLiveState) {
          return const Center(
            child: Text("Вы здесь не проживаете"),
          );
        }
        if (state is OfficeErrorState) {
          log(state.message);

          return const Center(
            child: Text("Ошибка"),
          );
        }
        if (state is OfficeUnAuthState) {
          return const Center(
            child: Text("Вы не авторизованы"),
          );
        }
        if (state is OfficeLiveState) {
          final room = state.roomModel;

          return Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 3,
                child: Stack(
                  children: [
                    Stack(
                      children: [
                        Image.asset(

                            /// rerun to network image from fireStorage
                            'assets/images/room_image_3.png',
                            fit: BoxFit.cover,
                            height: double.infinity,
                            width: double.infinity,
                            alignment: Alignment.center),
                        Container(
                          height: double.infinity,
                          width: double.infinity,
                          decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
                        )
                      ],
                    ),
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: kEdgeVerticalPadding, horizontal: kEdgeHorizontalPadding),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  room.name,
                                  style: Theme.of(context).textTheme.headline3!.copyWith(color: Colors.white),
                                ),
                                const SizedBox(
                                  width: kEdgeHorizontalPadding / 3,
                                ),
                                const Icon(
                                  Icons.king_bed_rounded,
                                  color: kMainBlueColor,
                                )
                              ],
                            ),
                            const SizedBox(
                              height: kEdgeVerticalPadding / 3,
                            ),
                            Row(
                              children: [
                                ClipRRect(
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                      sigmaX: 2.0,
                                      sigmaY: 2.0,
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(kEdgeMainBorder / 2),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                                        child: Text(
                                          "№${room.id}",
                                          style: Theme.of(context).textTheme.headline3!.copyWith(
                                                color: Colors.white,
                                                fontSize: 16,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: kEdgeHorizontalPadding,
                                ),
                                Text('${dateFormat.format(state.bookingModel.dateStart)} - ${dateFormat.format(state.bookingModel.dateEnd)}',
                                    style: Theme.of(context).textTheme.headline3!.copyWith(color: kMainGreyColor, fontSize: 16)),
                              ],
                            ),
                            const Spacer(),
                            Row(
                              children: [
                                Text(
                                  'Не беспокоить',
                                  style: Theme.of(context).textTheme.headline3!.copyWith(color: Colors.white, fontSize: 16),
                                ),
                                const SizedBox(
                                  width: kEdgeHorizontalPadding,
                                ),
                                FlutterSwitch(
                                  width: 70,
                                  height: 30,
                                  valueFontSize: 9,
                                  toggleSize: 14.0,
                                  value: isNotifications,
                                  borderRadius: 20.0,
                                  padding: 8.0,
                                  activeColor: kMainBlueColor,
                                  inactiveColor: Colors.white.withOpacity(0.3),
                                  showOnOff: true,
                                  activeText: "Вкл",
                                  inactiveText: "Выкл",
                                  onToggle: (value) {
                                    setState(() {
                                      isNotifications = !isNotifications;
                                    });
                                    // locator.get<FirestoreRepository>().updateField(value, 'isNotifications', userModel.uid);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              TabBar(
                controller: _tabController,
                labelPadding: const EdgeInsets.only(left: 15, right: 15),
                labelColor: Colors.black,
                isScrollable: true,
                indicator: const CircleTabIndicator(color: kMainBlueColor, radius: 4),
                // onTap: (value) => log(value.toString()),
                tabs: const [
                  Tab(
                    text: "Номер",
                  ),
                  Tab(
                    text: "Аренда",
                  ),
                  Tab(
                    text: "Услуги",
                  ),
                  Tab(
                    text: "Мероприятия",
                  ),
                ],
              ),
              Expanded(
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kEdgeHorizontalPadding),
                    child: TabBarView(
                      controller: _tabController,
                      children: const [
                        OfficeRoomComponent(),
                        OfficeRentComponent(),
                        Text('3'),
                        Text('3'),
                      ],
                    ),
                  ),
                ),
              )
            ],
          );

          // return Column(
          //   children: [
          //     Container(
          //       width: double.infinity,
          //       height: MediaQuery.of(context).size.height / 3,
          //       color: Colors.red,
          //     ),
          //     TabBar(controller: _tabController, labelStyle: const TextStyle(color: Colors.black), tabs: const [
          //       Text(
          //         '1',
          //         style: TextStyle(color: Colors.black),
          //       ),
          //       Text(
          //         '2',
          //         style: TextStyle(color: Colors.black),
          //       ),
          //       Text(
          //         '3',
          //         style: TextStyle(color: Colors.black),
          //       ),
          //       Text(
          //         '4',
          //         style: TextStyle(color: Colors.black),
          //       ),
          //     ]),
          //     Expanded(
          //       child: TabBarView(controller: _tabController, children: [
          //         Center(
          //           child: Text(
          //             '4',
          //             style: TextStyle(color: Colors.black),
          //           ),
          //         ),
          //         Center(
          //           child: Text(
          //             '2',
          //             style: TextStyle(color: Colors.black),
          //           ),
          //         ),
          //         Center(
          //           child: Text(
          //             '3',
          //             style: TextStyle(color: Colors.black),
          //           ),
          //         ),
          //         ListView.builder(
          //           itemBuilder: (context, index) => Column(
          //             children: [
          //               Container(
          //                 color: Colors.yellow,
          //                 width: double.infinity,
          //                 height: 70,
          //               ),
          //               SizedBox(height: 10,),
          //             ],
          //           ),
          //           itemCount: 10,
          //         ),
          //       ]),
          //     )
          //   ],
          // );

          // return SingleChildScrollView(
          //   physics: const BouncingScrollPhysics(),
          //   child: Column(
          //     children: [
          //       SizedBox(
          //         height: MediaQuery.of(context).size.height / 3,
          //         child: Stack(
          //           children: [
          //             Stack(
          //               children: [
          //                 Image.asset(
          //
          //                     /// rerun to network image from fireStorage
          //                     'assets/images/room_image_3.png',
          //                     fit: BoxFit.cover,
          //                     height: double.infinity,
          //                     width: double.infinity,
          //                     alignment: Alignment.center),
          //                 Container(
          //                   height: double.infinity,
          //                   width: double.infinity,
          //                   decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
          //                 )
          //               ],
          //             ),
          //             SafeArea(
          //               child: Padding(
          //                 padding: const EdgeInsets.symmetric(vertical: kEdgeVerticalPadding, horizontal: kEdgeHorizontalPadding),
          //                 child: Column(
          //                   children: [
          //                     Row(
          //                       children: [
          //                         Text(
          //                           room.name,
          //                           style: Theme.of(context).textTheme.headline3!.copyWith(color: Colors.white),
          //                         ),
          //                         const SizedBox(
          //                           width: kEdgeHorizontalPadding / 3,
          //                         ),
          //                         const Icon(
          //                           Icons.king_bed_rounded,
          //                           color: Colors.lightBlueAccent,
          //                         )
          //                       ],
          //                     ),
          //                     const SizedBox(
          //                       height: kEdgeVerticalPadding / 3,
          //                     ),
          //                     Row(
          //                       children: [
          //                         ClipRRect(
          //                           child: BackdropFilter(
          //                             filter: ImageFilter.blur(
          //                               sigmaX: 2.0,
          //                               sigmaY: 2.0,
          //                             ),
          //                             child: Container(
          //                               decoration: BoxDecoration(
          //                                 color: Colors.white.withOpacity(0.2),
          //                                 borderRadius: BorderRadius.circular(kEdgeMainBorder / 2),
          //                               ),
          //                               child: Padding(
          //                                 padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
          //                                 child: Text(
          //                                   "№${room.id}",
          //                                   style: Theme.of(context).textTheme.headline3!.copyWith(
          //                                         color: Colors.white,
          //                                         fontSize: 16,
          //                                       ),
          //                                 ),
          //                               ),
          //                             ),
          //                           ),
          //                         ),
          //                         const SizedBox(
          //                           width: kEdgeHorizontalPadding,
          //                         ),
          //                         Text('${dateFormat.format(state.bookingModel.dateStart)} - ${dateFormat.format(state.bookingModel.dateEnd)}',
          //                             style: Theme.of(context).textTheme.headline3!.copyWith(color: kMainGreyColor, fontSize: 16)),
          //                       ],
          //                     ),
          //                     const Spacer(),
          //                     Row(
          //                       children: [
          //                         Text(
          //                           'Не беспокоить',
          //                           style: Theme.of(context).textTheme.headline3!.copyWith(color: Colors.white, fontSize: 16),
          //                         ),
          //                         const SizedBox(
          //                           width: kEdgeHorizontalPadding,
          //                         ),
          //                         FlutterSwitch(
          //                           width: 70,
          //                           height: 30,
          //                           valueFontSize: 9,
          //                           toggleSize: 14.0,
          //                           value: isNotifications,
          //                           borderRadius: 20.0,
          //                           padding: 8.0,
          //                           activeColor: kMainBlueColor,
          //                           inactiveColor: Colors.white.withOpacity(0.3),
          //                           showOnOff: true,
          //                           activeText: "Вкл",
          //                           inactiveText: "Выкл",
          //                           onToggle: (value) {
          //                             setState(() {
          //                               isNotifications = !isNotifications;
          //                             });
          //                             // locator.get<FirestoreRepository>().updateField(value, 'isNotifications', userModel.uid);
          //                           },
          //                         ),
          //                       ],
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //             )
          //           ],
          //         ),
          //       ),
          //       SafeArea(
          //           child: Padding(
          //         padding: const EdgeInsets.fromLTRB(kEdgeHorizontalPadding, kEdgeVerticalPadding / 5, kEdgeHorizontalPadding, 0),
          //         child: Column(
          //           children: [
          //             Align(
          //               alignment: Alignment.centerLeft,
          //               child: TabBar(
          //                 controller: _tabController,
          //                 labelPadding: const EdgeInsets.only(left: 15, right: 15),
          //                 labelColor: Colors.black,
          //                 isScrollable: true,
          //                 indicator: const CircleTabIndicator(color: kMainBlueColor, radius: 4),
          //                 // onTap: (value) => log(value.toString()),
          //                 tabs: const [
          //                   Tab(
          //                     text: "Номер",
          //                   ),
          //                   Tab(
          //                     text: "Аренда",
          //                   ),
          //                   Tab(
          //                     text: "Услуги",
          //                   ),
          //                   Tab(
          //                     text: "Мероприятия",
          //                   ),
          //                 ],
          //               ),
          //             ),
          //             SizedBox(
          //               height: MediaQuery.of(context).size.height * (2 / 3),
          //               child: TabBarView(
          //                 controller: _tabController,
          //                 children: const [
          //                   OfficeRoomComponent(),
          //                   OfficeRentComponent(),
          //                   Text('2'),
          //                   Text('3'),
          //                 ],
          //               ),
          //             )
          //           ],
          //         ),
          //       )),
          //     ],
          //   ),
          // );
        } else {
          return const Center(
            child: Text("Непредвиденная ошибка.."),
          );
        }
      },
    );
  }
}

class CircleTabIndicator extends Decoration {
  final Color color;
  final double radius;

  const CircleTabIndicator({required this.color, required this.radius});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(color: color, radius: radius);
  }
}

class _CirclePainter extends BoxPainter {
  final double radius;
  late Color color;

  _CirclePainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    late Paint _paint;
    _paint = Paint()..color = color;
    _paint = _paint..isAntiAlias = true;
    final Offset circleOffset = offset + Offset(cfg.size!.width / 2, cfg.size!.height - radius);
    canvas.drawCircle(circleOffset, radius, _paint);
  }
}
