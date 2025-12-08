import '../api/api_client.dart';
import '../../models/cafe/cafe_model.dart';

class CafeApiService {
  final ApiClient _apiClient;

  CafeApiService(this._apiClient);

  Future<List<CafeModel>> getCafes({
    double? latitude,
    double? longitude,
    double? radius,
  }) async {
    final queryParams = <String, dynamic>{};
    if (latitude != null) queryParams['latitude'] = latitude;
    if (longitude != null) queryParams['longitude'] = longitude;
    if (radius != null) queryParams['radius'] = radius;

    final response = await _apiClient.get('/cafes', queryParameters: queryParams);
    return (response.data as List)
        .map((json) => CafeModel.fromJson(json))
        .toList();
  }

  Future<CafeModel> getCafe(String cafeId) async {
    final response = await _apiClient.get('/cafes/$cafeId');
    return CafeModel.fromJson(response.data);
  }

  Future<CafeModel> createCafe(Map<String, dynamic> data) async {
    final response = await _apiClient.post('/cafes', data: data);
    return CafeModel.fromJson(response.data);
  }

  Future<CafeModel> updateCafe(String cafeId, Map<String, dynamic> data) async {
    final response = await _apiClient.put('/cafes/$cafeId', data: data);
    return CafeModel.fromJson(response.data);
  }
}

