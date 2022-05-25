import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../common/app_constants.dart';
import '../../widgets/build_shimmer.dart';

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
                  const BuildShimmer(width: 200.0, height: 30.0),
                  const BuildShimmer(width: 300.0, height: 30.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Expanded(child: BuildShimmer(width: double.infinity, height: 100.0)),
                      SizedBox(
                        width: kEdgeHorizontalPadding,
                      ),
                      Expanded(child: BuildShimmer(width: double.infinity, height: 100.0)),
                    ],
                  ),
                  const BuildShimmer(width: double.infinity, height: 200.0),
                  SizedBox(
                      height: 120,
                      child: ListView.separated(
                        itemBuilder: (context, index) => const BuildShimmer(width: 120.0, height: 100.0),
                        itemCount: 4,
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (BuildContext context, int index) => const SizedBox(
                          width: kEdgeHorizontalPadding,
                        ),
                      )),
                  const BuildShimmer(width: double.infinity, height: 50.0),
                ],
              ),
            )));
  }
}

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
