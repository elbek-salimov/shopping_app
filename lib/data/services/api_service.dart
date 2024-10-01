import 'package:dio/dio.dart';

import '../models/user_profile_model.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<String> login(String username, String password) async {
    try {
      final response = await _dio.post(
        'https://betaapi.theflyhigh.uz/api/Authentication/Login',
        data: {
          "userId": username,
          "password": password,
        },
      );

      if (response.statusCode == 200) {
        if (response.data is String) {
          return response.data;
        } else {
          throw Exception('Unexpected response format');
        }
      } else {
        throw Exception('Login failed: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Incorrect Login or Password');
    }
  }




  Future<UserProfileModel> getUserInfo(String token) async {
    try {
      final response = await _dio.get(
        'https://betaapi.theflyhigh.uz/api/Users/WhoAmI',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        return UserProfileModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load user info');
      }
    } catch (e) {
      throw Exception('Failed to load user info: $e');
    }
  }
}
