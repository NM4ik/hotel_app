import 'package:flutter/material.dart';

import '../../common/app_constants.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainBlueColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kEdgeHorizontalPadding, vertical: kEdgeVerticalPadding),
          child: Column(
            children: [
              const Center(
                  child: Text(
                'Профиль',
                style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600),
              )),
              const SizedBox(
                height: kEdgeVerticalPadding,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(99),
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: Image.asset("assets/images/profile_image.png"),
              ),
              const SizedBox(
                height: kEdgeVerticalPadding / 2,
              ),
              Column(
                children: const [
                  Text(
                    'Victoria Robertson',
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    'A mantra goes here??',
                    style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w400),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        height: MediaQuery.of(context).size.height / 1.8,
        child: Column(
          children: [
            ///tabs

            ///tabs inner
          ],
        ),
      ),
    );
  }
}
