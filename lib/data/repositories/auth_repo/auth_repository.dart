import 'package:shared_preferences/shared_preferences.dart';

import '../../services/api_service.dart';

class AuthRepository {
  final ApiService apiService;

  AuthRepository({required this.apiService});

  Future<String> login(String username, String password) async {
    final token = await apiService.login(username, password);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);

    return token;
  }

  Future<bool> isLoggedIn() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('token') != null;
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> logout() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('token');
  }
}
