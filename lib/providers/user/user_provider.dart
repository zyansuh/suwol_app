import '../../models/user/user_model.dart';
import '../../services/api/api_client.dart';
import '../../services/api/user_api_service.dart';
import '../../services/auth/current_user_service.dart';
import '../../constants/api_constants.dart';
import '../../core/base_provider.dart';

class UserProvider extends BaseProvider {
  final UserApiService _userApiService;
  final CurrentUserService _currentUserService = CurrentUserService();
  UserModel? _user;

  UserProvider()
      : _userApiService = UserApiService(
          ApiClient(baseUrl: ApiConstants.baseUrl),
        );

  UserModel? get user => _user ?? _currentUserService.currentUser;

  Future<void> loadUser(String userId) async {
    await safeAsync(() async {
      _user = await _userApiService.getUser(userId);
      if (_user != null) {
        await _currentUserService.setUser(_user!);
      }
    });
  }

  Future<void> loadCurrentUser() async {
    final userId = await _currentUserService.loadStoredUserId();
    if (userId != null) {
      await loadUser(userId);
    }
  }

  Future<void> updateUser(Map<String, dynamic> data) async {
    if (user == null) return;

    await safeAsync(() async {
      _user = await _userApiService.updateUser(user!.id, data);
      if (_user != null) {
        await _currentUserService.setUser(_user!);
      }
    });
  }
}
