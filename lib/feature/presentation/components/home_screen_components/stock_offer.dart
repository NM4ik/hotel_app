import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hotel_ma/common/app_constants.dart';
import 'package:hotel_ma/feature/data/models/rent_model.dart';
import 'package:hotel_ma/feature/presentation/bloc/office_bloc/office_bloc.dart';
import 'package:hotel_ma/feature/presentation/components/office_components/service_rent/office_product_detail_screen.dart';

class StockOffer extends StatelessWidget {
  const StockOffer({Key? key, required this.rents}) : super(key: key);
  final List<RentModel>? rents;

  @override
  Widget build(BuildContext context) {
    final dateTimeNow = DateTime.now();

    return Padding(
      padding: const EdgeInsets.only(top: kEdgeVerticalPadding),
      child: Column(
        children: [
          Align(
            child: Text(
              "Акции",
              style: Theme.of(context).textTheme.headline3,
            ),
            alignment: Alignment.centerLeft,
          ),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            height: 220,
            child: ListView.separated(
              itemCount: rents!.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => BlocBuilder<OfficeBloc, OfficeState>(
                builder: (context, state) {
                  log(state.toString(), name: "STATe");
                  return GestureDetector(
                    onTap: () {
                      if (state is !OfficeLiveState) {
                        showCustomDialog(context, "К сожалению, нельзя забронировать услугу, если вы не проживаете в отеле в данный момент");
                      }
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Container(
                                width: 120,
                                height: 140,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColorLight,
                                  borderRadius: BorderRadius.circular(kEdgeMainBorder),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(kEdgeMainBorder),
                                  // child: CachedNetworkImage(
                                  //   fit: BoxFit.cover,
                                  //   imageUrl: rents![index].images?[0],
                                  // ),
                                  child: Image.network(
                                    rents![index].images?[0],
                                    fit: BoxFit.cover,
                                  ),
                                )),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              height: 20,
                              decoration: BoxDecoration(
                                color: index.isEven ? kMainBlueColor : Colors.red,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                  child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: kEdgeHorizontalPadding / 2),
                                child: Text(
                                  'До окончания ${(rents![index].saleTimeEnd?.difference(dateTimeNow).inDays)} дней',
                                  style: const TextStyle(fontWeight: FontWeight.w400, fontFamily: "Inter", fontSize: 9, color: Colors.white),
                                ),
                              )),
                            ),
                          ),
                        ]),
                        const SizedBox(
                          height: 8,
                        ),
                        SizedBox(
                            width: 120,
                            child: Text(
                              rents![index].title,
                              maxLines: 1,
                              style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 14),
                            )),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Theme.of(context).primaryColorLight,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                                child: Text(
                                  rents![index].price ?? '',
                                  // '${prices[index]}P',
                                  style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                                child: Text(
                                  rents![index].salePrice.toString(),
                                  style: TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      decorationColor: Theme.of(context).primaryColor,
                                      decorationStyle: TextDecorationStyle.solid,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.shade500),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  width: 20,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
