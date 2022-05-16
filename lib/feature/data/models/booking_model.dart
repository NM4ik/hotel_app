import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotel_ma/feature/domain/entities/booking_entity.dart';

class BookingModel extends BookingEntity {
  BookingModel(
      {required String roomName,
      required String roomType,
      required DateTime dateStart,
      required DateTime dateEnd,
      required String roomId,
      required String status,
      required int totalPrice,
      required String uid})
      : super(roomName: roomName, roomType: roomType, dateStart: dateStart, dateEnd: dateEnd, roomId: roomId, status: status, totalPrice: totalPrice, uid: uid);

// DateFormat dateFormat = DateFormat("MMMEd");

  factory BookingModel.fromJson(Map<String, dynamic> json) => BookingModel(
      // dateEnd: DateFormat("MMMEd").format(DateTime.fromMicrosecondsSinceEpoch(json['dateEnd'])),
      // dateStart: DateFormat("MMMEd").format(DateTime.fromMicrosecondsSinceEpoch((json['dateStart'] as Timestamp).toDate())),
      // dateEnd: (json['dateEnd'] as Timestamp).toDate(),
      // dateStart: (json['dateStart'] as Timestamp).toDate(),

      roomName: json['roomName'],
      roomType: json['roomType'],

      dateStart: (json['dateStart'] as Timestamp).toDate(),
      dateEnd: (json['dateEnd'] as Timestamp).toDate(),
      roomId: json['roomId'],
      status: json['status'],
      totalPrice: json['totalPrice'],
      uid: json['uid']);

  Map<String, dynamic> toJson() => <String, dynamic>{
        'roomName': roomName,
        'roomType': roomType,

        'dateStart': dateStart,
        'dateEnd': dateEnd,
        'roomId': roomId,
        'status': status,
        'totalPrice': totalPrice,
        'uid': uid,
      };
}
