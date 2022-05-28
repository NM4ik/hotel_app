import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotel_ma/feature/domain/entities/faq_entity.dart';

class FaqModel extends FaqEntity {
  const FaqModel({required DateTime date, required List<dynamic>? description, required String? image, required String title})
      : super(date: date, description: description, image: image, title: title);

  factory FaqModel.fromJson(Map<String, dynamic> json) =>
      FaqModel(date: (json['date'] as Timestamp).toDate(), description: json['description'], image: json['image'], title: json['title']);
}
