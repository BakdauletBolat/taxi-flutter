import 'package:json_annotation/json_annotation.dart';

part 'city.g.dart';

@JsonSerializable()
class Region {
  final String name;
  final int? id;

  Region({required this.name, this.id});

  factory Region.fromJson(Map<String, dynamic> json) => _$RegionFromJson(json);

  Map<String, dynamic> toJson() => _$RegionToJson(this);
}

@JsonSerializable()
class City {
  final String name;
  final Region? region;
  final int? id;

  City({required this.name, this.id, this.region});

  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);

  Map<String, dynamic> toJson() => _$CityToJson(this);
}

@JsonSerializable()
@JsonSerializable()
class CityToCityPrice {
  final int id;
  final int coin;
  final City from_city;
  final City to_city;

  CityToCityPrice(
      {required this.id,
      required this.coin,
      required this.from_city,
      required this.to_city});

  factory CityToCityPrice.fromJson(Map<String, dynamic> json) =>
      _$CityToCityPriceFromJson(json);

  Map<String, dynamic> toJson() => _$CityToCityPriceToJson(this);
}
