import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hotel_ma/common/app_constants.dart';

class PlayBill extends StatelessWidget {
  const PlayBill({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
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
        SizedBox(
          height: 300,
          child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 3 / 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
              itemCount: 4,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(kEdgeMainBorder)
                        ),
                        height: 100,
                        alignment: Alignment.center,
                        child: const Text('playbill'),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text(
                      '1 сентября - 7 сентября',
                      style: TextStyle(fontFamily: "Inter", fontSize: 10, color: Colors.grey),
                    ),
                    Text('Формула 1', style: Theme.of(context).textTheme.headline3!.copyWith(fontSize: 14)),
                  ],
                );
              }),
        ),
      ],
    );
  }
}
