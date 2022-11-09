// ignore_for_file: non_constant_identifier_names, file_names

import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile-model.g.dart';

@JsonSerializable()
class UserDocumentsGet {
  final String? passport_photo_front;
  final String? passport_photo_back;
  final String? car_passport;

  UserDocumentsGet(
      {this.passport_photo_back, this.passport_photo_front, this.car_passport});

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
  String? car_passport;

  UserDocumentsCreate(
      {this.passport_photo_back, this.passport_photo_front, this.car_passport});

  factory UserDocumentsCreate.fromJson(Map<String, dynamic> json) =>
      _$UserDocumentsCreateFromJson(json);

  Map<String, dynamic> toJson() => _$UserDocumentsCreateToJson(this);
}

@JsonSerializable()
class ProfileInfo {
  final String? first_name;
  final String? last_name;
  final String? email;
  final DateTime? birthday;
  final int? city_id;

  ProfileInfo(
      {this.first_name,
      this.last_name,
      this.email,
      this.birthday,
      this.city_id});

  factory ProfileInfo.fromJson(Map<String, dynamic> json) =>
      _$ProfileInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileInfoToJson(this);
}

@JsonSerializable()
class ProfileInfoGet extends ProfileInfo {
  String? avatar;

  ProfileInfoGet(
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

  factory ProfileInfoGet.fromJson(Map<String, dynamic> json) =>
      _$ProfileInfoGetFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ProfileInfoGetToJson(this);
}

@JsonSerializable()
class ProfileInfoCreate extends ProfileInfo {
  @JsonKey(ignore: true)
  MultipartFile? avatar;

  ProfileInfoCreate(
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

  factory ProfileInfoCreate.fromJson(Map<String, dynamic> json) =>
      _$ProfileInfoCreateFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ProfileInfoCreateToJson(this);
}

@JsonSerializable()
class Profile {
  final String phone;
  final int? id, type_user;
  final ProfileInfoGet? profile_info;
  final DateTime? driver_can_view_order_date;
  final bool? is_driver;
  final int? coins;
  final int? coins_expected;
  final UserDocumentsGet? user_document;

  Profile(
      {required this.phone,
      this.type_user,
      this.id,
      this.user_document,
      this.coins_expected,
      this.coins,
      required this.profile_info,
      required this.driver_can_view_order_date,
      required this.is_driver});

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);
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
