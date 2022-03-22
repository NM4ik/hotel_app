import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hotel_ma/feature/components/default_text_field.dart';
import 'package:hotel_ma/feature/components/main_screen_components/info.dart';
import 'package:hotel_ma/feature/components/main_screen_components/personal_offer.dart';
import 'package:hotel_ma/feature/components/main_screen_components/playbill.dart';
import 'package:hotel_ma/feature/components/main_screen_components/stock_offer.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);
  PageController cardController = PageController();
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),

                /// title = UPDATE TO SPACER OR FLEX OR SOMETHING
                Text('ASIA HOTEL', style: Theme.of(context).textTheme.headline1),

                const SizedBox(
                  height: 25,
                ),

                /// search-field
                DefaultTextField(text: "Поиск по приложю", textEditingController: textEditingController),

                const SizedBox(
                  height: 30,
                ),

                /// info-block
                Row(
                  children: const [
                    InfoComponent(
                      text: "План отеля",
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    InfoComponent(
                      text: "Афиша",
                    ),
                  ],
                ),

                const SizedBox(
                  height: 30,
                ),

                /// personal-offer block
                const PersonalOffer(),

                /// stocks
                const StockOffer(),

                /// playbill  Failed assertion: line 1814 pos 12: '!_debugDoingThisLayout': is not true.
                const PlayBill(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
