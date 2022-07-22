import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:taxiflutter/api/user-service.dart';
import 'package:taxiflutter/models/profile-model.dart';

// Include generated file
part 'user-store.g.dart';

// This is the class used by rest of your codebase
class UserStore = UserBase with _$UserStore;

// The store-class
abstract class UserBase with Store {
  @observable
  Profile? profile;

  @computed
  bool get isAuth => profile == null ? false : true;

  @computed
  bool get profileNotNull =>
      profile?.profile_info?.avatar != null &&
      profile?.profile_info?.first_name != null &&
      profile?.profile_info?.last_name != null;

  @computed
  bool get userDocumentsNotNull =>
      profile?.user_document?.passport_photo_back != null &&
      profile?.user_document?.passport_photo_front != null &&
      profile?.user_document?.car_passport != null;

  @observable
  bool isLoadingRegister = false;

  @observable
  bool isLoadingVerify = false;

  @observable
  bool isCanRegister = false;

  @observable
  String? phone;

  @observable
  String? otp;

  @observable
  String? error;

  UserService userService = UserService();

  Future loadUser() async {
    try {
      Profile? profile = await userService.getUser();
      runInAction(() {
        this.profile = profile;
      });
    } on dynamic catch (e) {
      print(e);
    }
  }

  Future register() async {
    runInAction(() {
      isLoadingRegister = true;
    });
    try {
      await Future.delayed(const Duration(seconds: 3));
      int res = await userService.register(phone: phone!);
      if (res == 200) {
        runInAction(() {
          isCanRegister = true;
        });
      }
    } on DioError catch (e) {
      print(e);
    } finally {
      runInAction(() {
        isLoadingRegister = false;
      });
    }
  }

  Future verifyUser() async {
    runInAction(() {
      isLoadingVerify = true;
    });

    final profileObject =
        await userService.verifyUser(phone: phone!, otp: otp!);

    if (profileObject.item3) {
      runInAction(() {
        error = profileObject.item2;
      });
    } else {
      runInAction(() {
        profile = profileObject.item1;
        error = null;
      });
    }

    runInAction(() {
      isLoadingVerify = false;
    });
  }

  Future requestUserDocument(UserDocumentsCreate userDocumentsCreate) async {
    final profileObject =
        await userService.requestUserDocument(userDocumentsCreate);

    if (profileObject.item3) {
      runInAction(() {
        error = profileObject.item2;
      });
    } else {
      runInAction(() {
        profile = profileObject.item1;
        error = null;
      });
    }
  }

  Future updateUserInfo(ProfileInfoCreate profileInfo) async {
    try {
      Profile? profile = await userService.updateProfileInfo(profileInfo);
      runInAction(() {
        this.profile = profile;
      });
    } on DioError catch (e) {
      print(e.response!.data);
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
}
