import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotel_ma/feature/domain/entities/booking_rent_entity.dart';

class BookingRentModel extends BookingRentEntity {
  const BookingRentModel(
      {required DateTime dateStart, required DateTime? dateEnd, required String rentItemId, required String rentItemName, required String totalPrice})
      : super(dateStart: dateStart, dateEnd: dateEnd, rentItemId: rentItemId, rentItemName: rentItemName, totalPrice: totalPrice);

  factory BookingRentModel.fromJson(Map<String, dynamic> json) => BookingRentModel(
      dateStart: (json['dateStart'] as Timestamp).toDate(),
      dateEnd: json['dateEnd'] == null ? null : (json['dateEnd'] as Timestamp).toDate(),
      rentItemId: json['rentItemId'],
      rentItemName: json['rentItemName'],
      totalPrice: json['totalPrice']);

  Map<String, dynamic> toJson() => <String, dynamic>{
        'dateEnd': dateEnd,
        'dateStart': dateStart,
        'rentItemId': rentItemId,
        'rentItemName': rentItemName,
        'totalPrice': totalPrice,
      };
}
