// ignore_for_file: non_constant_identifier_names,file_names

import 'dart:developer';

import 'package:mobx/mobx.dart';
import 'package:taxizakaz/api/order-service.dart';
import 'package:taxizakaz/models/create-order.dart';

// Include generated file
part 'create-order-store.g.dart';

// This is the class used by rest of your codebase
class CreateOrderStore = CreateOrderBase with _$CreateOrderStore;

// The store-class
abstract class CreateOrderBase with Store {
  @observable
  String? time;

  @observable
  String? date;

  @observable
  int? from_city_id;

  @observable
  int? to_city_id;

  @observable
  String? from_city_name;

  @observable
  String? to_city_name;

  @observable
  int? price = 0;

  @observable
  String? to_address;

  @observable
  String? from_address;

  @observable
  String? comment;

  @observable
  dynamic? error;

  @computed
  bool get isCreate =>
      time != null &&
      date != null &&
      from_city_id != null &&
      to_city_id != null &&
      price != null;

  OrderService service = OrderService();

  void clear() {
    runInAction(() {
      to_city_id = null;
      to_address = null;
      from_city_id = null;
      from_address = null;
      comment = null;
      error = null;
      from_city_name = null;
      to_city_name = null;
      price = 0;
      date = null;
      time = null;
    });
  }

  Future create() async {
    if (isCreate) {
      var order = await service.createOrder(CreateOrder(
          from_city_id: from_city_id!,
          to_city_id: to_city_id!,
          from_address: from_address,
          to_address: to_address,
          price: price!,
          comment: comment,
          date_time: '$date $time'));

      if (order.item3) {
        error = order.item2;
      } else {
        error = null;
      }
    }
  }
}
