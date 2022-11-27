// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'region-store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RegionStore on RegionBase, Store {
  Computed<List<City>>? _$searched_citiesComputed;

  @override
  List<City> get searched_cities => (_$searched_citiesComputed ??=
          Computed<List<City>>(() => super.searched_cities,
              name: 'RegionBase.searched_cities'))
      .value;

  late final _$isAuthAtom = Atom(name: 'RegionBase.isAuth', context: context);

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

  late final _$input_cityAtom =
      Atom(name: 'RegionBase.input_city', context: context);

  @override
  String? get input_city {
    _$input_cityAtom.reportRead();
    return super.input_city;
  }

  @override
  set input_city(String? value) {
    _$input_cityAtom.reportWrite(value, super.input_city, () {
      super.input_city = value;
    });
  }

  @override
  String toString() {
    return '''
isAuth: ${isAuth},
input_city: ${input_city},
searched_cities: ${searched_cities}
    ''';
  }
}
