import 'package:hotel_ma/feature/domain/entities/rent_entity.dart';

class RentModel extends RentEntity {
  const RentModel(
      {required String id,
      required String category,
      required String image,
      required String name,
      required String prePayment,
      required String price,
      required String seats,
      required String transmission,
      required String transmissionType})
      : super(
            id: id,
            category: category,
            image: image,
            name: name,
            prePayment: prePayment,
            price: price,
            seats: seats,
            transmission: transmission,
            transmissionType: transmissionType);

  factory RentModel.fromJson(Map<String, dynamic> json, String id) => RentModel(
      id: id,
      category: json['category'],
      image: json['image'],
      name: json['name'],
      prePayment: json['prePayment'],
      price: json['price'],
      seats: json['seats'],
      transmission: json['transmission'],
      transmissionType: json['transmissionType']);
}
