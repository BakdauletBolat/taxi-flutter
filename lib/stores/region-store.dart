// ignore_for_file: file_names

import 'package:mobx/mobx.dart';
import 'package:taxizakaz/api/region-service.dart';
import 'package:taxizakaz/models/city.dart';

// Include generated file
part 'region-store.g.dart';

// This is the class used by rest of your codebase
class RegionStore = RegionBase with _$RegionStore;

// The store-class
abstract class RegionBase with Store {
  @observable
  bool isAuth = true;

  List<City> cities = [];

  RegionService service = RegionService();

  void loadCities() async {
    List<City> citiesData = await service.getCities();
    runInAction(() => {cities = citiesData});
  }
}
