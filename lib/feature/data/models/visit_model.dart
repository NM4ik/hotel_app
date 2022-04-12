import 'package:hotel_ma/feature/domain/entities/visit_entity.dart';

class VisitModel extends VisitEntity {
  const VisitModel({required String dateEnd, required String dateStart, required String price, required String roomName, required String roomType})
      : super(dateEnd: dateEnd, dateStart: dateStart, price: price, roomName: roomName, roomType: roomType);

  factory VisitModel.fromJson(Map<String, dynamic> json) =>
      VisitModel(dateEnd: json['dateEnd'], dateStart: json['dateStart'], price: json['price'], roomName: json['roomName'], roomType: json['roomType']);
}
