import 'package:shopping_app/data/models/user_profile_model.dart';
import 'package:shopping_app/data/services/api_service.dart';

class UserRepository {
  final ApiService apiService;

  UserRepository({required this.apiService});

  Future<UserProfileModel> getUserInfo(String token) async {
    return await apiService.getUserInfo(token);
  }
}
