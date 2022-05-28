import 'package:hotel_ma/feature/data/models/faq_model.dart';
import 'package:hotel_ma/feature/data/models/rent_model.dart';

import '../../data/models/event_model.dart';

class HomeEntity {
  final List<FaqModel> about;

  // final Map<String, dynamic> personalOffer;
  final List<RentModel> stockOffer;
  final List<EventModel> playBill;

  const HomeEntity({required this.about, required this.stockOffer, required this.playBill});
}
