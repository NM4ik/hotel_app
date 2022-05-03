import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hotel_ma/common/app_constants.dart';

class PersonalOffer extends StatelessWidget {
  const PersonalOffer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          child: Text(
            "Персональное предложение",
            style: Theme.of(context).textTheme.headline3,
          ),
          alignment: Alignment.centerLeft,
        ),

        const SizedBox(
          height: 15,
        ),


        Stack(children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey,
              ),
              child: CachedNetworkImage(
                imageUrl: 'https://cdn.dribbble.com/users/1292088/screenshots/14587244/media/3a3964374422db0fb6359560bb67a929.jpg?compress=1&resize=800x600',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              width: 150,
              height: 20,
              decoration: BoxDecoration(
                color: kMainBlueColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(child: Text('до окончания: 35 дней 23:26:21', style: const TextStyle(fontWeight: FontWeight.w400, fontFamily: "Inter", fontSize: 9, color: Colors.white),)),
            ),
          ),
        ])
      ],
    );
  }
}
