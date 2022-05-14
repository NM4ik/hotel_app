import 'package:equatable/equatable.dart';
import 'package:hotel_ma/feature/data/models/room_type_model.dart';
import 'package:hotel_ma/feature/domain/entities/room_type_entity.dart';

class RoomEntity extends Equatable {
  final String id;
  final String? isSmoking;
  final int bedsCount;
  final String? description;
  final List<String>? images;
  final RoomTypeModel roomTypeModel;
  final String name;
  final int price;
  final int rating;
  final String type;
  final String checkIn;
  final String eviction;

  const RoomEntity(
      {required this.id,
      required this.isSmoking,
      required this.bedsCount,
      required this.description,
      required this.images,
      required this.roomTypeModel,
      required this.name,
      required this.price,
      required this.rating,
      required this.type,
      required this.checkIn,
      required this.eviction});

  @override
  List<Object?> get props => [
        roomTypeModel,
        images,
        id,
        isSmoking,
        bedsCount,
        description,
        name,
        price,
        rating,
        type,
    checkIn,
    eviction
      ];
}
