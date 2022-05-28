import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../common/app_constants.dart';
import '../../widgets/build_shimmer.dart';

class ShimmerProfileVisitsScreen extends StatelessWidget {
  const ShimmerProfileVisitsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kEdgeHorizontalPadding, vertical: kEdgeVerticalPadding),
            child: Center(
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => const BuildShimmer(width: 120.0, height: 100.0),
                itemCount: 10,
                scrollDirection: Axis.vertical,
                separatorBuilder: (BuildContext context, int index) => const SizedBox(
                  width: kEdgeHorizontalPadding,
                ),
              ),
            )));
  }
}
