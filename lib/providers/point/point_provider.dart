import 'package:flutter/foundation.dart';
import '../../models/point/point_model.dart';
import '../../services/api/api_client.dart';
import '../../services/api/point_api_service.dart';
import '../../constants/api_constants.dart';

class PointProvider with ChangeNotifier {
  final PointApiService _pointApiService;
  int _totalPoints = 0;
  List<PointModel> _pointHistory = [];
  bool _isLoading = false;

  PointProvider()
      : _pointApiService = PointApiService(
          ApiClient(baseUrl: ApiConstants.baseUrl),
        );

  int get totalPoints => _totalPoints;
  List<PointModel> get pointHistory => _pointHistory;
  bool get isLoading => _isLoading;

  Future<void> loadTotalPoints(String userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _totalPoints = await _pointApiService.getTotalPoints(userId);
    } catch (e) {
      // TODO: 에러 처리
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadPointHistory(String userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _pointHistory = await _pointApiService.getPointHistory(userId);
    } catch (e) {
      // TODO: 에러 처리
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> earnPoints({
    required String userId,
    required String cafeId,
    required int amount,
    String? description,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _pointApiService.earnPoints(
        userId: userId,
        cafeId: cafeId,
        amount: amount,
        description: description,
      );
      await loadTotalPoints(userId);
      await loadPointHistory(userId);
    } catch (e) {
      // TODO: 에러 처리
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> usePoints({
    required String userId,
    required String cafeId,
    required int amount,
    String? description,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _pointApiService.usePoints(
        userId: userId,
        cafeId: cafeId,
        amount: amount,
        description: description,
      );
      await loadTotalPoints(userId);
      await loadPointHistory(userId);
    } catch (e) {
      // TODO: 에러 처리
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

