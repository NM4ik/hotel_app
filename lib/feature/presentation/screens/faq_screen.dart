import 'package:flutter/material.dart';
import 'package:hotel_ma/common/app_constants.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({Key? key, required this.index, required this.imageRoot}) : super(key: key);
  final int index;
  final String imageRoot;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(children: [
              Image.asset(
                imageRoot,
                fit: BoxFit.cover,
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 2,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kEdgeHorizontalPadding*2, vertical: kEdgeVerticalPadding*2),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(99),
                    color: kMainBlueColor
                  ) ,child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: GestureDetector(onTap: () => Navigator.of(context).pop(), child: const Icon(Icons.clear_rounded, color: Colors.white,)),
                  )),
                ),
              ),
            ]),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kEdgeHorizontalPadding, vertical: kEdgeVerticalPadding),
              child: Text('Какой-то текс'),
            ),
          ],
        ),
      ),
    );
  }
}
