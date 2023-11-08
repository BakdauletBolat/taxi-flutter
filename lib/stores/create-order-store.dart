// ignore_for_file: non_constant_identifier_names,file_names

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:taxizakaz/api/order-service.dart';
import 'package:taxizakaz/models/city.dart';
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
  int? price;

  @observable
  String? to_address;

  @observable
  String? from_address;

  @observable
  String? comment;

  @observable
  int? city_to_city_coin;

  @observable
  CityToCityPrice? city_to_city_price;

  @observable
  DioException? error;

  @observable
  bool isLoadingCreate = false;

  @computed
  bool get isCreate =>
      time != null &&
      date != null &&
      from_city_id != null &&
      to_city_id != null &&
      price != null;

  int? access_id;

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
      city_to_city_coin = 0;
    });
  }

  Future setCityToCityPrice() async {
    try {
      CityToCityPrice? city_to_city_price_value =
          await service.getCityToCityPrice(
              to_city_id: to_city_id!, from_city_id: from_city_id!);

      runInAction(() {
        city_to_city_coin = city_to_city_price_value!.coin;
        city_to_city_price = city_to_city_price_value;
        access_id = city_to_city_price_value.id;
      });
    } on DioException catch (e) {
      log(e.response.toString());
      runInAction(() => city_to_city_coin = null);
    }
  }

  Future create() async {
    if (isCreate) {
      try {
        runInAction(() {
          isLoadingCreate = true;
          error = null;
        });

        return await service.createOrder(CreateOrder(
            from_city_id: from_city_id!,
            to_city_id: to_city_id!,
            from_address: from_address,
            to_address: to_address,
            price: price!,
            comment: comment,
            date_time: '$date $time'));
      } on DioException catch (e) {
        runInAction(() => error = e);
      } finally {
        runInAction(() => isLoadingCreate = false);
      }
    }
  }
}
