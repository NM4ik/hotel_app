import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hotel_ma/common/app_constants.dart';
import 'package:hotel_ma/feature/data/datasources/firestore_methods.dart';
import 'package:hotel_ma/feature/presentation/widgets/default_appbar_widget.dart';

import '../../../data/models/booking_model.dart';
import '../../../data/models/room_type_model.dart';

class ProfileScreenVisits extends StatelessWidget {
  const ProfileScreenVisits({Key? key, required this.uid}) : super(key: key);
  final String uid;

  Future<List<BookingModel>> _fetchBooking() async {
    List<BookingModel> bookings = [];
    List<RoomTypeModel> roomTypesList = [];

    try {
      final data = await FirebaseFirestore.instance.collection('bookings').where('uid', isEqualTo: uid).orderBy("dateEnd", descending: true).get();
      final types = await FirebaseFirestore.instance.collection('roomTypes').get();

      for (var element in types.docs) {
        roomTypesList.add(RoomTypeModel.fromJson(element.data(), element.id));
      }

      for (var element in data.docs) {
        bookings.add(BookingModel.fromJson(element.data(), roomTypesList));
      }
    } catch (e) {
      log(e.toString());
    }

    return bookings;
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    FirestoreMethods firestoreData = FirestoreMethods();

    return Scaffold(
      appBar: const DefaultAppBar(
        title: "Ваши посещения",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kEdgeHorizontalPadding),
        child: FutureBuilder(
            // future: FirebaseFirestore.instance.collection('bookings').where('uid', isEqualTo: uid).orderBy("dateEnd", descending: true).get(),
            future: _fetchBooking(),
            builder: (BuildContext context, AsyncSnapshot<List<BookingModel>> snapshot) {
              if (snapshot.hasError) {
                return const Text("Не удалось загрузить данные");
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(
                      color: kMainBlueColor,
                    ),
                  ],
                );
              }

              if (snapshot.hasError) {
                return const Center(child: Text('Что-то пошло не так..'));
              }

              if (snapshot.data!.isEmpty) {
                return Center(
                    child: Text(
                  "У вас еще не было посещений",
                  style: Theme.of(context).textTheme.headline3,
                ));
              }

              if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                final data = snapshot.data;

                return ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) => Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorLight,
                      borderRadius: BorderRadius.circular(kEdgeMainBorder),
                    ),
                    width: double.infinity,
                    height: 110,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: kEdgeVerticalPadding / 2, horizontal: kEdgeHorizontalPadding),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${data![index].dateStart.toString()}  -  ${data[index].dateEnd.toString()}',
                                    style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 10),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    data[index].roomName.toString(),
                                    style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 14, fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              Text(
                                'Счет: ${data[index].totalPrice}',
                                style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 10, color: kMainGreyColor),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Color(int.parse('0xFF${data[index].roomTypeModel.color}')),
                                        borderRadius: BorderRadius.circular(kEdgeMainBorder * 2)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
                                      child: Text(
                                        data[index].roomTypeModel.title.toString(),
                                        style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: data[index].status == 'Забронировано' ? kMainGreyColor : kMainBlueColor,
                                        borderRadius: BorderRadius.circular(kEdgeMainBorder * 2)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
                                      child: Text(
                                        data[index].status.toString(),
                                        style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                decoration: BoxDecoration(color: kMainBlueColor, borderRadius: BorderRadius.circular(10)),
                                child: const Center(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                                    child: Text(
                                      'Посмотреть',
                                      style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: kEdgeVerticalPadding / 2,
                  ),
                );
              }

              return const CircularProgressIndicator();
            }),
      ),
    );
  }
}
