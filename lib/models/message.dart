import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable()
class MessageType {
  final String name;
  final int? id;

  MessageType({required this.name, this.id});

  factory MessageType.fromJson(Map<String, dynamic> json) =>
      _$MessageTypeFromJson(json);

  Map<String, dynamic> toJson() => _$MessageTypeToJson(this);
}

@JsonSerializable()
class Message {
  final String title, text;
  final int? id;
  final DateTime created_at;
  final bool is_read;
  final MessageType type;

  Message(
      {this.id,
      required this.text,
      required this.title,
      required this.created_at,
      required this.is_read,
      required this.type});

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
