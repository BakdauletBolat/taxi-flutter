import 'package:mobx/mobx.dart';
import 'package:taxiflutter/api/api-service.dart';
import 'package:taxiflutter/api/create-order-service.dart';
import 'package:taxiflutter/api/region-service.dart';
import 'package:taxiflutter/models/city.dart';

// Include generated file
part 'create-order-store.g.dart';

// This is the class used by rest of your codebase
class CreateOrderStore = CreateOrderBase with _$CreateOrderStore;

// The store-class
abstract class CreateOrderBase with Store {
  @observable
  bool isAuth = true;

  List<City> cities = [];

  @observable
  int? from_city_id;

  @observable
  int? to_city_id;

  @observable
  int? price;

  @observable
  String? to_address;

  @observable
  String? from_address;

  @observable
  String? comment;

  @observable
  DateTime? date_time;

  CreateOrderService service = CreateOrderService();

  void create() async {
    // List<City> citiesData = await service.create();
    // runInAction(() => {cities = citiesData});
  }
}
