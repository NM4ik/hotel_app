import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotel_ma/feature/domain/entities/rent_entity.dart';

class RentModel extends RentEntity {
  const RentModel(
      {required String id,
      required String category,
      required String image,
      required String title,
      required String? prePayment,
      required String price,
      required String? salePrice,
      required DateTime? saleTimeEnd,
      required List<Map<String, dynamic>>? characters,
      required List<Map<String, dynamic>>? documents})
      : super(
            id: id,
            category: category,
            image: image,
            title: title,
            prePayment: prePayment,
            price: price,
            salePrice: salePrice,
            saleTimeEnd: saleTimeEnd,
            characters: characters,
            documents: documents);

  factory RentModel.fromJson(Map<String, dynamic> json, String id) => RentModel(
        id: id,
        category: json['category'],
        image: json['image'],
        title: json['title'],
        prePayment: json['prePayment'],
        price: json['price'],
        salePrice: json['salePrice'],
        saleTimeEnd: json['saleTimeEnd'] == null ? null : (json['saleTimeEnd'] as Timestamp).toDate(),
        characters: json['characters'] == null
            ? null
            : List<Map<String, dynamic>>.from(
                json['characters'],
              ),
        documents: json['documents'] == null
            ? null
            : List<Map<String, dynamic>>.from(
                json['documents'],
              ),
      );
}
