import 'package:flutter/foundation.dart';
import '../../models/user/user_model.dart';
import '../../services/storage/local_storage_service.dart';
import '../../constants/storage_keys.dart';

/// 현재 로그인한 사용자 정보를 관리하는 서비스
class CurrentUserService {
  static final CurrentUserService _instance = CurrentUserService._internal();
  factory CurrentUserService() => _instance;
  CurrentUserService._internal();

  UserModel? _currentUser;
  String? _currentUserId;

  UserModel? get currentUser => _currentUser;
  String? get currentUserId => _currentUserId;

  /// 사용자 정보 설정
  Future<void> setUser(UserModel user) async {
    _currentUser = user;
    _currentUserId = user.id;
    await LocalStorageService.getInstance().then((storage) {
      storage.setString(StorageKeys.userId, user.id);
      storage.setString(StorageKeys.userType, user.userType.toString());
    });
  }

  /// 저장된 사용자 ID 로드
  Future<String?> loadStoredUserId() async {
    final storage = await LocalStorageService.getInstance();
    _currentUserId = storage.getString(StorageKeys.userId);
    return _currentUserId;
  }

  /// 로그아웃
  Future<void> clearUser() async {
    _currentUser = null;
    _currentUserId = null;
    final storage = await LocalStorageService.getInstance();
    await storage.remove(StorageKeys.userId);
    await storage.remove(StorageKeys.userType);
  }

  /// 사용자 타입 확인
  bool get isCustomer => _currentUser?.userType == UserType.customer;
  bool get isOwner => _currentUser?.userType == UserType.owner;
}
