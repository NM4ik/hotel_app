import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hotel_ma/common/app_colors.dart';

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
            child: Neumorphic(
              style: NeumorphicStyle(
                color: Colors.white,
                depth: 3,
                lightSource: LightSource.topLeft,
                intensity: 0.7,
              ),
              child: Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
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
              child: Center(child: Text('до окончания: 35 дней 23:26:21', style: TextStyle(fontWeight: FontWeight.w400, fontFamily: "Inter", fontSize: 9, color: Colors.white),)),
            ),
          ),
        ])
      ],
    );
  }
}
