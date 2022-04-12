import 'package:flutter/material.dart';
import 'package:hotel_ma/common/app_constants.dart';
import 'package:hotel_ma/feature/data/models/room_model.dart';
import 'package:hotel_ma/feature/presentation/widgets/defaut_button_widget.dart';

import '../../screens/product_screen.dart';

class CardRoom extends StatelessWidget {
  const CardRoom({Key? key, required this.roomModel}) : super(key: key);
  final RoomModel roomModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (gridContext) => ProductScreen(
                  roomModel: roomModel,
                )));
      },
      child: SizedBox(
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(kEdgeMainBorder * 2)),
          child: Stack(
            children: [
              Stack(children: [
                SizedBox(
                    width: double.infinity,
                    child: Image.asset(
                      'assets/images/room_card_example.png',
                      fit: BoxFit.fill,
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
                            color: roomModel.type == 'Премиум' ? kVinousColor : kMainBlueColor, borderRadius: BorderRadius.circular(kEdgeMainBorder * 2)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
                          child: Text(
                            roomModel.type,
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
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16),
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 20,
                          child: ListView.builder(
                              itemCount: 5,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: Color(0xFFFEC007),
                                    size: 14,
                                  )),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  roomModel.price.toString(),
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 12),
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  'руб/ночь',
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 10),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                print('Ты тыкаешь на кнопку "БРОНЬ"');
                              },
                              child: Container(
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
      ),
    );
  }
}
