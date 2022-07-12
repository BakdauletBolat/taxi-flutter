// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user-store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UserStore on UserBase, Store {
  late final _$isAuthAtom = Atom(name: 'UserBase.isAuth', context: context);

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

  @override
  String toString() {
    return '''
isAuth: ${isAuth}
    ''';
  }
}
