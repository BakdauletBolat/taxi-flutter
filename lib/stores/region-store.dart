// ignore_for_file: file_names

import 'package:mobx/mobx.dart';
import 'package:taxizakaz/api/region-service.dart';
import 'package:taxizakaz/hooks/showSnackBar.dart';
import 'package:taxizakaz/models/city.dart';

// Include generated file
part 'region-store.g.dart';

// This is the class used by rest of your codebase
class RegionStore = RegionBase with _$RegionStore;

// The store-class
abstract class RegionBase with Store {
  @observable
  bool isAuth = true;

  @observable
  String? input_city;

  ObservableList<City> cities = ObservableList.of([]);

  @computed
  List<City> get searched_cities {
    if (input_city == null || input_city!.isEmpty) {
      return cities;
    }
    return cities
        .where((element) =>
            element.name.toLowerCase().startsWith(input_city!.toLowerCase()))
        .toList();
  }

  RegionService service = RegionService();

  void loadCities(context, {String? name}) async {
    try {
      List<City> citiesData = await service.getCities(name: name);
      runInAction(() => {cities = ObservableList.of(citiesData)});
    } catch (e) {
      showSnackBar(context, 'Ошибка при загрузке города');
    }
  }
}
