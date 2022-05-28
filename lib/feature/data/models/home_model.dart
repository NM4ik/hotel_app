import 'package:hotel_ma/feature/data/models/event_model.dart';
import 'package:hotel_ma/feature/data/models/rent_model.dart';
import 'package:hotel_ma/feature/domain/entities/home_entity.dart';

import 'faq_model.dart';

class HomeModel extends HomeEntity {
  HomeModel(
      {required List<FaqModel> about,
      // required Map<String, dynamic> personalOffer,
      required List<RentModel> stockOffer,
      required List<EventModel> playBill})
      : super(about: about, stockOffer: stockOffer, playBill: playBill);

  factory HomeModel.fromJson(List<FaqModel> about, Map<String, dynamic> personalOffer, List<RentModel> stockOffer, List<EventModel> playBill) =>
      HomeModel(about: about, stockOffer: stockOffer, playBill: playBill);
}
