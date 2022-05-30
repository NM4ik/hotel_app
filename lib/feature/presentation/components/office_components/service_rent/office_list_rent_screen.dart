import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hotel_ma/feature/presentation/components/office_components/service_rent/office_list_products_screen.dart';
import 'package:hotel_ma/feature/presentation/widgets/default_appbar_widget.dart';
import 'package:hotel_ma/feature/presentation/widgets/page_animation.dart';

import '../../../../../common/app_constants.dart';

class OfficeListRentComponent extends StatelessWidget {
  const OfficeListRentComponent({Key? key, required this.doc, required this.title}) : super(key: key);
  final String doc;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: title,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kEdgeHorizontalPadding),
        child: FutureBuilder(
            future: FirebaseFirestore.instance.collection('rentCategory').doc(doc).collection('children').get(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: SizedBox(
                      height: 40,
                      width: 40,
                      child: CircularProgressIndicator(
                        color: kMainBlueColor,
                      )),
                );
              }

              if (snapshot.hasData) {
                final data = snapshot.data!.docs.map((e) => e.data() as Map<String, dynamic>).toList();
                log(data.toString());

                return SizedBox(
                  child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) => GestureDetector(
                          onTap: () async {
                            final category = await FirebaseFirestore.instance
                                .collection('rentCategory')
                                .doc(doc)
                                .collection('children')
                                .where("title", isEqualTo: data[index]['title'])
                                .get();

                            Navigator.of(context).push(createRouteAnimFromBottom(OfficeListProductsComponent(type: category.docs.single.id, title: data[index]['title'],)));
                          },
                          child: _listComponent(context, data[index])),
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 15,
                          ),
                      itemCount: snapshot.data!.docs.length),
                );
              } else {
                return Center(
                    child: Text(
                  'Что-то пошло не так или данные не загрузились..',
                  style: Theme.of(context).textTheme.headline1,
                ));
              }
            }),
      ),
    );
  }
}

Widget _listComponent(BuildContext context, data) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(kEdgeMainBorder),
    ),
    height: 80,
    child: Stack(
      children: [
        SizedBox(
            width: double.infinity,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(kEdgeMainBorder),
                child: Image.asset(
                  "assets/images/${data['image']}",
                  fit: BoxFit.cover,
                ))),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kEdgeHorizontalPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                data['title'],
                style: Theme.of(context).textTheme.headline3!.copyWith(color: Colors.white, fontWeight: FontWeight.w400),
              ),
              Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Подробнее',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white, fontSize: 14),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.white,
                      size: 16,
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}
