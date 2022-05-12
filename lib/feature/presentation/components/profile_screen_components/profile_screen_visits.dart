import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hotel_ma/common/app_constants.dart';
import 'package:hotel_ma/feature/data/datasources/firestore_methods.dart';
import 'package:hotel_ma/feature/presentation/widgets/default_appbar_widget.dart';

import '../../../data/models/visit_model.dart';

class ProfileScreenVisits extends StatelessWidget {
  const ProfileScreenVisits({Key? key, required this.uid}) : super(key: key);
  final String uid;

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
            future: FirebaseFirestore.instance.collection('bookings').where('uid', isEqualTo: uid).get(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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

              if (snapshot.data!.docs.isEmpty) {
                return Center(
                    child: Text(
                  "У вас еще не было посещений",
                  style: Theme.of(context).textTheme.headline3,
                ));
              }

              if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                List<VisitModel> visits = [];
                snapshot.data?.docs.map((e) => visits.add(VisitModel.fromJson(e.data() as Map<String, dynamic>))).toList();
                return ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: visits.length,
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
                                    '${visits[index].dateStart.toString()}  -  ${visits[index].dateEnd.toString()}',
                                    style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 10),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    visits[index].roomName,
                                    style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 14, fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              Text(
                                'Счет: ${visits[index].price}',
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
                                        color: visits[index].roomType == 'Премиум' ? kVinousColor : kMainBlueColor,
                                        borderRadius: BorderRadius.circular(kEdgeMainBorder * 2)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
                                      child: Text(
                                        visits[index].roomType,
                                        style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: visits[index].status == 'Забронировано' ? kMainGreyColor : kMainBlueColor,
                                        borderRadius: BorderRadius.circular(kEdgeMainBorder * 2)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
                                      child: Text(
                                        visits[index].status.toString(),
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
