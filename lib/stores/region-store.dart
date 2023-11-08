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


  ObservableList<Region> regions = ObservableList.of([]);



  RegionService service = RegionService();

  void loadRegions(context, {String? name}) async {
    try {
      List<Region> regionsData = await service.getRegions(name: name);
      runInAction(() => {regions = ObservableList.of(regionsData)});
    } catch (e) {
      showSnackBar(context, 'Ошибка при загрузке города');
    }
  }

  
}
