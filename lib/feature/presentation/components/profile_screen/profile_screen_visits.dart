import 'package:flutter/material.dart';
import 'package:hotel_ma/common/app_constants.dart';

class ProfileScreenVisits extends StatelessWidget {
  const ProfileScreenVisits({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColorLight,
          borderRadius: BorderRadius.circular(kEdgeMainBorder),
        ),
        width: double.infinity,
        height: 110,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: kEdgeVerticalPadding / 2, horizontal: kEdgeHorizontalPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('14.10.2021  -  16.10.2021',style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 10),),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Бизнес номер для двоих',style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 14, fontWeight: FontWeight.w500),),
                    ],
                  ),
                  Text('Счет: 10000₽',style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 10, color: kMainGreyColor),),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(color: kVinousColor, borderRadius: BorderRadius.circular(kEdgeMainBorder * 2)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
                      child: Text(
                        'Премиум',
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(color: kMainBlueColor, borderRadius: BorderRadius.circular(10)),
                    child: const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                        child: Text(
                          'Посмотреть',
                          style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      itemCount: 10,
      separatorBuilder: (context, index) => SizedBox(
        height: kEdgeVerticalPadding / 2,
      ),
    );
  }
}
