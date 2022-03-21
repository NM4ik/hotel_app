import 'package:flutter/material.dart';
import 'package:hotel_ma/common/app_colors.dart';

class PlayBill extends StatelessWidget {
  const PlayBill({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 30,),

        Align(
          child: Text(
            "Афиша",
            style: Theme.of(context).textTheme.headline3,
          ),
          alignment: Alignment.centerLeft,
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          height: 300,
          child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 3 / 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
              itemCount: 4,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        height: 100,
                        alignment: Alignment.center,
                        child: Text('playbill'),
                        decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(15)),
                      ),
                    ),
                    SizedBox(height: 8,),
                    Text('1 сентября - 7 сентября', style: TextStyle(fontFamily: "Inter", fontSize: 10, color: Colors.grey),),
                    Text('Формула 1', style: TextStyle(fontFamily: "Inter", fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black),),

                  ],
                );
              }),
        ),
      ],
    );
  }
}
