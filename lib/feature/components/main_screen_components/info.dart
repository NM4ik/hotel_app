import 'package:flutter/material.dart';
import 'package:hotel_ma/common/app_constants.dart';
import 'package:hotel_ma/feature/widgets/neumorphic_box.dart';

class InfoComponent extends StatelessWidget {
  const InfoComponent({Key? key, required this.text, this.image}) : super(key: key);
  final String text;
  final Image? image;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          decoration: BoxDecoration(color: Theme.of(context).primaryColorLight, borderRadius: BorderRadius.circular(kEdgeMainBorder)),
          width: double.infinity,
          height: 150,
          child: Column(
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
                          style: Theme.of(context).textTheme.headline3,
                        )),
                  )),
              Expanded(
                flex: 2,
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(kEdgeMainBorder), top: Radius.zero),
                    color: Colors.grey,
                  ),
                  width: double.infinity,
                  child: image,
                ),
              )
            ],
          )),
    );
  }
}
