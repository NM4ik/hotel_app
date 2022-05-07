import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OnboardingContent extends StatelessWidget {
  const OnboardingContent({Key? key, required this.image, required this.text, required this.subtext}) : super(key: key);
  final String? image, text, subtext;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(
          flex: 3,
        ),
        Image.asset(image!),
        const Spacer(
          flex: 2,
        ),
        Text(text!, style: Theme.of(context).textTheme.headline3!.copyWith(fontFamily: "Inter")),
        const Spacer(
          flex: 1,
        ),
        SizedBox(
          width: 270,
          child: Text(subtext!, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400, fontFamily: "Inter")),
        ),
      ],
    );
  }
}
