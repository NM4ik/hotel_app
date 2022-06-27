import 'dart:developer';

import 'package:hotel_ma/feature/data/models/room_type_model.dart';
import 'package:hotel_ma/feature/domain/entities/room_entity.dart';

class RoomModel extends RoomEntity {
  const RoomModel(
      {required String id,
      required int bedsCount,
      required List<dynamic>? description,
      required List<dynamic>? images,
      required List<dynamic>? tags,
      required RoomTypeModel roomTypeModel,
      required String name,
      required int price,
      required int rating,
      required String type,
      required String checkIn,
      required String eviction})
      : super(
            id: id,
            tags: tags,
            bedsCount: bedsCount,
            description: description,
            name: name,
            price: price,
            rating: rating,
            type: type,
            images: images,
            roomTypeModel: roomTypeModel,
            checkIn: checkIn,
            eviction: eviction);

  factory RoomModel.fromJson(Map<String, dynamic> json, String id, List<RoomTypeModel> roomTypes) {
     return RoomModel(
          id: id,
          tags: json['tags'],
          bedsCount: json['bedsCount'],
          images: json['images'],
          description: json['description'],
          name: json['name'],
          price: json['price'],
          rating: json['rating'].toInt(),
          type: json['type'],
          roomTypeModel: roomTypes
              .where((element) => element.id == json['type'])
              .single,
          checkIn: json['checkIn'],
          eviction: json['eviction']);
  }
}
