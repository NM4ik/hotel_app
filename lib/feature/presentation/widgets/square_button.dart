import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hotel_ma/common/app_constants.dart';

class SquareButton extends StatelessWidget {
  const SquareButton({Key? key, required this.color, required this.icon, required this.iconColor}) : super(key: key);
  final Color color;
  final IconData icon;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kEdgeMainBorder),
        color: color,
      ),
        width: 45,
        height: 45,
        child: Center(
          child: Icon(
            icon,
            color: iconColor,
            size: 25,
          ),
        ),
    );
  }
}
