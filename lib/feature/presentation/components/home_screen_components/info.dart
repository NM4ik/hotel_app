import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hotel_ma/common/app_constants.dart';
import 'package:hotel_ma/feature/data/models/faq_model.dart';
import 'package:hotel_ma/feature/presentation/screens/faq_screen.dart';

class InfoComponent extends StatelessWidget {
  const InfoComponent({Key? key, required this.faqModel}) : super(key: key);
  final FaqModel faqModel;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => FaqScreen(
                  faqModel: faqModel,
                ))),
        child: Container(
            decoration: BoxDecoration(color: Theme.of(context).primaryColorLight, borderRadius: BorderRadius.circular(kEdgeMainBorder)),
            width: double.infinity,
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0, bottom: 5),
                      child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            faqModel.title,
                            style: Theme.of(context).textTheme.headline3,
                          )),
                    )),
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(kEdgeMainBorder), top: Radius.zero),
                      color: Colors.grey,
                    ),
                    width: double.infinity,
                    child: CachedNetworkImage(
                      imageUrl: faqModel.image ?? '',
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
