import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class NeumorphicWidget extends StatelessWidget {
  const NeumorphicWidget({Key? key, required this.widget}) : super(key: key);
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: NeumorphicStyle(
        color: Theme.of(context).primaryColorLight,
        depth: 3,
        lightSource: LightSource.topLeft,
        intensity: 0.3,
      ),
      child: widget,
    );
  }
}
