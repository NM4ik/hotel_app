import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_ma/common/app_constants.dart';
import 'package:hotel_ma/feature/presentation/components/office_components/office_rent_screen.dart';

import '../bloc/office_bloc/office_bloc.dart';

class OfficeScreen extends StatefulWidget {
  const OfficeScreen({Key? key}) : super(key: key);

  @override
  State<OfficeScreen> createState() => _OfficeScreenState();
}

class _OfficeScreenState extends State<OfficeScreen> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    context.read<OfficeBloc>().add(OfficeCheckStatusEvent());
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
          return SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(vertical: kEdgeVerticalPadding, horizontal: kEdgeHorizontalPadding),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: TabBar(
                    controller: _tabController,
                    labelPadding: const EdgeInsets.only(left: 15, right: 15),
                    labelColor: Colors.black,
                    isScrollable: true,
                    indicator: const CircleTabIndicator(color: kMainBlueColor, radius: 4),
                    onTap: (value) => log(value.toString()),
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
                ),
                SizedBox(
                  width: double.maxFinite,
                  height: 600,
                  child: TabBarView(
                    controller: _tabController,
                    children: const [
                      Text('1'),
                      OfficeRentComponent(),
                      Text('2'),
                      Text('3'),
                    ],
                  ),
                )
              ],
            ),
          ));
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
