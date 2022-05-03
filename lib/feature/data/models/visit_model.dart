import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotel_ma/feature/domain/entities/visit_entity.dart';
import 'package:intl/intl.dart';

class VisitModel extends VisitEntity {
  VisitModel(
      {required String? dateEnd, required String? dateStart, required String price, required String roomName, required String roomType, required String status})
      : super(dateEnd: dateEnd, dateStart: dateStart, price: price, roomName: roomName, roomType: roomType, status: status);

  // DateFormat dateFormat = DateFormat("MMMEd");

  factory VisitModel.fromJson(Map<String, dynamic> json) => VisitModel(
      // dateEnd: DateFormat("MMMEd").format(DateTime.fromMicrosecondsSinceEpoch(json['dateEnd'])),
      // dateStart: DateFormat("MMMEd").format(DateTime.fromMicrosecondsSinceEpoch((json['dateStart'] as Timestamp).toDate())),
      // dateEnd: (json['dateEnd'] as Timestamp).toDate(),
      // dateStart: (json['dateStart'] as Timestamp).toDate(),
      price: json['totalPrice'].toString(),
      roomName: json['roomName'],
      roomType: json['roomType'],
      dateStart: DateFormat("MMMEd").format((json['dateStart'] as Timestamp).toDate()),
      dateEnd: DateFormat("MMMEd").format((json['dateEnd'] as Timestamp).toDate()),
      status: json['status'] ?? 'Статус');
}
