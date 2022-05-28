import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hotel_ma/common/app_constants.dart';
import 'package:hotel_ma/feature/data/models/faq_model.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({Key? key, required this.faqModel}) : super(key: key);
  final FaqModel faqModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            faqModel.image == null
                ? Container()
                : Stack(children: [
                    CachedNetworkImage(
                      imageUrl: faqModel.image!,
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
                      'Cтатья от ${faqModel.date.year} года',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w500, color: kMainGreyColor),
                    ),

                    /// faq_nave
                    Text(
                      faqModel.title,
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    faqModel.description == null
                        ? Container()
                        : ListView.separated(
                            itemBuilder: (context, index) => Text(
                              faqModel.description?[index],
                              style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 13, fontWeight: FontWeight.w400),
                            ),
                            separatorBuilder: (context, index) => const SizedBox(
                              height: kEdgeVerticalPadding/3,
                            ),
                            itemCount: faqModel.description!.length,
                            scrollDirection: Axis.vertical,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                          ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
