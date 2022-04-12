import 'package:equatable/equatable.dart';

class VisitEntity extends Equatable {
  final String dateEnd;
  final String dateStart;
  final String price;
  final String roomName;
  final String roomType;

  const VisitEntity({required this.dateEnd, required this.dateStart, required this.price, required this.roomName, required this.roomType});

  @override
  List<Object> get props => [dateEnd, dateStart, price, roomName, roomType];
}
