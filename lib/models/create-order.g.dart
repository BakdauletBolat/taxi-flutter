// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create-order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateOrder _$CreateOrderFromJson(Map<String, dynamic> json) => CreateOrder(
      from_address: json['from_address'] as String,
      from_city_id: json['from_city_id'] as int,
      to_address: json['to_address'] as String,
      to_city_id: json['to_city_id'] as int,
      price: json['price'] as int,
      comment: json['comment'] as String,
      date_time: DateTime.parse(json['date_time'] as String),
    );

Map<String, dynamic> _$CreateOrderToJson(CreateOrder instance) =>
    <String, dynamic>{
      'from_city_id': instance.from_city_id,
      'to_city_id': instance.to_city_id,
      'price': instance.price,
      'from_address': instance.from_address,
      'to_address': instance.to_address,
      'comment': instance.comment,
      'date_time': instance.date_time.toIso8601String(),
    };
