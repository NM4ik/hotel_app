import 'package:equatable/equatable.dart';

class MessageEntity extends Equatable {
  final String content;
  final DateTime sendAt;
  final String sendBy;

  const MessageEntity({required this.content, required this.sendAt, required this.sendBy});

  @override
  String toString() {
    return 'MessageEntity{content: $content, sendAt: $sendAt, sendBy: $sendBy}';
  }

  @override
  List<Object> get props => [content, sendAt, sendBy];
}
