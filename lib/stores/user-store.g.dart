// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user-store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UserStore on UserBase, Store {
  Computed<bool>? _$isAuthComputed;

  @override
  bool get isAuth => (_$isAuthComputed ??=
          Computed<bool>(() => super.isAuth, name: 'UserBase.isAuth'))
      .value;
  Computed<bool>? _$profileNotNullComputed;

  @override
  bool get profileNotNull =>
      (_$profileNotNullComputed ??= Computed<bool>(() => super.profileNotNull,
              name: 'UserBase.profileNotNull'))
          .value;
  Computed<bool>? _$userDocumentsNotNullComputed;

  @override
  bool get userDocumentsNotNull => (_$userDocumentsNotNullComputed ??=
          Computed<bool>(() => super.userDocumentsNotNull,
              name: 'UserBase.userDocumentsNotNull'))
      .value;

  late final _$profileAtom = Atom(name: 'UserBase.profile', context: context);

  @override
  Profile? get profile {
    _$profileAtom.reportRead();
    return super.profile;
  }

  @override
  set profile(Profile? value) {
    _$profileAtom.reportWrite(value, super.profile, () {
      super.profile = value;
    });
  }

  late final _$isLoadingRegisterAtom =
      Atom(name: 'UserBase.isLoadingRegister', context: context);

  @override
  bool get isLoadingRegister {
    _$isLoadingRegisterAtom.reportRead();
    return super.isLoadingRegister;
  }

  @override
  set isLoadingRegister(bool value) {
    _$isLoadingRegisterAtom.reportWrite(value, super.isLoadingRegister, () {
      super.isLoadingRegister = value;
    });
  }

  late final _$isLoadingVerifyAtom =
      Atom(name: 'UserBase.isLoadingVerify', context: context);

  @override
  bool get isLoadingVerify {
    _$isLoadingVerifyAtom.reportRead();
    return super.isLoadingVerify;
  }

  @override
  set isLoadingVerify(bool value) {
    _$isLoadingVerifyAtom.reportWrite(value, super.isLoadingVerify, () {
      super.isLoadingVerify = value;
    });
  }

  late final _$isCanRegisterAtom =
      Atom(name: 'UserBase.isCanRegister', context: context);

  @override
  bool get isCanRegister {
    _$isCanRegisterAtom.reportRead();
    return super.isCanRegister;
  }

  @override
  set isCanRegister(bool value) {
    _$isCanRegisterAtom.reportWrite(value, super.isCanRegister, () {
      super.isCanRegister = value;
    });
  }

  late final _$phoneAtom = Atom(name: 'UserBase.phone', context: context);

  @override
  String? get phone {
    _$phoneAtom.reportRead();
    return super.phone;
  }

  @override
  set phone(String? value) {
    _$phoneAtom.reportWrite(value, super.phone, () {
      super.phone = value;
    });
  }

  late final _$otpAtom = Atom(name: 'UserBase.otp', context: context);

  @override
  String? get otp {
    _$otpAtom.reportRead();
    return super.otp;
  }

  @override
  set otp(String? value) {
    _$otpAtom.reportWrite(value, super.otp, () {
      super.otp = value;
    });
  }

  late final _$errorAtom = Atom(name: 'UserBase.error', context: context);

  @override
  String? get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(String? value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  @override
  String toString() {
    return '''
profile: ${profile},
isLoadingRegister: ${isLoadingRegister},
isLoadingVerify: ${isLoadingVerify},
isCanRegister: ${isCanRegister},
phone: ${phone},
otp: ${otp},
error: ${error},
isAuth: ${isAuth},
profileNotNull: ${profileNotNull},
userDocumentsNotNull: ${userDocumentsNotNull}
    ''';
  }
}
