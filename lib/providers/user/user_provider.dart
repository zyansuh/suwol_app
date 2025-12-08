import 'package:flutter/foundation.dart';
import '../../models/user/user_model.dart';
import '../../services/api/api_client.dart';
import '../../services/api/user_api_service.dart';
import '../../constants/api_constants.dart';

class UserProvider with ChangeNotifier {
  final UserApiService _userApiService;
  UserModel? _user;
  bool _isLoading = false;

  UserProvider()
      : _userApiService = UserApiService(
          ApiClient(baseUrl: ApiConstants.baseUrl),
        );

  UserModel? get user => _user;
  bool get isLoading => _isLoading;

  Future<void> loadUser(String userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _user = await _userApiService.getUser(userId);
    } catch (e) {
      // TODO: 에러 처리
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateUser(Map<String, dynamic> data) async {
    if (_user == null) return;

    _isLoading = true;
    notifyListeners();

    try {
      _user = await _userApiService.updateUser(_user!.id, data);
    } catch (e) {
      // TODO: 에러 처리
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

