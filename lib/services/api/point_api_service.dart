import '../api/api_client.dart';
import '../../models/point/point_model.dart';

class PointApiService {
  final ApiClient _apiClient;

  PointApiService(this._apiClient);

  Future<int> getTotalPoints(String userId) async {
    final response = await _apiClient.get('/users/$userId/points/total');
    return response.data['totalPoints'] as int;
  }

  Future<List<PointModel>> getPointHistory(String userId) async {
    final response = await _apiClient.get('/users/$userId/points');
    return (response.data as List)
        .map((json) => PointModel.fromJson(json))
        .toList();
  }

  Future<PointModel> earnPoints({
    required String userId,
    required String cafeId,
    required int amount,
    String? description,
  }) async {
    final response = await _apiClient.post(
      '/points/earn',
      data: {
        'userId': userId,
        'cafeId': cafeId,
        'amount': amount,
        'description': description,
      },
    );
    return PointModel.fromJson(response.data);
  }

  Future<PointModel> usePoints({
    required String userId,
    required String cafeId,
    required int amount,
    String? description,
  }) async {
    final response = await _apiClient.post(
      '/points/use',
      data: {
        'userId': userId,
        'cafeId': cafeId,
        'amount': amount,
        'description': description,
      },
    );
    return PointModel.fromJson(response.data);
  }
}

