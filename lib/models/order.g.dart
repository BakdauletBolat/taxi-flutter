// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TypeOrder _$TypeOrderFromJson(Map<String, dynamic> json) => TypeOrder(
      name: json['name'] as String,
      id: json['id'] as int,
    );

Map<String, dynamic> _$TypeOrderToJson(TypeOrder instance) => <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
    };

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      from_address: json['from_address'] as String?,
      to_address: json['to_address'] as String?,
      comment: json['comment'] as String?,
      id: json['id'] as int,
      price: json['price'] as int,
      type_order:
          TypeOrder.fromJson(json['type_order'] as Map<String, dynamic>),
      from_city: City.fromJson(json['from_city'] as Map<String, dynamic>),
      to_city: City.fromJson(json['to_city'] as Map<String, dynamic>),
      user: Profile.fromJson(json['user'] as Map<String, dynamic>),
      is_active: json['is_active'] as bool,
      date_time: DateTime.parse(json['date_time'] as String),
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'from_address': instance.from_address,
      'to_address': instance.to_address,
      'comment': instance.comment,
      'id': instance.id,
      'price': instance.price,
      'from_city': instance.from_city,
      'to_city': instance.to_city,
      'type_order': instance.type_order,
      'user': instance.user,
      'date_time': instance.date_time.toIso8601String(),
      'is_active': instance.is_active,
    };
