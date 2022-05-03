import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hotel_ma/common/app_constants.dart';
import 'package:hotel_ma/feature/presentation/screens/faq_screen.dart';

class InfoComponent extends StatelessWidget {
  const InfoComponent({Key? key, required this.text, this.image}) : super(key: key);
  final String text;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => FaqScreen(index: 1, data: {
                  'imageRoot': image,
                  'date': 'Карта от 20 февраля 2022',
                  'title': 'План отеля',
                  'firstText':
                      'План 1-го этажа гостиницы является представительским интерьером. Первое впечатление  которое производит на гостей ресепшн остается навсегда. Комфорт и уют созданный в интерьере лоби и зоны ожидания очень важен.  Хорошо продуманный план гостиницы и выполненный дизайн интерьера',
                  'secondText':
                      'Второй этаж мини гостиницы максимально используется для размещения номеров. В зависимости от звезд гостиницы варьируется площадь номера и размеры ванной комнаты и качество сантехники и мебели.План мини гостиницы максимально использует преимущества места расположения и вписывается или в городскую застройку или в природу.',
                }))),
        child: Container(
            decoration: BoxDecoration(color: Theme.of(context).primaryColorLight, borderRadius: BorderRadius.circular(kEdgeMainBorder)),
            width: double.infinity,
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0, bottom: 5),
                      child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            text,
                            style: Theme.of(context).textTheme.headline3,
                          )),
                    )),
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(kEdgeMainBorder), top: Radius.zero),
                      color: Colors.grey,
                    ),
                    width: double.infinity,
                    child: CachedNetworkImage(
                      imageUrl: image ?? '',
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
