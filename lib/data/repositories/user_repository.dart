import 'dart:convert';

import 'package:assignment12_front_end/core/api.dart';
import 'package:assignment12_front_end/data/models/user/user_model.dart';
import 'package:assignment12_front_end/logic/services/token_manager.dart';
import 'package:dio/dio.dart';

class UserRepository {
  final _api = Api();
  Future<UserModel> signup({
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      Response response = await _api.sendRequest.post('/users/signup',
          data: jsonEncode({
            'email': email,
            'password': password,
            'fullName': fullName,
          }));

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      //convert raw data to model
      return UserModel.fromJson(apiResponse.data);
    } catch (error) {
      rethrow;
    }
  }

  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      Response response = await _api.sendRequest.post('/users/signIn',
          data: jsonEncode({
            'email': email,
            'password': password,
          }));

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      TokenManager.saveToken(apiResponse.data['token']);

      //convert raw data to model
      return UserModel.fromJson(apiResponse.data);
    } catch (error) {
      rethrow;
    }
  }

  Future<UserModel> updateUser(UserModel userModel) async {
    try {
      Response response = await _api.sendRequest
          .put('/users', data: jsonEncode(userModel.toJson()));

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      //convert raw data to model
      return UserModel.fromJson(apiResponse.data);
    } catch (error) {
      rethrow;
    }
  }

  Future<UserModel> getUserById(String userId) async {
    try {
      Response response = await _api.sendRequest.get('/users/$userId');

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      //convert raw data to model
      return UserModel.fromJson(apiResponse.data);
    } catch (error) {
      rethrow;
    }
  }

  Future<List<UserModel>> fetchAllUsers() async {
    try {
      Response response = await _api.sendRequest.get('/users');

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }
      return (apiResponse.data as List<dynamic>)
          .map((json) => UserModel.fromJson(json))
          .toList();
    } catch (error) {
      rethrow;
    }
  }
}
