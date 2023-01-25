// ignore_for_file: file_names, non_constant_identifier_names

import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:taxizakaz/api/api-service.dart';
import 'package:taxizakaz/models/city.dart';
import 'package:taxizakaz/models/create-order.dart';
import 'package:taxizakaz/models/order.dart';
import 'package:tuple/tuple.dart';

class OrderService extends ApiService {
  Future<Order?> getLastOrder() async {
    try {
      var res = await authApi.get('/order/get-last-order/');
      return Order.fromJson(res.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Order>?> getUserOrders() async {
    try {
      var res = await authApi.get('/order/user/');
      List<Order> orderList = res.data['results']
          .map<Order>((json) => Order.fromJson(json))
          .toList();
      return orderList;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> cancelOrder(int id) async {
    try {
      var res = await authApi.get('/order/cancel/${id}/');
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<Tuple3<List<Order>?, String?, bool>> getOrders(
      {int type_order = 1,
      String? date_time,
      int? from_city_id,
      int? to_city_id}) async {
    try {
      String url = '/order/?';

      url += 'type_order=$type_order&';

      if (date_time != null) {
        url += 'date_time=$date_time&';
      }

      if (from_city_id != null) {
        url += 'from_city_id=$from_city_id&';
      }

      if (to_city_id != null) {
        url += 'to_city_id=$to_city_id&';
      }

      var res = await authApi.get(url);
      List<Order> orderList = res.data['results']
          .map<Order>((json) => Order.fromJson(json))
          .toList();
      return Tuple3.fromList([orderList, null, false]);
    } on DioError catch (e) {
      print(e.response!.data);
      return Tuple3.fromList([null, e.message, true]);
    }
  }

  Future<Order?> createOrder(CreateOrder createOrder) async {
    try {
      var res =
          await authApi.post('/order/create/', data: createOrder.toJson());
      return Order.fromJson(res.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<CityToCityPrice?> getCityToCityPrice(
      {required int from_city_id, required int to_city_id}) async {
    try {
      var res = await authApi.post('/order/access/',
          data: {'from_city_id': from_city_id, 'to_city_id': to_city_id});
      return CityToCityPrice.fromJson(res.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> getStatusToPhone(
      {required int from_city_id, required int to_city_id}) async {
    try {
      var res = await authApi.post('/order/get-status-to-call-phone/',
          data: {'from_city_id': from_city_id, 'to_city_id': to_city_id});

      if (res.data['status'] == true) {
        return true;
      }
    } on DioError catch (e) {
      log(e.toString());
    } catch (e) {
      return false;
    }

    return false;
  }
}
