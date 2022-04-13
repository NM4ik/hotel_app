import 'package:hotel_ma/feature/domain/entities/message_entity.dart';

class MessageModel extends MessageEntity {
  const MessageModel({required String content, required DateTime sendAt, required String sendBy}) : super(content: content, sendAt: sendAt, sendBy: sendBy);

  Map<String, dynamic> toJson() => <String, dynamic>{
        'content': content,
        'sendAt': sendAt.millisecondsSinceEpoch,
        'sendBy': sendBy,
      };
}
