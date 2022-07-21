// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create-order-store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CreateOrderStore on CreateOrderBase, Store {
  late final _$isAuthAtom =
      Atom(name: 'CreateOrderBase.isAuth', context: context);

  @override
  bool get isAuth {
    _$isAuthAtom.reportRead();
    return super.isAuth;
  }

  @override
  set isAuth(bool value) {
    _$isAuthAtom.reportWrite(value, super.isAuth, () {
      super.isAuth = value;
    });
  }

  late final _$from_city_idAtom =
      Atom(name: 'CreateOrderBase.from_city_id', context: context);

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

  late final _$to_city_idAtom =
      Atom(name: 'CreateOrderBase.to_city_id', context: context);

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

  late final _$priceAtom =
      Atom(name: 'CreateOrderBase.price', context: context);

  @override
  int? get price {
    _$priceAtom.reportRead();
    return super.price;
  }

  @override
  set price(int? value) {
    _$priceAtom.reportWrite(value, super.price, () {
      super.price = value;
    });
  }

  late final _$to_addressAtom =
      Atom(name: 'CreateOrderBase.to_address', context: context);

  @override
  String? get to_address {
    _$to_addressAtom.reportRead();
    return super.to_address;
  }

  @override
  set to_address(String? value) {
    _$to_addressAtom.reportWrite(value, super.to_address, () {
      super.to_address = value;
    });
  }

  late final _$from_addressAtom =
      Atom(name: 'CreateOrderBase.from_address', context: context);

  @override
  String? get from_address {
    _$from_addressAtom.reportRead();
    return super.from_address;
  }

  @override
  set from_address(String? value) {
    _$from_addressAtom.reportWrite(value, super.from_address, () {
      super.from_address = value;
    });
  }

  late final _$commentAtom =
      Atom(name: 'CreateOrderBase.comment', context: context);

  @override
  String? get comment {
    _$commentAtom.reportRead();
    return super.comment;
  }

  @override
  set comment(String? value) {
    _$commentAtom.reportWrite(value, super.comment, () {
      super.comment = value;
    });
  }

  late final _$date_timeAtom =
      Atom(name: 'CreateOrderBase.date_time', context: context);

  @override
  DateTime? get date_time {
    _$date_timeAtom.reportRead();
    return super.date_time;
  }

  @override
  set date_time(DateTime? value) {
    _$date_timeAtom.reportWrite(value, super.date_time, () {
      super.date_time = value;
    });
  }

  @override
  String toString() {
    return '''
isAuth: ${isAuth},
from_city_id: ${from_city_id},
to_city_id: ${to_city_id},
price: ${price},
to_address: ${to_address},
from_address: ${from_address},
comment: ${comment},
date_time: ${date_time}
    ''';
  }
}
