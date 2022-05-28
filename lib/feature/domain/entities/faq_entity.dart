import 'package:equatable/equatable.dart';

class FaqEntity extends Equatable {
  final DateTime date;
  final List<dynamic>? description;
  final String? image;
  final String title;

  const FaqEntity({required this.date, required this.description, required this.image, required this.title});

  @override
  List<Object?> get props => [date, description, image, title];
}
