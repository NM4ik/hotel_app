import 'package:equatable/equatable.dart';

class RoomEntity extends Equatable {
  final int id;
  final String? isSmoking;
  final int bedsCount;
  final String? description;
  final List<String>? images;
  final String name;
  final int price;
  final int rating;
  final String type;

  const RoomEntity(
      {required this.images,
      required this.id,
      required this.isSmoking,
      required this.bedsCount,
      required this.description,
      required this.name,
      required this.price,
      required this.rating,
      required this.type});

  @override
  List<Object?> get props => [
        images,
        id,
        isSmoking,
        bedsCount,
        description,
        name,
        price,
        rating,
        type,
      ];
}
