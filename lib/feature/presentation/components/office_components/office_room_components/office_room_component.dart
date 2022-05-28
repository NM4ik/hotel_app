import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotel_ma/common/app_constants.dart';
import 'package:hotel_ma/feature/presentation/components/office_components/office_room_components/office_room_shimmer_component.dart';

import '../../../../data/models/rent_model.dart';

class OfficeRoomComponent extends StatelessWidget {
  const OfficeRoomComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kEdgeVerticalPadding / 2),
      child: FutureBuilder(
          future: FirebaseFirestore.instance.collection('rent').where("category", isEqualTo: 'roomService').get(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const OfficeRoomShimmerComponent();
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.connectionState == ConnectionState.none) {
              return const Text('Соединение не установлено...');
            } else if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
              final List<RentModel> entities = [];
              snapshot.data!.docs.map((e) => entities.add(RentModel.fromJson(e.data() as Map<String, dynamic>, e.id))).toList();

              return ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => _serviceCard(context, entities[index]),
                shrinkWrap: true,
                itemCount: entities.length,
                separatorBuilder: (BuildContext context, int index) => const SizedBox(
                  height: kEdgeVerticalPadding / 3,
                ),
              );
            } else {
              return const Text('Что-то пошло не так....');
            }
          }),
    );
  }
}

Widget _serviceCard(BuildContext context, RentModel model) => Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kEdgeMainBorder),
        color: Colors.grey[200],
      ),
      width: double.infinity,
      height: 80,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              IconData(int.parse(model.image), fontFamily: 'MaterialIcons'),
              color: kMainBlueColor,
              size: 45,
            ),
            const SizedBox(
              width: kEdgeHorizontalPadding,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.title,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 16),
                ),
                Text(
                  model.price,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.black.withOpacity(0.5), fontSize: 14),
                ),
              ],
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: kMainBlueColor,
              size: 20,
            ),
          ],
        ),
      ),
    );
