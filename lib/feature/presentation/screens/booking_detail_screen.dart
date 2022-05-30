import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hotel_ma/common/app_constants.dart';
import 'package:hotel_ma/feature/data/models/booking_rent_model.dart';
import 'package:hotel_ma/feature/presentation/widgets/build_shimmer.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class BookingDetailScreen extends StatefulWidget {
  const BookingDetailScreen({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  _BookingDetailScreenState createState() => _BookingDetailScreenState();
}

class _BookingDetailScreenState extends State<BookingDetailScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  late DateFormat dateFormat;

  // late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    dateFormat = DateFormat.MMMEd("ru");
  }

  Future<List<BookingRentModel>> _fetchData() async {
    try {
      final List<BookingRentModel> data = [];

      final response = await FirebaseFirestore.instance.collection('bookings').doc(widget.id).collection('rents').get();
      response.docs.map((e) => data.add(BookingRentModel.fromJson(e.data()))).toList();

      return data;
    } catch (e) {
      log(e.toString(), name: "_fetchDataBookingDetailScreenException");
      return Future.error(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width - 30;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: kEdgeVerticalPadding / 2, horizontal: kEdgeHorizontalPadding),
          child: FutureBuilder(
              future: _fetchData(),
              builder: (BuildContext context, AsyncSnapshot<List<BookingRentModel>> snapshot) {
                if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                  final data = snapshot.data;

                  return ListView.separated(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        final item = data![index];
                        _controller = AnimationController(
                          duration: Duration(milliseconds: index * 100),
                          vsync: this,
                        )..forward();

                        log((index / 10).toString());
                        return SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(-0.5, 0.0),
                              end: const Offset(0.0, 0.0),
                            ).animate(CurvedAnimation(
                              parent: _controller,
                              curve: Curves.easeInCubic,
                            )),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColorLight,
                                borderRadius: BorderRadius.circular(kEdgeMainBorder),
                              ),
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${dateFormat.format(item.dateStart).toString()}  -  ${item.dateEnd == null ? '' : dateFormat.format(item.dateEnd!).toString()}',
                                          style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 10),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          item.rentItemName.toString(),
                                          style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 14, fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      'Счет: ${item.totalPrice}Р',
                                      style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 13, color: kMainGreyColor),
                                    ),
                                  ],
                                ),
                              ),
                            ));
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                            height: kEdgeVerticalPadding / 3,
                          ),
                      itemCount: data!.length);
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return ListView.builder(
                    itemCount: 10,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColorLight,
                        borderRadius: BorderRadius.circular(kEdgeMainBorder),
                      ),
                      width: double.infinity,
                      height: 60,
                      child: const BuildShimmer(
                        height: 60,
                        width: double.infinity,
                      ),
                    ),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                      child: Text(
                    "У вас еще не было бронирований",
                    style: Theme.of(context).textTheme.headline3,
                  ));
                } else {
                  return Center(
                      child: Text(
                        "Ошибка загрузки...",
                        style: Theme.of(context).textTheme.headline3,
                      ));
                }
              }),
        ),
      ),
    );
  }
}
