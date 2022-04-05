import 'package:flutter/material.dart';
import 'package:hotel_ma/common/app_constants.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({Key? key, required this.index, required this.imageRoot}) : super(key: key);
  final int index;
  final String imageRoot;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(children: [
              Image.asset(
                imageRoot,
                fit: BoxFit.cover,
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 2,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kEdgeHorizontalPadding*2, vertical: kEdgeVerticalPadding*2),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(99),
                    color: kMainBlueColor
                  ) ,child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: GestureDetector(onTap: () => Navigator.of(context).pop(), child: const Icon(Icons.clear_rounded, color: Colors.white,)),
                  )),
                ),
              ),
            ]),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kEdgeHorizontalPadding, vertical: kEdgeVerticalPadding/2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// faq_date
                  Text('Статья от 01 апреля 2022', style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w500, color: kMainGreyColor),),
                  /// faq_nave
                  Text('Как зарезервировать автомобиль и оплатить его', style: Theme.of(context).textTheme.headline3!.copyWith(fontWeight: FontWeight.w500,),),

                  const SizedBox(height: kEdgeVerticalPadding,),

                  Text("""Перед первой поездкой на банковской карте блокируется сумма предсписания. Чаще всего это 271,82 ₽, но может быть и другая сумма. Эти деньги не списываются, а только удерживаются на счете. Чтобы узнать точную сумму предсписания перед поездкой, в карточке тарифа нажмите Еще. 
                  \nЕсли стоимость аренды окажется меньше суммы предсписания, спишется только фактическая стоимость, а разница будет разблокирована. Срок разблокировки зависит от условий вашего банка.""",
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                  ),

                  Text("""Перед первой поездкой на банковской карте блокируется сумма предсписания. Чаще всего это 271,82 ₽, но может быть и другая сумма. Эти деньги не списываются, а только удерживаются на счете. Чтобы узнать точную сумму предсписания перед поездкой, в карточке тарифа нажмите Еще. 
                  \nЕсли стоимость аренды окажется меньше суммы предсписания, спишется только фактическая стоимость, а разница будет разблокирована. Срок разблокировки зависит от условий вашего банка.",
                  """,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                  ),

                ],
              )
            ),
          ],
        ),
      ),
    );
  }
}
