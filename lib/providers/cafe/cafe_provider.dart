import 'package:flutter/foundation.dart';
import '../../models/cafe/cafe_model.dart';
import '../../services/api/api_client.dart';
import '../../services/api/cafe_api_service.dart';
import '../../constants/api_constants.dart';

class CafeProvider with ChangeNotifier {
  final CafeApiService _cafeApiService;
  List<CafeModel> _cafes = [];
  CafeModel? _selectedCafe;
  bool _isLoading = false;

  CafeProvider()
      : _cafeApiService = CafeApiService(
          ApiClient(baseUrl: ApiConstants.baseUrl),
        );

  List<CafeModel> get cafes => _cafes;
  CafeModel? get selectedCafe => _selectedCafe;
  bool get isLoading => _isLoading;

  Future<void> loadCafes({
    double? latitude,
    double? longitude,
    double? radius,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      _cafes = await _cafeApiService.getCafes(
        latitude: latitude,
        longitude: longitude,
        radius: radius,
      );
    } catch (e) {
      // TODO: 에러 처리
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadCafe(String cafeId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _selectedCafe = await _cafeApiService.getCafe(cafeId);
    } catch (e) {
      // TODO: 에러 처리
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

