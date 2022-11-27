// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create-order-store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CreateOrderStore on CreateOrderBase, Store {
  Computed<bool>? _$isCreateComputed;

  @override
  bool get isCreate =>
      (_$isCreateComputed ??= Computed<bool>(() => super.isCreate,
              name: 'CreateOrderBase.isCreate'))
          .value;

  late final _$timeAtom = Atom(name: 'CreateOrderBase.time', context: context);

  @override
  String? get time {
    _$timeAtom.reportRead();
    return super.time;
  }

  @override
  set time(String? value) {
    _$timeAtom.reportWrite(value, super.time, () {
      super.time = value;
    });
  }

  late final _$dateAtom = Atom(name: 'CreateOrderBase.date', context: context);

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

  late final _$from_city_nameAtom =
      Atom(name: 'CreateOrderBase.from_city_name', context: context);

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

  late final _$to_city_nameAtom =
      Atom(name: 'CreateOrderBase.to_city_name', context: context);

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

  late final _$city_to_city_coinAtom =
      Atom(name: 'CreateOrderBase.city_to_city_coin', context: context);

  @override
  int? get city_to_city_coin {
    _$city_to_city_coinAtom.reportRead();
    return super.city_to_city_coin;
  }

  @override
  set city_to_city_coin(int? value) {
    _$city_to_city_coinAtom.reportWrite(value, super.city_to_city_coin, () {
      super.city_to_city_coin = value;
    });
  }

  late final _$city_to_city_priceAtom =
      Atom(name: 'CreateOrderBase.city_to_city_price', context: context);

  @override
  CityToCityPrice? get city_to_city_price {
    _$city_to_city_priceAtom.reportRead();
    return super.city_to_city_price;
  }

  @override
  set city_to_city_price(CityToCityPrice? value) {
    _$city_to_city_priceAtom.reportWrite(value, super.city_to_city_price, () {
      super.city_to_city_price = value;
    });
  }

  late final _$errorAtom =
      Atom(name: 'CreateOrderBase.error', context: context);

  @override
  dynamic get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(dynamic value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  late final _$isLoadingCreateAtom =
      Atom(name: 'CreateOrderBase.isLoadingCreate', context: context);

  @override
  bool get isLoadingCreate {
    _$isLoadingCreateAtom.reportRead();
    return super.isLoadingCreate;
  }

  @override
  set isLoadingCreate(bool value) {
    _$isLoadingCreateAtom.reportWrite(value, super.isLoadingCreate, () {
      super.isLoadingCreate = value;
    });
  }

  @override
  String toString() {
    return '''
time: ${time},
date: ${date},
from_city_id: ${from_city_id},
to_city_id: ${to_city_id},
from_city_name: ${from_city_name},
to_city_name: ${to_city_name},
price: ${price},
to_address: ${to_address},
from_address: ${from_address},
comment: ${comment},
city_to_city_coin: ${city_to_city_coin},
city_to_city_price: ${city_to_city_price},
error: ${error},
isLoadingCreate: ${isLoadingCreate},
isCreate: ${isCreate}
    ''';
  }
}
