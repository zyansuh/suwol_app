import 'package:flutter/foundation.dart';
import '../utils/error_handler.dart';

/// Provider의 공통 기능을 제공하는 베이스 클래스
abstract class BaseProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get hasError => _errorMessage != null;

  /// 로딩 상태 설정
  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  /// 에러 메시지 설정
  void setError(String? error) {
    _errorMessage = error != null ? ErrorHandler.getErrorMessage(error) : null;
    notifyListeners();
  }

  /// 에러 초기화
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  /// 안전한 비동기 작업 실행 (에러 처리 포함)
  Future<T?> safeAsync<T>(
    Future<T> Function() action, {
    bool showError = false,
  }) async {
    setLoading(true);
    clearError();

    try {
      final result = await action();
      setLoading(false);
      return result;
    } catch (e) {
      setError(e);
      setLoading(false);
      return null;
    }
  }

  @override
  void dispose() {
    clearError();
    super.dispose();
  }
}
