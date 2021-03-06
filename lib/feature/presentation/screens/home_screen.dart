import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hotel_ma/common/app_constants.dart';
import 'package:hotel_ma/feature/data/models/event_model.dart';
import 'package:hotel_ma/feature/data/models/faq_model.dart';
import 'package:hotel_ma/feature/data/models/home_model.dart';
import 'package:hotel_ma/feature/data/models/rent_model.dart';
import 'package:hotel_ma/feature/presentation/components/home_screen_components/info.dart';
import 'package:hotel_ma/feature/presentation/components/home_screen_components/personal_offer.dart';
import 'package:hotel_ma/feature/presentation/components/home_screen_components/events.dart';
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
    try {
      List<FaqModel> about = [];
      // Map<String, dynamic> personalOffer;
      List<RentModel> stockOffer = [];
      List<EventModel> playBill = [];

      final aboutData = await FirebaseFirestore.instance.collection('hotel').get();
      aboutData.docs.map((e) => about.add(FaqModel.fromJson(e.data()))).toList();

      final stockOfferData = await FirebaseFirestore.instance.collection('rent').orderBy("salePrice", descending: false).limit(4).get();
      stockOfferData.docs.map((e) => stockOffer.add(RentModel.fromJson(e.data(), e.id))).toList();

      final playBillData = await FirebaseFirestore.instance.collection('events').get();
      playBillData.docs.map((e) => playBill.add(EventModel.fromJson(e.data()))).toList();

      HomeModel homeModel = HomeModel(about: about, stockOffer: stockOffer, playBill: playBill);
      return homeModel;
    } catch (e) {
      log(e.toString(), name: "_homeFetchException");
      return Future.error(e.toString());
    }
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
                          text: "?????????? ???? ????????????????????",
                        ),

                        const SizedBox(
                          height: 30,
                        ),

                        /// info-block
                        Row(
                          children: [
                            InfoComponent(
                              faqModel: data!.about[1],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            InfoComponent(
                              faqModel: data.about[0],
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 30,
                        ),

                        /// personal-offer block
                        const PersonalOffer(),

                        /// stocks
                        StockOffer(rents: data.stockOffer),

                        /// playbill
                        PlayBill(
                          events: data.playBill,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SafeArea(
                      child: Center(
                          child: Text(
                    'Error',
                    style: Theme.of(context).textTheme.headline3,
                  ))),
                  const ShimmerHomeScreen(),
                ],
              ),
            );
          }
        });
  }
}
