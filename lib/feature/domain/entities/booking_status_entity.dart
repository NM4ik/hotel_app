import 'package:equatable/equatable.dart';

class BookingStatusEntity extends Equatable {
  final String id;
  final String? color;
  final String? title;

  const BookingStatusEntity({required this.id, required this.color, required this.title});

  @override
  List<Object?> get props => [id, color, title];
}
