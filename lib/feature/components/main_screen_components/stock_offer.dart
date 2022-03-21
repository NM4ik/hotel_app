import 'package:flutter/material.dart';
import 'package:hotel_ma/common/app_colors.dart';

class StockOffer extends StatelessWidget {
  const StockOffer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0,),
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
          Container(
            height: 250,
            child: ListView.separated(
              itemCount: 4,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Column(
                children: [
                  Stack(children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Container(
                        width: 120,
                        height: 140,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF6F6F6),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.asset("assets/images/car.png"),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        width: 90,
                        height: 20,
                        decoration: BoxDecoration(
                          color: index.isEven ? kMainBlueColor : Colors.red,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Center(
                            child: Text(
                          '35 дней 23:26:21',
                          style: TextStyle(fontWeight: FontWeight.w400, fontFamily: "Inter", fontSize: 9, color: Colors.white),
                        )),
                      ),
                    ),
                  ]),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                      width: 120,
                      child: const Text(
                        "BMW i520 4л. 500 л.с. задний привод",
                        style: TextStyle(fontWeight: FontWeight.w400, fontFamily: "Inter", fontSize: 14, color: Colors.black),
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
                          color: Colors.grey.shade200,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                          child: Text('2300P'),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                          child: Text(
                            '2300P',
                            style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                decorationColor: Colors.black,
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
