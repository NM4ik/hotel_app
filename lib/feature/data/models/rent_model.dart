import 'package:hotel_ma/feature/domain/entities/rent_entity.dart';

class RentModel extends RentEntity {
  const RentModel(
      {required String id,
      required String category,
      required String image,
      required String name,
      required String prePayment,
      required String price,
      required List<Map<dynamic, dynamic>>? characters,
      required List<dynamic>? documents})
      : super(id: id, category: category, image: image, name: name, prePayment: prePayment, price: price, characters: characters, documents: documents);

  factory RentModel.fromJson(Map<String, dynamic> json, String id) => RentModel(
      id: id,
      category: json['category'],
      image: json['image'],
      name: json['name'],
      prePayment: json['prePayment'],
      price: json['price'],
      characters: json['characters'] == null
          ? null
          : List<Map<String, dynamic>>.from(
              json['characters'],
            ),
      documents: json['documents']);
}
