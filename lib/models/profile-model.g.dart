// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile-model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileInfo _$ProfileInfoFromJson(Map<String, dynamic> json) => ProfileInfo(
      first_name: json['first_name'] as String?,
      last_name: json['last_name'] as String?,
      email: json['email'] as String?,
      birthday: json['birthday'] == null
          ? null
          : DateTime.parse(json['birthday'] as String),
      city_id: json['city_id'] as int?,
    );

Map<String, dynamic> _$ProfileInfoToJson(ProfileInfo instance) =>
    <String, dynamic>{
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'email': instance.email,
      'birthday': instance.birthday?.toIso8601String(),
      'city_id': instance.city_id,
    };

ProfileInfoCreate _$ProfileInfoCreateFromJson(Map<String, dynamic> json) =>
    ProfileInfoCreate(
      email: json['email'] as String?,
      last_name: json['last_name'] as String?,
      first_name: json['first_name'] as String?,
      birthday: json['birthday'] == null
          ? null
          : DateTime.parse(json['birthday'] as String),
      city_id: json['city_id'] as int?,
    );

Map<String, dynamic> _$ProfileInfoCreateToJson(ProfileInfoCreate instance) =>
    <String, dynamic>{
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'email': instance.email,
      'birthday': instance.birthday?.toIso8601String(),
      'city_id': instance.city_id,
    };

Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile(
      phone: json['phone'] as String,
      id: json['id'] as int?,
      profile_info: json['profile_info'] == null
          ? null
          : ProfileInfo.fromJson(json['profile_info'] as Map<String, dynamic>),
      driver_can_view_order_date: json['driver_can_view_order_date'] == null
          ? null
          : DateTime.parse(json['driver_can_view_order_date'] as String),
      is_driver: json['is_driver'] as bool?,
    );

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'phone': instance.phone,
      'id': instance.id,
      'profile_info': instance.profile_info,
      'driver_can_view_order_date':
          instance.driver_can_view_order_date?.toIso8601String(),
      'is_driver': instance.is_driver,
    };
