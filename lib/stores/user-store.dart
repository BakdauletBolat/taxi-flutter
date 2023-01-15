// ignore_for_file: nullable_type_in_catch_clause,file_names, non_constant_identifier_names

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxizakaz/api/user-service.dart';
import 'package:taxizakaz/models/message.dart';
import 'package:taxizakaz/models/profile-model.dart';

// Include generated file
part 'user-store.g.dart';

// This is the class used by rest of your codebase
class UserStore = UserBase with _$UserStore;

// The store-class
abstract class UserBase with Store {
  @observable
  User? user;

  @observable
  bool isLoadingCallToPhone = false;

  @computed
  bool get isAuth => user == null ? false : true;

  @computed
  bool get isSubsriptionDriver => DateTime.now().isBefore(DateTime.parse(
      user?.driver_can_view_order_date?.toString() ?? '2022-01-01'));

  @computed
  bool get userNotNull =>
      user?.user_info?.avatar != null &&
      user?.user_info?.first_name != null &&
      user?.user_info?.last_name != null;

  @computed
  bool get userDocumentsNotNull =>
      user?.user_document?.passport_photo_back != null &&
      user?.user_document?.passport_photo_front != null &&
      user?.user_document?.passport_photo_back != null &&
      user?.user_document?.car_passport_back != null;

  @observable
  bool isLoadingRegister = false;

  @observable
  bool isLoadingVerify = false;

  @observable
  bool isCanRegister = false;

  @observable
  bool isLoadingMessage = false;

  @observable
  bool isLoadingCreatePayment = false;

  @observable
  bool isLoadingPayments = false;

  @observable
  bool isLoadingUploadDocument = false;

  @observable
  String? phone;

  @observable
  String? otp;

  @observable
  String? error;

  @observable
  String? errorRegister;

  @observable
  String? errorVerify;

  @observable
  String? errorUpdateInfo;

  @observable
  List<Payment> userPayments = [];

  @observable
  List<Message> userMessages = [];

  UserService userService = UserService();

  Future loadUser({String? token}) async {
    try {
      SharedPreferences instance = await SharedPreferences.getInstance();
      if (instance.getString('token') != null) {
        User? user = await userService.getUser(token: token);
        runInAction(() {
          this.user = user;
        });
      }
    } finally {}
  }

  Future changeUserType() async {
    try {
      int change_user_type = 1;
      if (user!.type_user! == 1) {
        change_user_type = 2;
      } else if (user!.type_user == 2) {
        change_user_type = 1;
      }

      User? userData = await userService.changeUserType(
          change_user_type_id: change_user_type, user_id: user!.id!);

      if (userData != null) {
        runInAction(() => user = userData);
      }
    } finally {}
  }

  void setIsCallToPhone(bool value) {
    runInAction(() => isLoadingCallToPhone = value);
  }

  Future loadUserPayments() async {
    runInAction(() => {isLoadingPayments = true});

    final paymentsObject = await userService.getUserPayments();

    if (paymentsObject.item3) {
      runInAction(
          () => {error = paymentsObject.item2, isLoadingPayments = false});
    } else {
      runInAction(() => {
            userPayments = paymentsObject.item1!,
            error = null,
            isLoadingPayments = false
          });
    }
  }

  Future loadUserMessages() async {
    runInAction(() => {isLoadingMessage = true});
    try {
      List<Message> messages = await userService.getUserMessages();
      runInAction(() => userMessages = messages);
    } catch (e) {
      error = e.toString();
    } finally {
      runInAction(() => isLoadingMessage = false);
    }
  }

  FutureOr<Payment?> createPayment(int user_id, String coin) async {
    runInAction(() => {isLoadingCreatePayment = true});
    final paymentObject =
        await userService.createPayment(user_id, int.parse(coin));
    if (paymentObject.item3) {
      runInAction(() => {error = paymentObject.item2});
    } else {
      runInAction(() => {error = null, isLoadingCreatePayment = false});
      return paymentObject.item1!;
    }
    runInAction(() => {isLoadingCreatePayment = false});
    return null;
  }

  Future register() async {
    runInAction(() => isLoadingRegister = true);
    try {
      var statusCode = await userService.register(phone: phone);
      if (statusCode == 200) {
        runInAction(() => isCanRegister = true);
      }
    } catch (e) {
      runInAction(() => isLoadingRegister = false);
      rethrow;
    }

    runInAction(() => isLoadingRegister = false);
  }

  Future verifyUser() async {
    runInAction(() => isLoadingVerify = true);

    if (otp == null) {
      runInAction(() {
        isLoadingVerify = false;
      });
      return;
    }

    try {
      final userObject = await userService.verifyUser(phone: phone!, otp: otp!);
      runInAction(() => user = userObject);
    } catch (e) {
      runInAction(() => {isLoadingVerify = false});
      rethrow;
    }
  }

  Future requestUserDocument(UserDocumentsCreate userDocumentsCreate) async {
    runInAction(() => isLoadingUploadDocument = true);
    try {
      final userObject =
          await userService.requestUserDocument(userDocumentsCreate);
      runInAction(() {
        user = userObject;
        error = null;
      });
    } catch (e) {
      runInAction(() => {error = e.toString()});
    } finally {
      runInAction(() => isLoadingUploadDocument = false);
    }
  }

  Future updateUserInfo(UserInfoCreate userInfo) async {
    try {
      User? user = await userService.updateUserInfo(userInfo);
      runInAction(() {
        this.user = user;
        errorUpdateInfo = null;
      });
    } on DioError catch (e) {
      if (e.response != null) {
        runInAction(() {
          errorUpdateInfo = e.response!.data.toString();
        });
      } else {
        runInAction(() {
          errorUpdateInfo = e.message;
        });
      }
    } catch (e) {
      runInAction(() {
        errorUpdateInfo = e.toString();
      });
    }
  }

  void onChangePhone(String phone) {
    runInAction(() {
      this.phone = phone;
    });
  }

  void onChangeOtp(String otp) {
    runInAction(() {
      this.otp = otp;
    });
  }

  void logout() async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    instance.remove('token');
    runInAction(() => user = null);
  }
}
