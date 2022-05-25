import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../common/app_constants.dart';

class ShimmerHomeScreen extends StatelessWidget {
  const ShimmerHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kEdgeHorizontalPadding, vertical: kEdgeVerticalPadding),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildShimmer(200.0, 30.0),
                  _buildShimmer(300.0, 30.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: _buildShimmer(double.infinity, 100.0)),
                      const SizedBox(
                        width: kEdgeHorizontalPadding,
                      ),
                      Expanded(child: _buildShimmer(double.infinity, 100.0)),
                    ],
                  ),
                  _buildShimmer(double.infinity, 200.0),
                  SizedBox(
                      height: 120,
                      child: ListView.separated(
                        itemBuilder: (context, index) => _buildShimmer(120.0, 100.0),
                        itemCount: 4,
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (BuildContext context, int index) => const SizedBox(
                          width: kEdgeHorizontalPadding,
                        ),
                      )),
                ],
              ),
            )));
  }
}

Widget _buildShimmer(width, height) => Padding(
      padding: const EdgeInsets.symmetric(vertical: kEdgeVerticalPadding / 2),
      child: SizedBox(
        width: width,
        height: height,
        child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.white,
            child: Container(
              color: Colors.white,
              width: 200,
              height: 100,
            )),
      ),
    );

// SizedBox(
// width: 200.0,
// height: 100.0,
// child: Shimmer.fromColors(
// baseColor: Colors.red,
// highlightColor: Colors.yellow,
// child: Text(
// 'Shimmer',
// textAlign: TextAlign.center,
// style: TextStyle(
// fontSize: 40.0,
// fontWeight:
// FontWeight.bold,
// ),
// ),
// ),
// );
