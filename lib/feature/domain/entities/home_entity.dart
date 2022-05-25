import 'package:hotel_ma/feature/data/models/rent_model.dart';

class HomeEntity {
  final List<Map<String, dynamic>> about;
  // final Map<String, dynamic> personalOffer;
  final List<RentModel> stockOffer;
  final List<Map<String, dynamic>> playBill;

  const HomeEntity({required this.about, required this.stockOffer, required this.playBill});
}
