import 'package:equatable/equatable.dart';

class EventEntity extends Equatable {
  final DateTime dateEnd;
  final DateTime dateStart;
  final List<dynamic> description;
  final String image;
  final String status;
  final String title;
  final String type;

  const EventEntity(
      {required this.dateEnd,
      required this.dateStart,
      required this.description,
      required this.image,
      required this.status,
      required this.title,
      required this.type});

  @override
  List<Object> get props => [
        dateEnd,
        dateStart,
        description,
        image,
        status,
        title,
        type,
      ];
}
