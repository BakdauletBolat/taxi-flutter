// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

City _$CityFromJson(Map<String, dynamic> json) => City(
      name: json['name'] as String,
      id: json['id'] as int?,
    );

Map<String, dynamic> _$CityToJson(City instance) => <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
    };

Region _$RegionFromJson(Map<String, dynamic> json) => Region(
      name: json['name'] as String,
      id: json['id'] as int?,
      cities: (json['cities'] as List<dynamic>)
          .map((e) => City.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RegionToJson(Region instance) => <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'cities': instance.cities,
    };

CityToCityPrice _$CityToCityPriceFromJson(Map<String, dynamic> json) =>
    CityToCityPrice(
      id: json['id'] as int,
      coin: json['coin'] as int,
      from_city: City.fromJson(json['from_city'] as Map<String, dynamic>),
      to_city: City.fromJson(json['to_city'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CityToCityPriceToJson(CityToCityPrice instance) =>
    <String, dynamic>{
      'id': instance.id,
      'coin': instance.coin,
      'from_city': instance.from_city,
      'to_city': instance.to_city,
    };
