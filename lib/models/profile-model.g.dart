// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile-model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDocumentsGet _$UserDocumentsGetFromJson(Map<String, dynamic> json) =>
    UserDocumentsGet(
      passport_photo_back: json['passport_photo_back'] as String?,
      passport_photo_front: json['passport_photo_front'] as String?,
      car_passport_back: json['car_passport_back'] as String?,
      car_passport_front: json['car_passport_front'] as String?,
    );

Map<String, dynamic> _$UserDocumentsGetToJson(UserDocumentsGet instance) =>
    <String, dynamic>{
      'passport_photo_front': instance.passport_photo_front,
      'passport_photo_back': instance.passport_photo_back,
      'car_passport_front': instance.car_passport_front,
      'car_passport_back': instance.car_passport_back,
    };

UserDocumentsCreate _$UserDocumentsCreateFromJson(Map<String, dynamic> json) =>
    UserDocumentsCreate();

Map<String, dynamic> _$UserDocumentsCreateToJson(
        UserDocumentsCreate instance) =>
    <String, dynamic>{};

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) => UserInfo(
      first_name: json['first_name'] as String?,
      last_name: json['last_name'] as String?,
      email: json['email'] as String?,
      birthday: json['birthday'] == null
          ? null
          : DateTime.parse(json['birthday'] as String),
      city_id: json['city_id'] as int?,
    );

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'email': instance.email,
      'birthday': instance.birthday?.toIso8601String(),
      'city_id': instance.city_id,
    };

UserInfoGet _$UserInfoGetFromJson(Map<String, dynamic> json) => UserInfoGet(
      avatar: json['avatar'] as String?,
      email: json['email'] as String?,
      last_name: json['last_name'] as String?,
      first_name: json['first_name'] as String?,
      birthday: json['birthday'] == null
          ? null
          : DateTime.parse(json['birthday'] as String),
      city_id: json['city_id'] as int?,
    );

Map<String, dynamic> _$UserInfoGetToJson(UserInfoGet instance) =>
    <String, dynamic>{
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'email': instance.email,
      'birthday': instance.birthday?.toIso8601String(),
      'city_id': instance.city_id,
      'avatar': instance.avatar,
    };

UserInfoCreate _$UserInfoCreateFromJson(Map<String, dynamic> json) =>
    UserInfoCreate(
      email: json['email'] as String?,
      last_name: json['last_name'] as String?,
      first_name: json['first_name'] as String?,
      birthday: json['birthday'] == null
          ? null
          : DateTime.parse(json['birthday'] as String),
      city_id: json['city_id'] as int?,
    );

Map<String, dynamic> _$UserInfoCreateToJson(UserInfoCreate instance) =>
    <String, dynamic>{
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'email': instance.email,
      'birthday': instance.birthday?.toIso8601String(),
      'city_id': instance.city_id,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      phone: json['phone'] as String,
      type_user: json['type_user'] as int?,
      id: json['id'] as int?,
      user_document: json['user_document'] == null
          ? null
          : UserDocumentsGet.fromJson(
              json['user_document'] as Map<String, dynamic>),
      coins_expected: json['coins_expected'] as int?,
      coins: json['coins'] as int?,
      user_info: json['user_info'] == null
          ? null
          : UserInfoGet.fromJson(json['user_info'] as Map<String, dynamic>),
      driver_can_view_order_date: json['driver_can_view_order_date'] == null
          ? null
          : DateTime.parse(json['driver_can_view_order_date'] as String),
      is_driver: json['is_driver'] as bool?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'phone': instance.phone,
      'id': instance.id,
      'type_user': instance.type_user,
      'user_info': instance.user_info,
      'driver_can_view_order_date':
          instance.driver_can_view_order_date?.toIso8601String(),
      'is_driver': instance.is_driver,
      'coins': instance.coins,
      'coins_expected': instance.coins_expected,
      'user_document': instance.user_document,
    };

Payment _$PaymentFromJson(Map<String, dynamic> json) => Payment(
      id: json['id'] as int,
      gen_id: json['gen_id'] as String?,
      coin: json['coin'] as int,
      created_at: DateTime.parse(json['created_at'] as String),
      is_confirmed: json['is_confirmed'] as bool,
      user_id: json['user_id'] as int?,
    );

Map<String, dynamic> _$PaymentToJson(Payment instance) => <String, dynamic>{
      'id': instance.id,
      'gen_id': instance.gen_id,
      'coin': instance.coin,
      'user_id': instance.user_id,
      'is_confirmed': instance.is_confirmed,
      'created_at': instance.created_at.toIso8601String(),
    };
