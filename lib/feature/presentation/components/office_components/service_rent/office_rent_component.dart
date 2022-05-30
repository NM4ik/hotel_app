import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hotel_ma/common/app_constants.dart';
import 'package:hotel_ma/feature/presentation/widgets/page_animation.dart';

import 'office_list_rent_screen.dart';
import 'office_list_products_screen.dart';

class OfficeRentComponent extends StatefulWidget {
  const OfficeRentComponent({Key? key}) : super(key: key);

  @override
  _OfficeRentComponentState createState() => _OfficeRentComponentState();
}

class _OfficeRentComponentState extends State<OfficeRentComponent> {
  List<Map<String, dynamic>> map = [
    {
      'doc': 'transport',
      'title': 'Транспорт',
      'children': [
        {'doc': 'car', 'title': 'Автомобили', 'image': 'assets/images/car_category.png'},
        {'doc': 'scooter', 'title': 'Скутеры', 'image': 'assets/images/scooter_category.png'}
      ]
    },
    {
      'doc': 'space',
      'title': 'Помещения',
      'children': [
        {'doc': 'patio', 'title': 'Паито', 'image': 'assets/images/patio_category.png'},
        {'doc': 'area', 'title': 'Конференц залы', 'image': 'assets/images/area_image.png'}
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: map.length,
      itemBuilder: (context, index) => _rentComponent(map[index], context),
      shrinkWrap: true,
    );
  }
}

Widget _rentComponent(Map<String, dynamic> json, BuildContext context) => Column(
      children: [
        const SizedBox(
          height: kEdgeVerticalPadding / 2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              json['title'],
              style: Theme.of(context).textTheme.headline3,
            ),
            GestureDetector(
              onTap: () => Navigator.of(context).push(createRouteAnimFromBottom(OfficeListRentComponent(
                doc: json['doc'],
                title: json['title'],
              ))),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'См.все',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(color: kMainBlueColor),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: kMainBlueColor,
                    size: 14,
                  )
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: kEdgeVerticalPadding / 2,
        ),
        SizedBox(
          height: 130,
          // width: double.infinity,
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            ...json['children']
                .map(
                  (item) => GestureDetector(
                    onTap: () async {
                      Navigator.of(context).push(createRouteAnimFromBottom(OfficeListProductsComponent(
                        type: item['doc'],
                        title: item['title'],
                      )));
                    },
                    child: SizedBox(
                      width: 170,
                      child: Stack(
                        children: [
                          SizedBox(
                            height: 130,
                            width: 170,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(kEdgeMainBorder),
                              child: Image.asset(
                                item['image'],
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  item['title'],
                                  // textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white, fontSize: 16),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Подробнее',
                                      style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white, fontSize: 10),
                                    ),
                                    const Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: Colors.white,
                                      size: 14,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ]),
        ),
        const SizedBox(
          height: kEdgeVerticalPadding / 3,
        ),
      ],
    );
