import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_ma/common/app_constants.dart';
import 'package:hotel_ma/feature/presentation/components/office_components/office_rent_screen.dart';

class OfficeScreen extends StatefulWidget {
  const OfficeScreen({Key? key}) : super(key: key);

  @override
  State<OfficeScreen> createState() => _OfficeScreenState();
}

class _OfficeScreenState extends State<OfficeScreen> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 4, vsync: this);

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
              indicator: CircleTabIndicator(color: kMainBlueColor, radius: 4),
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
  }
}

// class NamesClass extends StatelessWidget {
//   const NamesClass({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     context.read<OfficeBloc>().add(OfficeRentEvent());
//
//     return BlocConsumer<OfficeBloc, OfficeState>(
//       listener: (context, state) {
//         log(state.toString());
//       },
//       builder: (context, state) {
//         if (state is OfficeLoadingState) {
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         } else if (state is OfficeErrorState) {
//           return Center(
//             child: Text(state.message.toString()),
//           );
//         } else if (state is OfficeRoomState) {
//           return ListView.builder(
//               itemCount: state.names.length,
//               itemBuilder: (_, index) => Text(
//                     state.names[index].toString(),
//                     style: TextStyle(color: Colors.black),
//                   ));
//           // return OfficeRentInner();
//         } else {
//           return const Center(
//             child: Text('WTF'),
//           );
//         }
//       },
//     );
//   }
// }

class CircleTabIndicator extends Decoration {
  final Color color;
  double radius;

  CircleTabIndicator({required this.color, required this.radius});

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
