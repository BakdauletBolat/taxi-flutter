// ignore_for_file: file_names

import 'package:taxizakaz/api/api-service.dart';
import 'package:taxizakaz/models/city.dart';

class RegionService extends ApiService {
  Future<List<City>> getCities({String? name}) async {
    var res = await api.get('/regions/city/');
    List<City> cities =
        res.data.map<City>((obj) => City.fromJson(obj)).toList();
    return cities;
  }
}
