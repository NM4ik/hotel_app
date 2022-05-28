import 'package:equatable/equatable.dart';
import 'package:hotel_ma/feature/data/models/room_type_model.dart';
import 'package:hotel_ma/feature/domain/entities/room_type_entity.dart';

class RoomEntity extends Equatable {
  final String id;
  final int bedsCount;
  final List<dynamic>? description;
  final List<dynamic>? images;
  final List<dynamic>? tags;
  final RoomTypeModel roomTypeModel;
  final String name;
  final int price;
  final int rating;
  final String type;
  final String checkIn;
  final String eviction;

  const RoomEntity(
      {required this.tags,
      required this.id,
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
  List<Object?> get props => [roomTypeModel, images, id, tags, bedsCount, description, name, price, rating, type, checkIn, eviction];
}
