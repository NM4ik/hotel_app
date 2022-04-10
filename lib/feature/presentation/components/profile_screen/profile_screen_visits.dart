import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hotel_ma/common/app_constants.dart';
import 'package:hotel_ma/feature/data/datasources/firestore_data.dart';

class ProfileScreenVisits extends StatelessWidget {
  const ProfileScreenVisits({Key? key, required this.uid}) : super(key: key);
  final String uid;

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    FirestoreData firestoreData = FirestoreData();

    return FutureBuilder(
        future: firestoreData.getVisitsByUser(uid),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return const Text("Не удалось загрузить данные");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            const CircularProgressIndicator();
          }

          if(snapshot.hasData){
            return Center(child: Text("У вас еще не было посещений", style: Theme.of(context).textTheme.headline3,));
          }

          if (snapshot.connectionState == ConnectionState.done && snapshot.data?.length != null) {
            return ListView.builder(
              itemBuilder: (context, index) => Column(
                children: [
                  Text(snapshot.data.toString()),
                ],
              ),
              itemCount: snapshot.data?.length,
              // itemCount: snapshot.data.length,
            );
          }

          return const CircularProgressIndicator();

          // ListView.separated(
          //   physics: const BouncingScrollPhysics(),
          //   itemBuilder: (context, index) => Container(
          //     decoration: BoxDecoration(
          //       color: Theme.of(context).primaryColorLight,
          //       borderRadius: BorderRadius.circular(kEdgeMainBorder),
          //     ),
          //     width: double.infinity,
          //     height: 110,
          //     child: Padding(
          //       padding: const EdgeInsets.symmetric(vertical: kEdgeVerticalPadding / 2, horizontal: kEdgeHorizontalPadding),
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           Row(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: [
          //               Column(
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: [
          //                   Text(
          //                     '14.10.2021  -  16.10.2021',
          //                     style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 10),
          //                   ),
          //                   SizedBox(
          //                     height: 10,
          //                   ),
          //                   Text(
          //                     'Бизнес номер для двоих',
          //                     style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 14, fontWeight: FontWeight.w500),
          //                   ),
          //                 ],
          //               ),
          //               Text(
          //                 'Счет: 10000₽',
          //                 style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 10, color: kMainGreyColor),
          //               ),
          //             ],
          //           ),
          //           Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: [
          //               Container(
          //                 decoration: BoxDecoration(color: kVinousColor, borderRadius: BorderRadius.circular(kEdgeMainBorder * 2)),
          //                 child: Padding(
          //                   padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
          //                   child: Text(
          //                     'Премиум',
          //                     style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w500),
          //                   ),
          //                 ),
          //               ),
          //               Container(
          //                 decoration: BoxDecoration(color: kMainBlueColor, borderRadius: BorderRadius.circular(10)),
          //                 child: const Center(
          //                   child: Padding(
          //                     padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
          //                     child: Text(
          //                       'Посмотреть',
          //                       style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w400),
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          //   itemCount: 10,
          //   separatorBuilder: (context, index) => SizedBox(
          //     height: kEdgeVerticalPadding / 2,
          //   ),
          // );
        });
  }
}
