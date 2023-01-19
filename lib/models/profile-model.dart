// ignore_for_file: non_constant_identifier_names, file_names

import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile-model.g.dart';

@JsonSerializable()
class Car {
  final int id;
  final String name;

  Car({required this.id, required this.name});

  factory Car.fromJson(Map<String, dynamic> json) => _$CarFromJson(json);

  Map<String, dynamic> toJson() => _$CarToJson(this);
}

@JsonSerializable()
class CarModel {
  final int id;
  final String name;

  CarModel({required this.id, required this.name});

  factory CarModel.fromJson(Map<String, dynamic> json) =>
      _$CarModelFromJson(json);

  Map<String, dynamic> toJson() => _$CarModelToJson(this);
}

@JsonSerializable()
class CarInfo {
  final int id;
  final Car car;
  final String? year;
  final String? number;
  final String? color;
  final CarModel model;

  CarInfo(
      {required this.id,
      required this.car,
      required this.model,
      this.year,
      this.color,
      this.number});

  factory CarInfo.fromJson(Map<String, dynamic> json) =>
      _$CarInfoFromJson(json);

  Map<String, dynamic> toJson() => _$CarInfoToJson(this);
}

@JsonSerializable()
class UserDocumentsGet {
  final String? passport_photo_front;
  final String? passport_photo_back;
  final String? car_passport_front;
  final String? car_passport_back;
  final CarInfo? car;

  UserDocumentsGet(
      {this.passport_photo_back,
      this.car,
      this.passport_photo_front,
      this.car_passport_back,
      this.car_passport_front});

  factory UserDocumentsGet.fromJson(Map<String, dynamic> json) =>
      _$UserDocumentsGetFromJson(json);

  Map<String, dynamic> toJson() => _$UserDocumentsGetToJson(this);
}

@JsonSerializable()
class UserDocumentsCreate {
  @JsonKey(ignore: true)
  String? passport_photo_front;
  @JsonKey(ignore: true)
  String? passport_photo_back;
  @JsonKey(ignore: true)
  String? car_passport_front;
  @JsonKey(ignore: true)
  String? car_passport_back;

  UserDocumentsCreate(
      {this.passport_photo_back,
      this.passport_photo_front,
      this.car_passport_front,
      this.car_passport_back});

  factory UserDocumentsCreate.fromJson(Map<String, dynamic> json) =>
      _$UserDocumentsCreateFromJson(json);

  Map<String, dynamic> toJson() => _$UserDocumentsCreateToJson(this);
}

@JsonSerializable()
class UserInfo {
  final String? first_name;
  final String? last_name;
  final String? email;
  final DateTime? birthday;
  final int? city_id;

  UserInfo(
      {this.first_name,
      this.last_name,
      this.email,
      this.birthday,
      this.city_id});

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}

@JsonSerializable()
class UserInfoGet extends UserInfo {
  String? avatar;

  UserInfoGet(
      {this.avatar,
      String? email,
      String? last_name,
      String? first_name,
      DateTime? birthday,
      int? city_id})
      : super(
            email: email,
            last_name: last_name,
            first_name: first_name,
            birthday: birthday,
            city_id: city_id);

  factory UserInfoGet.fromJson(Map<String, dynamic> json) =>
      _$UserInfoGetFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserInfoGetToJson(this);
}

@JsonSerializable()
class UserInfoCreate extends UserInfo {
  @JsonKey(ignore: true)
  MultipartFile? avatar;

  UserInfoCreate(
      {this.avatar,
      String? email,
      String? last_name,
      String? first_name,
      DateTime? birthday,
      int? city_id})
      : super(
            email: email,
            last_name: last_name,
            first_name: first_name,
            birthday: birthday,
            city_id: city_id);

  factory UserInfoCreate.fromJson(Map<String, dynamic> json) =>
      _$UserInfoCreateFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserInfoCreateToJson(this);
}

@JsonSerializable()
class User {
  final String phone;
  final int? id, type_user;
  final UserInfoGet? user_info;
  final DateTime? driver_can_view_order_date;
  final bool? is_driver;
  final int? coins;
  final int? coins_expected;
  final List<int> access_orders_ids;
  final UserDocumentsGet? user_document;

  User(
      {required this.phone,
      this.type_user,
      this.id,
      this.user_document,
      this.coins_expected,
      this.coins,
      required this.access_orders_ids,
      required this.user_info,
      required this.driver_can_view_order_date,
      required this.is_driver});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class Payment {
  int id;
  String? gen_id;
  int coin;
  int? user_id;
  bool is_confirmed;
  DateTime created_at;

  Payment({
    required this.id,
    this.gen_id,
    required this.coin,
    required this.created_at,
    required this.is_confirmed,
    this.user_id,
  });

  factory Payment.fromJson(Map<String, dynamic> json) =>
      _$PaymentFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentToJson(this);
}
