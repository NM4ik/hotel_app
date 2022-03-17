import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);
  PageController cardController = PageController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),

              /// UPDATE TO SPACER OR FLEX OR SOMETHING
              Text('ASIA HOTEL', style: Theme.of(context).textTheme.headline1),

              const SizedBox(
                height: 25,
              ),

              Container(
                decoration: BoxDecoration(color: const Color(0xFFF5F5F5), borderRadius: BorderRadius.circular(8)),
                child: const Padding(
                  padding: EdgeInsets.only(left: 20.0, right: 10.0),
                  child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintText: "Поиск по приложению",
                        hintStyle: TextStyle(color: Color(0xFFBDBDBD), fontFamily: 'Inter', fontSize: 16, fontWeight: FontWeight.w400),
                        suffixIcon: Icon(
                          Icons.search_rounded,
                          color: Color(0xFFBDBDBD),
                        )),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 30),
                child: Container(
                  height: 150,
                  child: ListView.separated(
                    controller: cardController,
                    itemCount: 2,
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        width: 15,
                      );
                    },
                    itemBuilder: (BuildContext context, int index) => Neumorphic(
                        style: NeumorphicStyle(
                            shape: NeumorphicShape.concave,
                            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                            depth: 4,
                            lightSource: LightSource.topLeft,
                            color: Colors.grey),
                        child: Container(
                          width: 250,
                        )),
                  ),
                ),
              ),

              Align(
                child: Text(
                  "Персональное предложение",
                  style: Theme.of(context).textTheme.headline3,
                ),
                alignment: Alignment.centerLeft,
              ),

              Padding(
                padding: const EdgeInsets.only(top: 25.0, bottom: 5),
                child: Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
