import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../common/app_constants.dart';

class BuildShimmer extends StatelessWidget {
  const BuildShimmer({Key? key, required this.width, required this.height}) : super(key: key);
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kEdgeVerticalPadding / 2),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(kEdgeMainBorder)),
        width: width.toDouble(),
        height: height.toDouble(),
        child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.white,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(kEdgeMainBorder),
                color: Colors.white,
              ),
              width: 200,
              height: 100,
            )),
      ),
    );
  }
}
