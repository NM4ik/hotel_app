import 'package:equatable/equatable.dart';

class BookingRentEntity extends Equatable {
  final DateTime dateStart;
  final DateTime? dateEnd;
  final String rentItemId;
  final String rentItemName;
  final String totalPrice;

  const BookingRentEntity({required this.dateStart, required this.dateEnd, required this.rentItemId, required this.rentItemName, required this.totalPrice});

  @override
  List<Object?> get props => [
        dateStart,
        dateEnd,
        rentItemId,
        rentItemName,
        totalPrice,
      ];
}
