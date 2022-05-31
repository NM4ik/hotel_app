import 'package:equatable/equatable.dart';

class RentEntity extends Equatable {
  final String id;
  final String category;
  final List<dynamic>? images;
  final String title;
  final String price;

  final String? prePayment;
  final String? salePrice;
  final DateTime? saleTimeEnd;
  final List<Map<String, dynamic>>? characters;
  final List<Map<String, dynamic>>? documents;

  const RentEntity(
      {required this.id,
      required this.category,
      required this.images,
      required this.title,
      required this.prePayment,
      required this.price,
      required this.salePrice,
      required this.saleTimeEnd,
      required this.characters,
      required this.documents});

  @override
  List<Object?> get props => [id, category, images, title, prePayment, price, salePrice, characters, documents];
}
