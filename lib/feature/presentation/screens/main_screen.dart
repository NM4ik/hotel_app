import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hotel_ma/common/app_constants.dart';
import 'package:hotel_ma/feature/presentation/components/main_screen_components/info.dart';
import 'package:hotel_ma/feature/presentation/components/main_screen_components/personal_offer.dart';
import 'package:hotel_ma/feature/presentation/components/main_screen_components/playbill.dart';
import 'package:hotel_ma/feature/presentation/components/main_screen_components/stock_offer.dart';

import '../widgets/default_text_field_widget.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);
  PageController cardController = PageController();
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kEdgeHorizontalPadding, vertical: kEdgeVerticalPadding),
            child: Column(
              children: [
                /// title = UPDATE TO SPACER OR FLEX OR SOMETHING
                Text('ASIA HOTEL', style: Theme.of(context).textTheme.headline1),

                const SizedBox(
                  height: 25,
                ),

                /// search-field
                const DefaultTextFieldWidget(text: "Поиск по приложению",),

                const SizedBox(
                  height: 30,
                ),

                /// info-block
                Row(
                  children: const [
                    InfoComponent(
                      text: "План отеля",
                      image: 'http://domostroy.vglazkov.com/images/chemal800/p_2.jpg',
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InfoComponent(
                      text: "Афиша",
                      image: 'https://pic-h.cdn-pegast.net/getimage-nc/thumb800/78/af/02/2f110583f5aa5070b197845c698d404e17e74c2094f927eb505afd657f/5db29bb415f03.jpg',
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
