import 'package:flutter/material.dart';
import 'package:hotel_ma/feature/widgets/neumorphic_box.dart';

class InfoComponent extends StatelessWidget {
  const InfoComponent({Key? key, required this.text, this.image}) : super(key: key);
  final String text;
  final Image? image;

  @override
  Widget build(BuildContext context) {
    return NeumorphicBox(
        widget: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, bottom: 5),
              child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    text,
                    style: const TextStyle(color: Colors.black, fontFamily: "Inter", fontSize: 18, fontWeight: FontWeight.w600),
                  )),
            )),
        Expanded(
          flex: 2,
          child: Container(
            color: Colors.grey,
            width: double.infinity,
            child: image,
          ),
        )
      ],
    ));
  }
}
