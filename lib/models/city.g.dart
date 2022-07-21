// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Region _$RegionFromJson(Map<String, dynamic> json) => Region(
      name: json['name'] as String,
      id: json['id'] as int?,
    );

Map<String, dynamic> _$RegionToJson(Region instance) => <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
    };

City _$CityFromJson(Map<String, dynamic> json) => City(
      name: json['name'] as String,
      id: json['id'] as int?,
      region: Region.fromJson(json['region'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CityToJson(City instance) => <String, dynamic>{
      'name': instance.name,
      'region': instance.region,
      'id': instance.id,
    };
