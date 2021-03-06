import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hotel_ma/common/app_constants.dart';
import 'package:hotel_ma/feature/data/datasources/firestore_methods.dart';
import 'package:hotel_ma/feature/data/models/booking_status_model.dart';
import 'package:hotel_ma/feature/presentation/components/profile_screen_components/shimmer_profile_visits_screen.dart';
import 'package:hotel_ma/feature/presentation/screens/booking_detail_screen.dart';
import 'package:hotel_ma/feature/presentation/widgets/default_appbar_widget.dart';
import 'package:hotel_ma/feature/presentation/widgets/page_animation.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../../data/models/booking_model.dart';
import '../../../data/models/room_type_model.dart';

class ProfileScreenVisits extends StatefulWidget {
  const ProfileScreenVisits({Key? key, required this.uid}) : super(key: key);
  final String uid;

  @override
  State<ProfileScreenVisits> createState() => _ProfileScreenVisitsState();
}

class _ProfileScreenVisitsState extends State<ProfileScreenVisits> {
  Future<List<BookingModel>> _fetchBooking() async {
    List<BookingModel> bookings = [];
    List<RoomTypeModel> roomTypesList = [];
    List<BookingStatusModel> bookingStatusList = [];

    try {
      final data = await FirebaseFirestore.instance.collection('bookings').where('uid', isEqualTo: widget.uid).orderBy("dateEnd", descending: true).get();
      final types = await FirebaseFirestore.instance.collection('roomTypes').get();
      final statuses = await FirebaseFirestore.instance.collection('bookingStatuses').get();

      for (var element in types.docs) {
        roomTypesList.add(RoomTypeModel.fromJson(element.data(), element.id));
      }
      for (var element in statuses.docs) {
        bookingStatusList.add(BookingStatusModel.fromJson(element.data(), element.id));
      }

      for (var element in data.docs) {
        bookings.add(BookingModel.fromJson(element.data(), roomTypesList, bookingStatusList, element.id));
      }
    } catch (e) {
      log(e.toString());
    }

    return bookings;
  }

  late DateFormat dateFormat;

  @override
  void initState() {
    initializeDateFormatting();
    dateFormat = DateFormat.MMMEd("ru");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    FirestoreMethods firestoreData = FirestoreMethods();

    return Scaffold(
      appBar: const DefaultAppBar(
        title: "???????? ????????????????????????",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kEdgeHorizontalPadding),
        child: FutureBuilder(
            future: _fetchBooking(),
            builder: (BuildContext context, AsyncSnapshot<List<BookingModel>> snapshot) {
              if (snapshot.hasError) {
                return const Text("???? ?????????????? ?????????????????? ????????????");
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const ShimmerProfileVisitsScreen();
              }

              if (snapshot.hasError) {
                return const Center(child: Text('??????-???? ?????????? ???? ??????..'));
              }

              if (snapshot.data!.isEmpty) {
                return Center(
                    child: Text(
                  "?? ?????? ?????? ???? ???????? ??????????????????",
                  style: Theme.of(context).textTheme.headline3,
                ));
              }

              if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                final data = snapshot.data;

                return ListView.separated(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: data!.length,
                  itemBuilder: (context, index) {
                    final int color = int.parse('0xFF${data[index].bookingStatus.color!}');

                    return GestureDetector(
                      onTap: () => Navigator.push(context, createRouteAnimFromLeft(BookingDetailScreen(id: data[index].id, bookingModel: data[index],))),
                      // onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const BookingDetailScreen())),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColorLight,
                          borderRadius: BorderRadius.circular(kEdgeMainBorder),
                        ),
                        width: double.infinity,
                        height: 120,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: kEdgeVerticalPadding / 2, horizontal: kEdgeHorizontalPadding),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${dateFormat.format(data[index].dateStart).toString()}  -  ${dateFormat.format(data[index].dateEnd).toString()}',
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
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      '????????: ${data[index].totalPrice}',
                                      style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 10, color: kMainGreyColor),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10,),
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
                                            style:
                                                Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(color: Color(color), borderRadius: BorderRadius.circular(kEdgeMainBorder * 2)),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
                                          child: Text(
                                            data[index].bookingStatus.title.toString(),
                                            style:
                                                Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w500),
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
                                          '????????????????????',
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
                    );
                  },
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
