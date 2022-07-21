import 'dart:async';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxiflutter/api/api-service.dart';
import 'package:taxiflutter/models/city.dart';
import 'package:taxiflutter/models/profile-model.dart';

class UserService extends ApiService {
  Future<int> register({required String phone}) async {
    try {
      var res =
          await api.post('/users/sign-in/', data: {'phone_number': phone});
      if (res.data['status'] == 'success') {
        return 200;
      } else {
        return 500;
      }
    } catch (e) {
      throw e;
    }
  }

  FutureOr<Profile?> getUser() async {
    try {
      var res = await authApi.get('/users/me/');
      print(res.data);
      return Profile.fromJson(res.data);
    } catch (e) {
      throw e;
    }
  }

  FutureOr<Profile?> updateProfileInfo(ProfileInfoCreate profileInfo) async {
    try {
      print(profileInfo.avatar);
      var formData = FormData.fromMap(
          {...profileInfo.toJson(), 'avatar': profileInfo.avatar});
      var res = await authApi.patch('/users/profile-info/', data: formData);
      return Profile.fromJson(res.data);
    } catch (e) {
      throw e;
    }
  }

  Future<Profile?> verifyUser(
      {required String phone, required String otp}) async {
    try {
      var res = await api.post('/users/verify-user/',
          data: {'phone_number': phone, 'otp': otp});
      SharedPreferences instance = await SharedPreferences.getInstance();
      instance.setString('token', res.data['access']);
      return Profile.fromJson(res.data['user']);
    } catch (e) {
      throw e;
    }
  }
}
