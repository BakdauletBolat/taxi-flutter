// ignore_for_file: file_names

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxizakaz/api/api-service.dart';
import 'package:taxizakaz/models/profile-model.dart';
import 'package:tuple/tuple.dart';

class UserService extends ApiService {
  Future<int?> register({String? phone}) async {
    try {
      var res =
          await api.post('/users/sign-in/', data: {'phone_number': phone});
      return res.statusCode;
    } catch (e) {
      rethrow;
    }
  }

  FutureOr<Profile?> getUser({String? token}) async {
    try {
      var res = await authApi.get(
        '/users/me/?token=$token',
      );
      return Profile.fromJson(res.data);
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  FutureOr<Profile?> updateProfileInfo(ProfileInfoCreate profileInfo) async {
    try {
      var formData = FormData.fromMap(
          {...profileInfo.toJson(), 'avatar': profileInfo.avatar});
      var res = await authApi.patch('/users/profile-info/', data: formData);
      return Profile.fromJson(res.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<Profile?> requestUserDocument(UserDocumentsCreate userDocument) async {
    try {
      var formData = FormData.fromMap({
        'passport_photo_back':
            MultipartFile.fromFileSync(userDocument.passport_photo_back!),
        'passport_photo_front':
            MultipartFile.fromFileSync(userDocument.passport_photo_front!),
        'car_passport': MultipartFile.fromFileSync(userDocument.car_passport!),
      });
      var res = await authApi.post('/users/request-driver/', data: formData);

      return Profile.fromJson(res.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<Profile?> verifyUser(
      {required String phone, required String otp}) async {
    var res = await api
        .post('/users/verify-user/', data: {'phone_number': phone, 'otp': otp});
    SharedPreferences instance = await SharedPreferences.getInstance();
    instance.setString('token', res.data['access']);
    return Profile.fromJson(res.data['user']);
  }

  Future<Tuple3<List<Payment>?, String?, bool>> getUserPayments() async {
    try {
      var res = await authApi.get('/users/payments/');
      List<Payment> data =
          res.data!.map<Payment>((item) => Payment.fromJson(item)).toList();

      return Tuple3(data, null, false);
    } on DioError catch (e) {
      if (e.response != null) {
        return Tuple3(null, e.response!.data['details'], true);
      } else {
        return Tuple3(null, e.message, true);
      }
    } catch (e) {
      return Tuple3(null, e.toString(), true);
    }
  }

  Future<Tuple3<Payment?, String?, bool>> createPayment(
      int userId, int coin) async {
    try {
      var dataObj = {
        'user_id': userId,
        'coin': coin,
      };

      var res = await authApi.post('/users/payment/', data: dataObj);
      Payment data = Payment.fromJson(res.data);
      return Tuple3(data, null, false);
    } on DioError catch (e) {
      return Tuple3(null, e.response.toString(), true);
    } catch (e) {
      return Tuple3(null, e.toString(), true);
    }
  }
}
