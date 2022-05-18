import 'package:hotel_ma/feature/data/models/message_model.dart';
import 'package:hotel_ma/feature/domain/entities/chat_entity.dart';

class ChatModel extends ChatEntity {
  const ChatModel(
      {required String? name,
      required DateTime createdAt,
      required int status,
      required String uid,
      required List<String> userIds,
      required MessageModel recentMessage})
      : super(name: name, createdAt: createdAt, status: status, uid: uid, userIds: userIds, recentMessage: recentMessage);

  Map<String, dynamic> toJson() => <String, dynamic>{
        'createdAt': createdAt,
        'name': name,
        'status': status,
        'uid': uid,
        'userIds': userIds,
        'recentMessage': recentMessage.toJson(),
      };
}
