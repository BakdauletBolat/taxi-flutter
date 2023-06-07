// ignore_for_file: file_names

import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxizakaz/api/api-service.dart';
import 'package:taxizakaz/models/message.dart';
import 'package:taxizakaz/models/profile-model.dart';
import 'package:tuple/tuple.dart';

class UserService extends ApiService {
  Future<int?> register({String? phone}) async {
    try {
      var res =
          await api.post('/users/sign-in/', data: {'phone_number': phone});
      print(res.headers);
      return res.statusCode;
    } on DioError catch (e) {
      print(e.response!.headers);
      rethrow;
    }
  }

  FutureOr<User?> getUser({String? token}) async {
    try {
      var res = await authApi.get(
        '/users/me/?token=$token',
      );
      return User.fromJson(res.data);
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  FutureOr<User?> changeUserType(
      {int? change_user_type_id, int? user_id}) async {
    try {
      var res = await authApi.post('/users/user-type-change/', data: {
        'change_user_type_id': change_user_type_id,
        'user_id': user_id
      });
      return User.fromJson(res.data);
    } catch (e) {
      dynamic error = e as dynamic;
      print(error.response.data);
      log(e.toString());
    }
    return null;
  }

  FutureOr<User?> updateUserInfo(UserInfoCreate profileInfo) async {
    try {
      var formData = FormData.fromMap(
          {...profileInfo.toJson(), 'avatar': profileInfo.avatar});
      var res = await authApi.patch('/users/profile-info/', data: formData);
      return User.fromJson(res.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<User?> requestUserDocument(UserDocumentsCreate userDocument) async {
    try {
      var formData = FormData.fromMap({
        'passport_photo_back':
            MultipartFile.fromFileSync(userDocument.passport_photo_back!),
        'passport_photo_front':
            MultipartFile.fromFileSync(userDocument.passport_photo_front!),
        'car_passport_front':
            MultipartFile.fromFileSync(userDocument.car_passport_front!),
        'car_passport_back':
            MultipartFile.fromFileSync(userDocument.car_passport_back!),
      });
      var res = await authApi.post('/users/request-driver/', data: formData);

      return User.fromJson(res.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<User?> verifyUser({required String phone, required String otp}) async {
    var res = await api
        .post('/users/verify-user/', data: {'phone_number': phone, 'otp': otp});
    SharedPreferences instance = await SharedPreferences.getInstance();
    instance.setString('token', res.data['access']);
    return User.fromJson(res.data['user']);
  }

  Future<Tuple3<List<Payment>?, String?, bool>> getUserPayments() async {
    try {
      var res = await authApi.get('/users/payment/');
      List<Payment> data =
          res.data!.map<Payment>((item) => Payment.fromJson(item)).toList();

      return Tuple3(data, null, false);
    } on DioError catch (e) {
      if (e.response != null) {
        return Tuple3(null, e.response!.data, true);
      } else {
        return Tuple3(null, e.message, true);
      }
    } catch (e) {
      return Tuple3(null, e.toString(), true);
    }
  }

  Future<List<Message>> getUserMessages() async {
    try {
      var res = await authApi.get('/users/messages/');

      List<Message> data = res.data['results']!
          .map<Message>((item) => Message.fromJson(item))
          .toList();

      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<Object> createPayment(
      int userId, int coin) async {
      var dataObj = {
        'user_id': userId,
        'coin': coin,
      };
      var res = await authApi.post('/users/payment/', data: dataObj);
      return res.data;
  }


 

  Future<String> updatePayment(String? gen_id) async {
    var res = await authApi.patch('/users/payment/$gen_id/');
    return res.data['link'];
  }

  Future<int?> deleteUser() async {
    var res = await authApi.delete('/users/me/');
    return res.statusCode;
  }

  Future<Payment?> getPayment(int paymentId) async {
    try {
var res = await authApi.get('/users/payment/$paymentId/');
return Payment.fromJson(res.data);
    } 
    on DioError catch (e) {
      print(e.response?.data);
    }
    
  }
}
