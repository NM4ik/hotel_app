import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hotel_ma/common/app_constants.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({Key? key, required this.data}) : super(key: key);
  final Map<String, dynamic>? data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            data?['image'] == null
                ? Container()
                : Stack(children: [
                    CachedNetworkImage(
                      imageUrl: data?['image'] ?? '',
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
                      'Cтатья от ${(data?['date'] as Timestamp).toDate().year} года',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w500, color: kMainGreyColor),
                    ),

                    /// faq_nave
                    Text(
                      data?['title'],
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    ),

                    const SizedBox(
                      height: kEdgeVerticalPadding,
                    ),

                    Text(
                      '${data?['firstText']} \n',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 13, fontWeight: FontWeight.w400),
                    ),

                    Text(
                      '${data?['secondText']} \n',
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
