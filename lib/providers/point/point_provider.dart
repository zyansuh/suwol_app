import '../../models/point/point_model.dart';
import '../../services/api/api_client.dart';
import '../../services/api/point_api_service.dart';
import '../../services/auth/current_user_service.dart';
import '../../constants/api_constants.dart';
import '../../core/base_provider.dart';

class PointProvider extends BaseProvider {
  final PointApiService _pointApiService;
  final CurrentUserService _currentUserService = CurrentUserService();
  int _totalPoints = 0;
  List<PointModel> _pointHistory = [];

  PointProvider()
      : _pointApiService = PointApiService(
          ApiClient(baseUrl: ApiConstants.baseUrl),
        );

  int get totalPoints => _totalPoints;
  List<PointModel> get pointHistory => _pointHistory;

  String? get _currentUserId => _currentUserService.currentUserId;

  Future<void> loadTotalPoints([String? userId]) async {
    final targetUserId = userId ?? _currentUserId;
    if (targetUserId == null) return;

    await safeAsync(() async {
      _totalPoints = await _pointApiService.getTotalPoints(targetUserId);
    });
  }

  Future<void> loadPointHistory([String? userId]) async {
    final targetUserId = userId ?? _currentUserId;
    if (targetUserId == null) return;

    await safeAsync(() async {
      _pointHistory = await _pointApiService.getPointHistory(targetUserId);
    });
  }

  Future<void> loadPoints([String? userId]) async {
    await Future.wait([
      loadTotalPoints(userId),
      loadPointHistory(userId),
    ]);
  }

  Future<void> earnPoints({
    String? userId,
    required String cafeId,
    required int amount,
    String? description,
  }) async {
    final targetUserId = userId ?? _currentUserId;
    if (targetUserId == null) return;

    await safeAsync(() async {
      await _pointApiService.earnPoints(
        userId: targetUserId,
        cafeId: cafeId,
        amount: amount,
        description: description,
      );
      await loadPoints(targetUserId);
    });
  }

  Future<void> usePoints({
    String? userId,
    required String cafeId,
    required int amount,
    String? description,
  }) async {
    final targetUserId = userId ?? _currentUserId;
    if (targetUserId == null) return;

    await safeAsync(() async {
      await _pointApiService.usePoints(
        userId: targetUserId,
        cafeId: cafeId,
        amount: amount,
        description: description,
      );
      await loadPoints(targetUserId);
    });
  }
}
