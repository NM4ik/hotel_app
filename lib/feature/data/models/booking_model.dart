import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotel_ma/feature/data/models/room_type_model.dart';
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
      required String uid,
      required RoomTypeModel roomTypeModel})
      : super(
            roomName: roomName,
            roomType: roomType,
            dateStart: dateStart,
            dateEnd: dateEnd,
            roomId: roomId,
            status: status,
            totalPrice: totalPrice,
            uid: uid,
            roomTypeModel: roomTypeModel);

// DateFormat dateFormat = DateFormat("MMMEd");

  factory BookingModel.fromJson(Map<String, dynamic> json, List<RoomTypeModel> roomTypes) => BookingModel(
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
        uid: json['uid'],
        roomTypeModel: roomTypes.where((element) => element.id == json['roomType']).single,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'roomName': roomName,
        'dateStart': dateStart,
        'dateEnd': dateEnd,
        'roomId': roomId,
        'status': status,
        'totalPrice': totalPrice,
        'uid': uid,
        'roomType': roomTypeModel.id
      };
}
