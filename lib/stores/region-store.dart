import 'package:mobx/mobx.dart';
import 'package:taxiflutter/api/api-service.dart';
import 'package:taxiflutter/api/region-service.dart';
import 'package:taxiflutter/models/city.dart';

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
