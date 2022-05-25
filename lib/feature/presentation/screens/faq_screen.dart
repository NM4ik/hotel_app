import 'package:flutter/material.dart';
import 'package:hotel_ma/common/app_constants.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({Key? key, required this.index, required this.data}) : super(key: key);
  final int index;
  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            data['imageRoot'] == null
                ? Container()
                : Stack(children: [
                    Image.network(
                      data['imageRoot']!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height / 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: kEdgeHorizontalPadding * 2, vertical: kEdgeVerticalPadding * 2),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(99), color: kMainBlueColor),
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: GestureDetector(
                                  onTap: () => Navigator.of(context).pop(),
                                  child: const Icon(
                                    Icons.clear_rounded,
                                    color: Colors.white,
                                  )),
                            )),
                      ),
                    ),
                  ]),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: kEdgeHorizontalPadding, vertical: kEdgeVerticalPadding / 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// faq_date
                    Text(
                      data['date'],
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w500, color: kMainGreyColor),
                    ),

                    /// faq_nave
                    Text(
                      data['title'],
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    ),

                    const SizedBox(
                      height: kEdgeVerticalPadding,
                    ),

                    Text(
                      '${data['description']} \n',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 13, fontWeight: FontWeight.w400),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
