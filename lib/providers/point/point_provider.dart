import 'package:flutter/foundation.dart';
import '../../models/point/point_model.dart';
import '../../services/api/api_client.dart';
import '../../services/api/point_api_service.dart';
import '../../constants/api_constants.dart';
import 'package:uuid/uuid.dart';

class PointProvider with ChangeNotifier {
  final PointApiService _pointApiService;
  final _uuid = const Uuid();
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
      // fallback: 로컬 합산
      _totalPoints =
          _pointHistory.fold<int>(0, (sum, p) => sum + (p.type == PointType.earn ? p.amount : -p.amount));
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
      // fallback: 기존 로컬 데이터 유지
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
    } catch (e) {
      // TODO: 에러 처리 또는 로컬 저장
      _addLocalPoint(
        userId: userId,
        cafeId: cafeId,
        amount: amount,
        type: PointType.earn,
        description: description ?? '로컬 적립',
      );
    } finally {
      await loadTotalPoints(userId);
      await loadPointHistory(userId);
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
    } catch (e) {
      // TODO: 에러 처리 또는 로컬 저장
      _addLocalPoint(
        userId: userId,
        cafeId: cafeId,
        amount: amount,
        type: PointType.use,
        description: description ?? '로컬 사용',
      );
    } finally {
      await loadTotalPoints(userId);
      await loadPointHistory(userId);
      _isLoading = false;
      notifyListeners();
    }
  }

  void _addLocalPoint({
    required String userId,
    required String cafeId,
    required int amount,
    required PointType type,
    String? description,
  }) {
    final point = PointModel(
      id: _uuid.v4(),
      userId: userId,
      cafeId: cafeId,
      amount: amount,
      type: type,
      description: description,
      createdAt: DateTime.now(),
    );
    _pointHistory = [point, ..._pointHistory];
  }
}

