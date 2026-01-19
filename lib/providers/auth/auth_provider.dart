import 'package:flutter/foundation.dart';
import '../../models/user/user_model.dart';
import '../../services/auth/auth_service.dart';
import '../../services/auth/current_user_service.dart';
import '../../core/base_provider.dart';

class AuthProvider extends BaseProvider {
  final AuthService _authService = AuthService();
  final CurrentUserService _currentUserService = CurrentUserService();
  UserModel? _user;

  UserModel? get user => _user;
  bool get isAuthenticated => _user != null;

  Future<bool> signIn(String email, String password) async {
    return await safeAsync(() async {
      final credential = await _authService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // TODO: 사용자 정보 가져오기
      // _user = await _userApiService.getUser(credential.user?.uid);
      // await _currentUserService.setUser(_user!);
      return true;
    }) ?? false;
  }

  Future<bool> signUp({
    required String email,
    required String password,
    required String name,
    required String phoneNumber,
    required UserType userType,
    String? businessNumber,
  }) async {
    return await safeAsync(() async {
      final credential = await _authService.signUpWithEmailAndPassword(
        email: email,
        password: password,
      );
      // TODO: 사용자 정보 생성
      // _user = await _userApiService.createUser(...);
      // await _currentUserService.setUser(_user!);
      return true;
    }) ?? false;
  }

  Future<void> signOut() async {
    await safeAsync(() async {
      await _authService.signOut();
      await _currentUserService.clearUser();
      _user = null;
    });
  }
}
