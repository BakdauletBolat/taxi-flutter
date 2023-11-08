// ignore_for_file: file_names

import 'package:taxizakaz/api/api-service.dart';
import 'package:taxizakaz/models/city.dart';

class RegionService extends ApiService {
  Future<List<City>> getCities({String? name}) async {
    String url = '/regions/city/?';
    if (name != null) {
      url += 'search=$name';
    }

    var res = await api.get(url);
    List<City> cities =
        res.data.map<City>((obj) => City.fromJson(obj)).toList();
    return cities;
  }

  Future<List<Region>> getRegions({String? name}) async {
    String url = '/regions/?';
    if (name != null) {
      url += 'search=$name';
    }

    var res = await api.get(url);
    List<Region> items =
        res.data.map<Region>((obj) => Region.fromJson(obj)).toList();
    return items;
  }
}
