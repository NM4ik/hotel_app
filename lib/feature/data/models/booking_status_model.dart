import 'package:hotel_ma/feature/domain/entities/booking_status_entity.dart';

class BookingStatusModel extends BookingStatusEntity {
  const BookingStatusModel({required String id, String? color, String? title}) : super(id: id, color: color, title: title);

  factory BookingStatusModel.fromJson(Map<String, dynamic> json, String id) => BookingStatusModel(id: id, color: json['color'], title: json['title']);
}
