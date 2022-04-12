import 'package:hotel_ma/feature/domain/entities/room_entity.dart';

class RoomModel extends RoomEntity {
  const RoomModel(
      {required int id,
      required String isSmoking,
      required int bedsCount,
      required String? description,
      required String name,
      required int price,
      required int rating,
      required String type})
      : super(id: id, isSmoking: isSmoking, bedsCount: bedsCount, description: description, name: name, price: price, rating: rating, type: type);

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'isSmoking': isSmoking,
        'bedsCount': bedsCount,
        'description': description,
        'name': name,
        'price': price,
        'rating': rating,
        'type': type,
      };

  factory RoomModel.fromJson(Map<String, dynamic> json) => RoomModel(
      id: json['id'],
      isSmoking: json['isSmoking'],
      bedsCount: json['bedsCount'],
      description: json['description'],
      name: json['name'],
      price: json['price'],
      rating: json['rating'],
      type: json['type']);
}
