import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hotel_ma/common/app_constants.dart';
import 'package:hotel_ma/core/locator_service.dart';
import 'package:hotel_ma/feature/data/datasources/sql_methods.dart';
import 'package:hotel_ma/feature/data/models/home_model.dart';
import 'package:hotel_ma/feature/data/models/rent_model.dart';
import 'package:hotel_ma/feature/data/repositories/sql_repository.dart';
import 'package:hotel_ma/feature/presentation/components/home_screen_components/info.dart';
import 'package:hotel_ma/feature/presentation/components/home_screen_components/personal_offer.dart';
import 'package:hotel_ma/feature/presentation/components/home_screen_components/playbill.dart';
import 'package:hotel_ma/feature/presentation/components/home_screen_components/stock_offer.dart';

import '../../data/repositories/payment_controller.dart';
import '../components/home_screen_components/shimmer_home_screen.dart';
import '../widgets/default_text_field_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final PageController cardController = PageController();
  final TextEditingController textEditingController = TextEditingController();
  final PaymentController paymentController = PaymentController();

  Future<HomeModel> _homeFetch() async {
    List<Map<String, dynamic>> about = [];
    // Map<String, dynamic> personalOffer;
    List<RentModel> stockOffer = [];
    List<Map<String, dynamic>> playBill = [];

    final aboutData = await FirebaseFirestore.instance.collection('hotel').get();
    aboutData.docs.map((e) => about.add(e.data())).toList();

    final stockOfferData = await FirebaseFirestore.instance.collection('rent').orderBy("salePrice", descending: false).limit(4).get();
    stockOfferData.docs.map((e) => stockOffer.add(RentModel.fromJson(e.data(), e.id))).toList();

    final playBillData = await FirebaseFirestore.instance.collection('events').get();
    playBillData.docs.map((e) => playBill.add(e.data())).toList();

    HomeModel homeModel = HomeModel(about: about, stockOffer: stockOffer, playBill: playBill);

    // await Future.delayed(const Duration(seconds: 20));

    return homeModel;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _homeFetch(),
        builder: (BuildContext context, AsyncSnapshot<HomeModel> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const ShimmerHomeScreen();
          }

          if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
            final data = snapshot.data;

            return SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kEdgeHorizontalPadding, vertical: kEdgeVerticalPadding),
                    child: Column(
                      children: [
                        /// title = UPDATE TO SPACER OR FLEX OR SOMETHING
                        Text('ASIA HOTEL', style: Theme.of(context).textTheme.headline1),

                        // const SizedBox(
                        //   height: 25,
                        // ),
                        // ElevatedButton(
                        //     onPressed: () async {
                        //       log(locator.get<SqlRepository>().getUserFromSql().toString());
                        // final map = await FirebaseFirestore.instance
                        //     .collection('bookings')
                        //     .where("status", isEqualTo: "active")
                        //     .where("uid", isEqualTo: locator.get<SqlRepository>().getUserFromSql().uid)
                        //     .get();
                        // log(map.docs.toString());
                        // },
                        // child: const Text('test')),

                        const SizedBox(
                          height: 25,
                        ),

                        /// search-field
                        const DefaultTextFieldWidget(
                          text: "Поиск по приложению",
                        ),

                        const SizedBox(
                          height: 30,
                        ),

                        /// info-block
                        Row(
                          children: [
                            InfoComponent(
                              data: data?.about[1],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            InfoComponent(
                              data: data?.about[0],
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 30,
                        ),

                        /// personal-offer block
                        const PersonalOffer(),

                        /// stocks
                        StockOffer(rents: data?.stockOffer),

                        /// playbill
                        PlayBill(
                          events: data?.playBill,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return const Center(child: Text('qweqwe'));
          }
        });
  }
}
