import 'package:equatable/equatable.dart';

class BookingEntity extends Equatable {
  final String roomName;
  final String roomType;

  final DateTime dateStart;
  final DateTime dateEnd;
  final String roomId;
  final String status;
  final int totalPrice;
  final String uid;

  const BookingEntity(
      {required this.roomName,
      required this.roomType,

      required this.dateStart,
      required this.dateEnd,
      required this.roomId,
      required this.status,
      required this.totalPrice,
      required this.uid});

  @override
  List<Object> get props => [
        roomName,
        roomType,

        dateStart,
        dateEnd,
        roomId,
        status,
        totalPrice,
        uid,
      ];
}
