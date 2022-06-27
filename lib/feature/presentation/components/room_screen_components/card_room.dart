import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/cli_commands.dart';
import 'package:hotel_ma/common/app_constants.dart';
import 'package:hotel_ma/feature/data/models/room_model.dart';

import '../../bloc/rooms_bloc/rooms_bloc.dart';
import 'room_detail_screen.dart';

class CardRoom extends StatelessWidget {
  final RoomModel roomModel;

  const CardRoom({Key? key, required this.roomModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoomsBloc, RoomsState>(
      builder: (context, state) {
        return SizedBox(
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(kEdgeMainBorder * 2)),
            child: Stack(
              children: [
                Stack(children: [
                  SizedBox(
                      height: double.infinity,
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(kEdgeMainBorder * 2),
                        child: CachedNetworkImage(
                          imageUrl: roomModel.images?[0] ?? '',
                          fit: BoxFit.cover,
                        ),
                      )),
                  Container(
                    decoration: BoxDecoration(color: Colors.black.withOpacity(0.3), borderRadius: BorderRadius.circular(kEdgeMainBorder * 2)),
                  )
                ]),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color(int.parse('0xFF${roomModel.roomTypeModel.color}')), borderRadius: BorderRadius.circular(kEdgeMainBorder * 2)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
                            child: Text(
                              roomModel.roomTypeModel.title.toString(),
                              style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            roomModel.name,
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 20,
                            child: ListView.builder(
                                itemCount: 5,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  var indexes = roomModel.rating;

                                  return Icon(
                                  // roomModel.rating < 5 ? Icons.star : Icons.star_border,
                                  index < indexes ? Icons.star : Icons.star_border,
                                      color: const Color(0xFFFEC007),
                                      size: 14,
                                    );}),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    roomModel.price.toString(),
                                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 12),
                                  ),
                                  const SizedBox(
                                    width: 3,
                                  ),
                                  const Text(
                                    'руб/ночь',
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 10),
                                  ),
                                ],
                              ),
                              Container(
                                decoration: BoxDecoration(color: kMainBlueColor, borderRadius: BorderRadius.circular(10)),
                                child: const Center(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                                    child: Text(
                                      'Бронь',
                                      style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
