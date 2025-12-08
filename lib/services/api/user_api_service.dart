import '../api/api_client.dart';
import '../../models/user/user_model.dart';

class UserApiService {
  final ApiClient _apiClient;

  UserApiService(this._apiClient);

  Future<UserModel> getUser(String userId) async {
    final response = await _apiClient.get('/users/$userId');
    return UserModel.fromJson(response.data);
  }

  Future<UserModel> updateUser(String userId, Map<String, dynamic> data) async {
    final response = await _apiClient.put('/users/$userId', data: data);
    return UserModel.fromJson(response.data);
  }
}

