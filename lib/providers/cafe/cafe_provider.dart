import 'package:flutter/foundation.dart';
import '../../models/cafe/cafe_model.dart';
import '../../services/api/api_client.dart';
import '../../services/api/cafe_api_service.dart';
import '../../constants/api_constants.dart';

class CafeProvider with ChangeNotifier {
  final CafeApiService _cafeApiService;
  List<CafeModel> _cafes = [];
  List<CafeModel> _filteredCafes = [];
  CafeModel? _selectedCafe;
  bool _isLoading = false;

  CafeProvider()
      : _cafeApiService = CafeApiService(
          ApiClient(baseUrl: ApiConstants.baseUrl),
        );

  List<CafeModel> get cafes => _cafes;
  List<CafeModel> get filteredCafes =>
      _filteredCafes.isNotEmpty ? _filteredCafes : _cafes;
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
      _filteredCafes = _cafes;
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

  /// 로컬에서 카페 검색 및 필터링 (키워드 / 최대 거리 km)
  void filterCafes({String? keyword, double? maxDistanceKm}) {
    Iterable<CafeModel> result = _cafes;

    if (keyword != null && keyword.trim().isNotEmpty) {
      final lower = keyword.toLowerCase();
      result = result.where(
        (cafe) =>
            cafe.name.toLowerCase().contains(lower) ||
            cafe.address.toLowerCase().contains(lower),
      );
    }

    if (maxDistanceKm != null) {
      // 실제 거리는 위치 서비스와 함께 계산되어야 하나,
      // 현재는 예비 필터로 latitude/longitude가 있는 항목만 허용.
      result = result.where((cafe) => cafe.latitude != 0 && cafe.longitude != 0);
    }

    _filteredCafes = result.toList();
    notifyListeners();
  }

  /// 필터 초기화
  void resetFilter() {
    _filteredCafes = _cafes;
    notifyListeners();
  }
}

