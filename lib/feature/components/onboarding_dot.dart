import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../common/app_constants.dart';

class OnboardingDot extends StatelessWidget {
  const OnboardingDot({Key? key, required this.currentPage, required this.controller, required this.length}) : super(key: key);

  final int length;
  final int currentPage;
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(controller: controller, count: length, effect: ExpandingDotsEffect(
      activeDotColor: kMainBlueColor,
      dotColor: Theme.of(context).cardColor,
    ),);
  }
}
