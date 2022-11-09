// ignore_for_file: file_names, non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'create-order.g.dart';

@JsonSerializable()
class CreateOrder {
  final int from_city_id, to_city_id, price;
  final String? from_address, to_address;
  final String? comment;
  final String date_time;

  CreateOrder(
      {this.from_address,
      required this.from_city_id,
      this.to_address,
      required this.to_city_id,
      required this.price,
      this.comment,
      required this.date_time});

  factory CreateOrder.fromJson(Map<String, dynamic> json) =>
      _$CreateOrderFromJson(json);

  Map<String, dynamic> toJson() => _$CreateOrderToJson(this);
}
