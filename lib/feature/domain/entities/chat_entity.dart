import 'package:equatable/equatable.dart';
import 'package:hotel_ma/feature/data/models/message_model.dart';

class ChatEntity extends Equatable {
  final String? name;
  final DateTime createdAt;
  final int status;
  final String uid;
  final List<String> userIds;
  final MessageModel recentMessage;

  const ChatEntity({required this.name, required this.createdAt, required this.status, required this.uid, required this.userIds, required this.recentMessage});

  @override
  List<Object?> get props => [
        name,
        createdAt,
        status,
        uid,
        userIds,
        recentMessage,
      ];
}
