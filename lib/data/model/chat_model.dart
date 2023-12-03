// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ChatModel {
  final String imagePath;
  final String chatName;
  final String messageDate;
  final String messageSubtittle;
  ChatModel({
    required this.imagePath,
    required this.chatName,
    required this.messageDate,
    required this.messageSubtittle,
  });

  ChatModel copyWith({
    String? imagePath,
    String? chatName,
    String? messageDate,
    String? messageSubtittle,
  }) {
    return ChatModel(
      imagePath: imagePath ?? this.imagePath,
      chatName: chatName ?? this.chatName,
      messageDate: messageDate ?? this.messageDate,
      messageSubtittle: messageSubtittle ?? this.messageSubtittle,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'imagePath': imagePath,
      'chatName': chatName,
      'messageDate': messageDate,
      'messageSubtittle': messageSubtittle,
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      imagePath: map['imagePath'] as String,
      chatName: map['chatName'] as String,
      messageDate: map['messageDate'] as String,
      messageSubtittle: map['messageSubtittle'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatModel.fromJson(String source) =>
      ChatModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChatModel(imagePath: $imagePath, chatName: $chatName, messageDate: $messageDate, messageSubtittle: $messageSubtittle)';
  }

  @override
  bool operator ==(covariant ChatModel other) {
    if (identical(this, other)) return true;

    return other.imagePath == imagePath &&
        other.chatName == chatName &&
        other.messageDate == messageDate &&
        other.messageSubtittle == messageSubtittle;
  }

  @override
  int get hashCode {
    return imagePath.hashCode ^
        chatName.hashCode ^
        messageDate.hashCode ^
        messageSubtittle.hashCode;
  }
}
