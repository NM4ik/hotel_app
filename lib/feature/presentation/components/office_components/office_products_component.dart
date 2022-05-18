import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hotel_ma/common/app_constants.dart';
import 'package:hotel_ma/feature/data/models/rent_model.dart';
import 'package:hotel_ma/feature/presentation/components/office_components/office_filters.dart';

import '../../widgets/default_appbar_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';


class OfficeListProductsComponent extends StatefulWidget {
  const OfficeListProductsComponent({Key? key, required this.type, required this.title}) : super(key: key);
  final String type;
  final String title;

  @override
  _OfficeListProductsComponentState createState() => _OfficeListProductsComponentState();
}

class _OfficeListProductsComponentState extends State<OfficeListProductsComponent> {
  DateTime dateTimeFirst = DateTime.now();
  late DateTime dateTimeSecond = dateTimeFirst.add(const Duration(days: 1));

  void getDateValues(DateTime dateTimeFirst, DateTime dateTimeSecond) {
    setState(() {
      this.dateTimeFirst = dateTimeFirst;
      this.dateTimeSecond = dateTimeSecond;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: widget.title,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kEdgeHorizontalPadding),
          child: FutureBuilder(
              future: FirebaseFirestore.instance.collection('rent').where("category", isEqualTo: widget.type).get(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: kMainBlueColor,
                    ),
                  );
                }

                if (snapshot.hasData) {
                  final List<RentModel> entities = [];

                  final data = snapshot.data!.docs.map((e) => entities.add(RentModel.fromJson(e.data() as Map<String, dynamic>, e.id))).toList();

                  return CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      SliverToBoxAdapter(
                        child: OfficeFilters(
                          dateTimeFirst: dateTimeFirst,
                          dateTimeSecond: dateTimeSecond,
                          changeDateTime: getDateValues,
                        ),
                      ),
                      const SliverToBoxAdapter(
                        child: SizedBox(
                          height: kEdgeVerticalPadding,
                        ),
                      ),
                      SliverGrid(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 15,
                          crossAxisSpacing: 15,
                          childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 1.55),
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (gridContext, index) {
                            return GestureDetector(
                              onTap: () {},
                              child: _productCard(entities[index], context),
                            );
                          },
                          childCount: entities.length,
                        ),
                      ),
                    ],
                  );
                } else {
                  return Center(
                      child: Text(
                    "Произошла какая-то ошибка, либо данные отсутствуют",
                    style: Theme.of(context).textTheme.headline1,
                  ));
                }
              }),
        ),
      ),
    );
  }
}

Widget _productCard(RentModel entity, BuildContext context) => SizedBox(
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(kEdgeMainBorder * 2)),
        child: Stack(
          children: [
            Stack(children: [
              SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(kEdgeMainBorder * 2),
                    child:
                    CachedNetworkImage(
                      imageUrl: entity.image,
                      progressIndicatorBuilder: (context, url, downloadProgress) =>
                          CircularProgressIndicator(value: downloadProgress.progress),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      fit: BoxFit.cover,
                    ),
                    // child: Image.asset(
                    //   'assets/images/${entity.image}',
                    //   // fit: BoxFi,
                    // ),
                  )),
              Container(
                decoration: BoxDecoration(color: Colors.black.withOpacity(0.3), borderRadius: BorderRadius.circular(kEdgeMainBorder * 2)),
              )
            ]),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        entity.name,
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                      const SizedBox(
                        height: kEdgeVerticalPadding / 4,
                      ),
                      Text(
                        entity.transmission,
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 12),
                      ),
                      Text(
                        '${entity.seats} мест',
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 12),
                      ),
                      const SizedBox(
                        height: kEdgeVerticalPadding / 4,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                entity.price,
                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 12),
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              const Text(
                                'руб/день',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 10),
                              ),
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                            child: const Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                                child: Text(
                                  'Бронь',
                                  style: TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
