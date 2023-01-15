// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';
import 'package:taxizakaz/models/city.dart';
import 'package:taxizakaz/models/profile-model.dart';

part 'order.g.dart';

@JsonSerializable()
class TypeOrder {
  final String name;
  final int id;

  TypeOrder({required this.name, required this.id});

  factory TypeOrder.fromJson(Map<String, dynamic> json) =>
      _$TypeOrderFromJson(json);

  Map<String, dynamic> toJson() => _$TypeOrderToJson(this);
}

@JsonSerializable()
class Order {
  final String? from_address, to_address, comment;
  final int id, price;
  final City from_city, to_city;
  final TypeOrder type_order;
  final User user;
  final DateTime date_time;
  final bool is_active;

  Order({
    required this.from_address,
    required this.to_address,
    required this.comment,
    required this.id,
    required this.price,
    required this.type_order,
    required this.from_city,
    required this.to_city,
    required this.user,
    required this.is_active,
    required this.date_time,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
