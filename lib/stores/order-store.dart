// ignore_for_file: non_constant_identifier_names,file_names

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:taxizakaz/api/order-service.dart';
import 'package:taxizakaz/models/order.dart';

// Include generated file
part 'order-store.g.dart';

// This is the class used by rest of your codebase
class OrderStore = OrderBase with _$OrderStore;

// The store-class
abstract class OrderBase with Store {
  final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  @observable
  String? date;

  OrderBase() {
    date = formatter.format(now);
  }

  @observable
  List<Order> orders = [];

  @observable
  bool isLoadingLastOrder = false;

  @observable
  bool isLoadingOrders = false;

  @observable
  int? from_city_id;

  @observable
  String? from_city_name;

  @observable
  int? to_city_id;

  @observable
  List<Order> user_orders = [];

  @observable
  String? to_city_name;

  @observable
  Order? order;

  OrderService service = OrderService();

  Future cancelOrder() async {
    try {
      bool result = await service.cancelOrder(order!.id);
      runInAction(() => order = null);
    } on DioError catch (e) {
      log(e.response!.data.toString());
    } catch (e) {
      rethrow;
    }
  }

  Future loadLastOrder() async {
    runInAction(() => isLoadingLastOrder = true);
    try {
      Order? data = await service.getLastOrder();
      runInAction(() => order = data);
    } catch (e) {
      runInAction(() => order = null);
    } finally {
      runInAction(() => isLoadingLastOrder = false);
    }
  }

  void loadOrders({int? type_order}) async {
    runInAction(() => isLoadingOrders = true);
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

    runInAction(() => isLoadingOrders = false);
  }

  void loadUserOrders() async {
    runInAction(() => isLoadingOrders = true);
    var data = await service.getUserOrders();
    print(data);
    if (data != null) {
      runInAction(() => {user_orders = data});
    }
  }
}
