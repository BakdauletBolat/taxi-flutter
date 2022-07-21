import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile-model.g.dart';

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

  Map<String, dynamic> toJson() => _$ProfileInfoCreateToJson(this);
}

@JsonSerializable()
class Profile {
  final String phone;
  final int? id;
  final ProfileInfo? profile_info;
  final DateTime? driver_can_view_order_date;
  final bool? is_driver;

  Profile(
      {required this.phone,
      this.id,
      required this.profile_info,
      required this.driver_can_view_order_date,
      required this.is_driver});

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}
