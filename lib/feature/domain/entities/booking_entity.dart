import 'package:equatable/equatable.dart';
import 'package:hotel_ma/feature/data/models/room_type_model.dart';

class BookingEntity extends Equatable {
  final String id;

  final String roomName;
  final String roomType;

  final DateTime dateStart;
  final DateTime dateEnd;
  final String roomId;
  final String status;
  final int totalPrice;
  final String uid;
  final RoomTypeModel roomTypeModel;

  const BookingEntity(
      {
        required this.id,
        required this.roomName,
      required this.roomType,

      required this.dateStart,
      required this.dateEnd,
      required this.roomId,
      required this.status,
      required this.totalPrice,
      required this.uid,
      required this.roomTypeModel
      });

  @override
  List<Object> get props => [
    id,
        roomName,
        roomType,

        dateStart,
        dateEnd,
        roomId,
        status,
        totalPrice,
        uid,
        roomTypeModel
      ];
}
