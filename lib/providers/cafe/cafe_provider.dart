import '../../models/cafe/cafe_model.dart';
import '../../services/api/api_client.dart';
import '../../services/api/cafe_api_service.dart';
import '../../constants/api_constants.dart';
import '../../core/base_provider.dart';

class CafeProvider extends BaseProvider {
  final CafeApiService _cafeApiService;
  List<CafeModel> _cafes = [];
  List<CafeModel> _filteredCafes = [];
  CafeModel? _selectedCafe;

  CafeProvider()
      : _cafeApiService = CafeApiService(
          ApiClient(baseUrl: ApiConstants.baseUrl),
        );

  List<CafeModel> get cafes => _cafes;
  List<CafeModel> get filteredCafes =>
      _filteredCafes.isNotEmpty ? _filteredCafes : _cafes;
  CafeModel? get selectedCafe => _selectedCafe;

  Future<void> loadCafes({
    double? latitude,
    double? longitude,
    double? radius,
  }) async {
    await safeAsync(() async {
      _cafes = await _cafeApiService.getCafes(
        latitude: latitude,
        longitude: longitude,
        radius: radius,
      );
      _filteredCafes = _cafes;
    });
  }

  Future<void> loadCafe(String cafeId) async {
    await safeAsync(() async {
      _selectedCafe = await _cafeApiService.getCafe(cafeId);
    });
  }

  void searchCafes(String query) {
    if (query.isEmpty) {
      _filteredCafes = _cafes;
    } else {
      _filteredCafes = _cafes
          .where((cafe) =>
              cafe.name.toLowerCase().contains(query.toLowerCase()) ||
              cafe.address.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  void filterByDistance(double? maxDistance) {
    if (maxDistance == null) {
      _filteredCafes = _cafes;
    } else {
      // TODO: 실제 거리 계산 구현
      _filteredCafes = _cafes;
    }
    notifyListeners();
  }

  void clearFilters() {
    _filteredCafes = _cafes;
    notifyListeners();
  }
}
