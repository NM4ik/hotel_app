import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';


class NeumorphicBox extends StatelessWidget {
  const NeumorphicBox({Key? key, required this.widget, this.flex}) : super(key: key);

  final Widget widget;
  final int? flex;


  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex ?? 1,
      child: Neumorphic(
        style: const NeumorphicStyle(
          color: Colors.white,
          depth: 3,
          lightSource: LightSource.topLeft,
          intensity: 0.7,
        ),
        child: Container(
          width: double.infinity,
          height: 150,
          child: widget,
        ),
      ),
    );
  }
}
