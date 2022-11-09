// ignore_for_file: non_constant_identifier_names,file_names

import 'dart:developer';

import 'package:mobx/mobx.dart';
import 'package:taxizakaz/api/order-service.dart';
import 'package:taxizakaz/models/order.dart';

// Include generated file
part 'order-store.g.dart';

// This is the class used by rest of your codebase
class OrderStore = OrderBase with _$OrderStore;

// The store-class
abstract class OrderBase with Store {
  @observable
  List<Order> orders = [];

  @observable
  String? date;

  @observable
  int? from_city_id;

  @observable
  String? from_city_name;

  @observable
  int? to_city_id;

  @observable
  String? to_city_name;

  OrderService service = OrderService();

  void loadOrders({int? type_order}) async {
    var data = await service.getOrders(
        type_order: type_order ?? 1,
        from_city_id: from_city_id,
        to_city_id: to_city_id,
        date_time: date);

    if (data.item3) {
      log(data.item2!);
    } else {
      runInAction(() => {orders = data.item1!});
    }
  }
}
