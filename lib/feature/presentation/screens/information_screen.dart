import 'package:flutter/material.dart';
import 'package:hotel_ma/common/app_constants.dart';

class InformationScreen extends StatelessWidget {
  const InformationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titles = ['Клубная программа', 'Помощь', 'Контакты', 'О приложении'];

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Информация",
          style: Theme.of(context).textTheme.bodyText1,
        ),
        leading: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: Icon(
            Icons.arrow_back_ios_rounded,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: kEdgeVerticalPadding, horizontal: kEdgeHorizontalPadding),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                  color: kMainBlueColor,
                  borderRadius: BorderRadius.circular(kEdgeMainBorder),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('8 800 000 000 1',
                            style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.w600, fontSize: 21, fontFamily: "Inter", color: Colors.white)),
                        SizedBox(
                          height: 5,
                        ),
                        Text('единая справочная служба', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12, fontFamily: "Inter", color: Colors.white))
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(99),
                        border: Border.all(color: Colors.white, width: 1),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.call,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: kEdgeVerticalPadding,
              ),
              Container(
                  height: titles.length / 2 * 80,
                  child: ListView.builder(itemCount: titles.length, itemBuilder: (context, index) => itemTile(context, titles[index]))),
              const SizedBox(
                height: kEdgeVerticalPadding,
              ),
              Column(
                children: [
                  Text(
                    'Наш отель в соцсетях:',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 4,
                      itemBuilder: (context, index) => const Text('VK'),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget itemTile(BuildContext context, String title) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: kMainGreyColor,
              size: 20,
            ),
          ],
        ),
        const Divider(
          color: kMainGreyColor,
        ),
      ],
    );
  }
}
