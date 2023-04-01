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
  Computed<bool>? _$isSubsriptionDriverComputed;

  @override
  bool get isSubsriptionDriver => (_$isSubsriptionDriverComputed ??=
          Computed<bool>(() => super.isSubsriptionDriver,
              name: 'UserBase.isSubsriptionDriver'))
      .value;
  Computed<bool>? _$userNotNullComputed;

  @override
  bool get userNotNull => (_$userNotNullComputed ??=
          Computed<bool>(() => super.userNotNull, name: 'UserBase.userNotNull'))
      .value;
  Computed<bool>? _$userDocumentsNotNullComputed;

  @override
  bool get userDocumentsNotNull => (_$userDocumentsNotNullComputed ??=
          Computed<bool>(() => super.userDocumentsNotNull,
              name: 'UserBase.userDocumentsNotNull'))
      .value;

  late final _$userAtom = Atom(name: 'UserBase.user', context: context);

  @override
  User? get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(User? value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  late final _$isLoadingUserAtom =
      Atom(name: 'UserBase.isLoadingUser', context: context);

  @override
  bool get isLoadingUser {
    _$isLoadingUserAtom.reportRead();
    return super.isLoadingUser;
  }

  @override
  set isLoadingUser(bool value) {
    _$isLoadingUserAtom.reportWrite(value, super.isLoadingUser, () {
      super.isLoadingUser = value;
    });
  }

  late final _$isLoadingCallToPhoneAtom =
      Atom(name: 'UserBase.isLoadingCallToPhone', context: context);

  @override
  bool get isLoadingCallToPhone {
    _$isLoadingCallToPhoneAtom.reportRead();
    return super.isLoadingCallToPhone;
  }

  @override
  set isLoadingCallToPhone(bool value) {
    _$isLoadingCallToPhoneAtom.reportWrite(value, super.isLoadingCallToPhone,
        () {
      super.isLoadingCallToPhone = value;
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

  late final _$isLoadingMessageAtom =
      Atom(name: 'UserBase.isLoadingMessage', context: context);

  @override
  bool get isLoadingMessage {
    _$isLoadingMessageAtom.reportRead();
    return super.isLoadingMessage;
  }

  @override
  set isLoadingMessage(bool value) {
    _$isLoadingMessageAtom.reportWrite(value, super.isLoadingMessage, () {
      super.isLoadingMessage = value;
    });
  }

  late final _$isLoadingCreatePaymentAtom =
      Atom(name: 'UserBase.isLoadingCreatePayment', context: context);

  @override
  bool get isLoadingCreatePayment {
    _$isLoadingCreatePaymentAtom.reportRead();
    return super.isLoadingCreatePayment;
  }

  @override
  set isLoadingCreatePayment(bool value) {
    _$isLoadingCreatePaymentAtom
        .reportWrite(value, super.isLoadingCreatePayment, () {
      super.isLoadingCreatePayment = value;
    });
  }

  late final _$isLoadingPaymentsAtom =
      Atom(name: 'UserBase.isLoadingPayments', context: context);

  @override
  bool get isLoadingPayments {
    _$isLoadingPaymentsAtom.reportRead();
    return super.isLoadingPayments;
  }

  @override
  set isLoadingPayments(bool value) {
    _$isLoadingPaymentsAtom.reportWrite(value, super.isLoadingPayments, () {
      super.isLoadingPayments = value;
    });
  }

  late final _$isLoadingUploadDocumentAtom =
      Atom(name: 'UserBase.isLoadingUploadDocument', context: context);

  @override
  bool get isLoadingUploadDocument {
    _$isLoadingUploadDocumentAtom.reportRead();
    return super.isLoadingUploadDocument;
  }

  @override
  set isLoadingUploadDocument(bool value) {
    _$isLoadingUploadDocumentAtom
        .reportWrite(value, super.isLoadingUploadDocument, () {
      super.isLoadingUploadDocument = value;
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

  late final _$errorRegisterAtom =
      Atom(name: 'UserBase.errorRegister', context: context);

  @override
  String? get errorRegister {
    _$errorRegisterAtom.reportRead();
    return super.errorRegister;
  }

  @override
  set errorRegister(String? value) {
    _$errorRegisterAtom.reportWrite(value, super.errorRegister, () {
      super.errorRegister = value;
    });
  }

  late final _$errorVerifyAtom =
      Atom(name: 'UserBase.errorVerify', context: context);

  @override
  String? get errorVerify {
    _$errorVerifyAtom.reportRead();
    return super.errorVerify;
  }

  @override
  set errorVerify(String? value) {
    _$errorVerifyAtom.reportWrite(value, super.errorVerify, () {
      super.errorVerify = value;
    });
  }

  late final _$errorUpdateInfoAtom =
      Atom(name: 'UserBase.errorUpdateInfo', context: context);

  @override
  String? get errorUpdateInfo {
    _$errorUpdateInfoAtom.reportRead();
    return super.errorUpdateInfo;
  }

  @override
  set errorUpdateInfo(String? value) {
    _$errorUpdateInfoAtom.reportWrite(value, super.errorUpdateInfo, () {
      super.errorUpdateInfo = value;
    });
  }

  late final _$userPaymentsAtom =
      Atom(name: 'UserBase.userPayments', context: context);

  @override
  List<Payment> get userPayments {
    _$userPaymentsAtom.reportRead();
    return super.userPayments;
  }

  @override
  set userPayments(List<Payment> value) {
    _$userPaymentsAtom.reportWrite(value, super.userPayments, () {
      super.userPayments = value;
    });
  }

  late final _$userMessagesAtom =
      Atom(name: 'UserBase.userMessages', context: context);

  @override
  List<Message> get userMessages {
    _$userMessagesAtom.reportRead();
    return super.userMessages;
  }

  @override
  set userMessages(List<Message> value) {
    _$userMessagesAtom.reportWrite(value, super.userMessages, () {
      super.userMessages = value;
    });
  }

  @override
  String toString() {
    return '''
user: ${user},
isLoadingUser: ${isLoadingUser},
isLoadingCallToPhone: ${isLoadingCallToPhone},
isLoadingRegister: ${isLoadingRegister},
isLoadingVerify: ${isLoadingVerify},
isCanRegister: ${isCanRegister},
isLoadingMessage: ${isLoadingMessage},
isLoadingCreatePayment: ${isLoadingCreatePayment},
isLoadingPayments: ${isLoadingPayments},
isLoadingUploadDocument: ${isLoadingUploadDocument},
phone: ${phone},
otp: ${otp},
error: ${error},
errorRegister: ${errorRegister},
errorVerify: ${errorVerify},
errorUpdateInfo: ${errorUpdateInfo},
userPayments: ${userPayments},
userMessages: ${userMessages},
isAuth: ${isAuth},
isSubsriptionDriver: ${isSubsriptionDriver},
userNotNull: ${userNotNull},
userDocumentsNotNull: ${userDocumentsNotNull}
    ''';
  }
}
