// ignore_for_file: file_names, non_constant_identifier_names

import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:taxizakaz/api/api-service.dart';
import 'package:taxizakaz/models/create-order.dart';
import 'package:taxizakaz/models/order.dart';
import 'package:tuple/tuple.dart';

class OrderService extends ApiService {
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

      log(url);
      var res = await authApi.get(url);
      List<Order> orderList =
          res.data.map<Order>((json) => Order.fromJson(json)).toList();
      return Tuple3.fromList([orderList, null, false]);
    } on DioError catch (e) {
      return Tuple3.fromList([null, e.message, true]);
    }
  }

  Future<Tuple3<Order?, dynamic?, bool>> createOrder(
      CreateOrder createOrder) async {
    try {
      var res = await authApi.post('/order/order-create/',
          data: createOrder.toJson());

      if (res.statusCode == 200) {
        return Tuple3.fromList([Order.fromJson(res.data), null, false]);
      } else {
        return Tuple3.fromList([null, res.data, false]);
      }
    } on DioError catch (e) {
      print(e);
      return Tuple3.fromList([null, e.response!.data, true]);
    } catch (e) {
      print(e);
      return Tuple3.fromList([null, e.toString(), true]);
    }
  }
}
