// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order-store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$OrderStore on OrderBase, Store {
  late final _$dateAtom = Atom(name: 'OrderBase.date', context: context);

  @override
  String? get date {
    _$dateAtom.reportRead();
    return super.date;
  }

  @override
  set date(String? value) {
    _$dateAtom.reportWrite(value, super.date, () {
      super.date = value;
    });
  }

  late final _$ordersAtom = Atom(name: 'OrderBase.orders', context: context);

  @override
  List<Order> get orders {
    _$ordersAtom.reportRead();
    return super.orders;
  }

  @override
  set orders(List<Order> value) {
    _$ordersAtom.reportWrite(value, super.orders, () {
      super.orders = value;
    });
  }

  late final _$isLoadingLastOrderAtom =
      Atom(name: 'OrderBase.isLoadingLastOrder', context: context);

  @override
  bool get isLoadingLastOrder {
    _$isLoadingLastOrderAtom.reportRead();
    return super.isLoadingLastOrder;
  }

  @override
  set isLoadingLastOrder(bool value) {
    _$isLoadingLastOrderAtom.reportWrite(value, super.isLoadingLastOrder, () {
      super.isLoadingLastOrder = value;
    });
  }

  late final _$isLoadingOrdersAtom =
      Atom(name: 'OrderBase.isLoadingOrders', context: context);

  @override
  bool get isLoadingOrders {
    _$isLoadingOrdersAtom.reportRead();
    return super.isLoadingOrders;
  }

  @override
  set isLoadingOrders(bool value) {
    _$isLoadingOrdersAtom.reportWrite(value, super.isLoadingOrders, () {
      super.isLoadingOrders = value;
    });
  }

  late final _$from_city_idAtom =
      Atom(name: 'OrderBase.from_city_id', context: context);

  @override
  int? get from_city_id {
    _$from_city_idAtom.reportRead();
    return super.from_city_id;
  }

  @override
  set from_city_id(int? value) {
    _$from_city_idAtom.reportWrite(value, super.from_city_id, () {
      super.from_city_id = value;
    });
  }

  late final _$from_city_nameAtom =
      Atom(name: 'OrderBase.from_city_name', context: context);

  @override
  String? get from_city_name {
    _$from_city_nameAtom.reportRead();
    return super.from_city_name;
  }

  @override
  set from_city_name(String? value) {
    _$from_city_nameAtom.reportWrite(value, super.from_city_name, () {
      super.from_city_name = value;
    });
  }

  late final _$to_city_idAtom =
      Atom(name: 'OrderBase.to_city_id', context: context);

  @override
  int? get to_city_id {
    _$to_city_idAtom.reportRead();
    return super.to_city_id;
  }

  @override
  set to_city_id(int? value) {
    _$to_city_idAtom.reportWrite(value, super.to_city_id, () {
      super.to_city_id = value;
    });
  }

  late final _$to_city_nameAtom =
      Atom(name: 'OrderBase.to_city_name', context: context);

  @override
  String? get to_city_name {
    _$to_city_nameAtom.reportRead();
    return super.to_city_name;
  }

  @override
  set to_city_name(String? value) {
    _$to_city_nameAtom.reportWrite(value, super.to_city_name, () {
      super.to_city_name = value;
    });
  }

  late final _$orderAtom = Atom(name: 'OrderBase.order', context: context);

  @override
  Order? get order {
    _$orderAtom.reportRead();
    return super.order;
  }

  @override
  set order(Order? value) {
    _$orderAtom.reportWrite(value, super.order, () {
      super.order = value;
    });
  }

  @override
  String toString() {
    return '''
date: ${date},
orders: ${orders},
isLoadingLastOrder: ${isLoadingLastOrder},
isLoadingOrders: ${isLoadingOrders},
from_city_id: ${from_city_id},
from_city_name: ${from_city_name},
to_city_id: ${to_city_id},
to_city_name: ${to_city_name},
order: ${order}
    ''';
  }
}
