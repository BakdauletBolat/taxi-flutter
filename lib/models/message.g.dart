// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageType _$MessageTypeFromJson(Map<String, dynamic> json) => MessageType(
      name: json['name'] as String,
      id: json['id'] as int?,
    );

Map<String, dynamic> _$MessageTypeToJson(MessageType instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
    };

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      id: json['id'] as int?,
      text: json['text'] as String,
      title: json['title'] as String,
      created_at: DateTime.parse(json['created_at'] as String),
      is_read: json['is_read'] as bool,
      type: MessageType.fromJson(json['type'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'title': instance.title,
      'text': instance.text,
      'id': instance.id,
      'created_at': instance.created_at.toIso8601String(),
      'is_read': instance.is_read,
      'type': instance.type,
    };
