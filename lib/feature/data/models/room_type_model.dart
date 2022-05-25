import 'package:hotel_ma/feature/domain/entities/room_type_entity.dart';

class RoomTypeModel extends RoomTypeEntity {
  const RoomTypeModel({required String id, String? color, String? description, String? title})
      : super(id: id, color: color, description: description, title: title);

  factory RoomTypeModel.fromJson(Map<String, dynamic> json, String id) =>
      RoomTypeModel(id: id, color: json['color'], description: json['description'], title: json['title']);
}
