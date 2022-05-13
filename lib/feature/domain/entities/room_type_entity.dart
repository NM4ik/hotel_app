import 'package:equatable/equatable.dart';

class RoomTypeEntity extends Equatable {
  final String id;
  final String color;
  final String description;
  final String title;

  const RoomTypeEntity({
    required this.id,
    required this.color,
    required this.description,
    required this.title,
  });

  @override
  List<Object> get props => [id, color, description, title];
}
