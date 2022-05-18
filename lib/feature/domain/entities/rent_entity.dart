import 'package:equatable/equatable.dart';

class RentEntity extends Equatable {
  final String id;
  final String category;
  final String image;
  final String name;
  final String prePayment;
  final String price;
  final String seats;
  final String transmission;
  final String transmissionType;

  const RentEntity(
      {required this.id,
      required this.category,
      required this.image,
      required this.name,
      required this.prePayment,
      required this.price,
      required this.seats,
      required this.transmission,
      required this.transmissionType});

  @override
  List<Object> get props => [
        id,
        category,
        image,
        name,
        prePayment,
        price,
        seats,
        transmission,
        transmissionType,
      ];
}
