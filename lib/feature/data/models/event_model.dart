import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotel_ma/feature/domain/entities/event_entity.dart';

class EventModel extends EventEntity {
  const EventModel({required DateTime dateEnd,
    required DateTime dateStart,
    required List<dynamic> description,
    required String image,
    required String status,
    required String title,
    required String type})
      : super(dateEnd: dateEnd,
      dateStart: dateStart,
      description: description,
      image: image,
      status: status,
      title: title,
      type: type);


  factory EventModel.fromJson(Map<String, dynamic> json) =>
      EventModel(dateEnd: (json['dateEnd'] as Timestamp).toDate(),
          dateStart: (json['dateStart'] as Timestamp).toDate(),
          description: json['description'],
          image: json['image'],
          status: json['status'],
          title: json['title'],
          type: json['type']);
}
