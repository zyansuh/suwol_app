import 'package:flutter/foundation.dart';
import '../../models/community/community_model.dart';

class CommunityProvider with ChangeNotifier {
  List<PostModel> _posts = [];
  bool _isLoading = false;

  List<PostModel> get posts => _posts;
  bool get isLoading => _isLoading;

  Future<void> loadPosts() async {
    _isLoading = true;
    notifyListeners();

    try {
      // TODO: API 호출
      // _posts = await _communityApiService.getPosts();
    } catch (e) {
      // TODO: 에러 처리
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createPost({
    required String userId,
    String? cafeId,
    required String content,
    List<String>? images,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      // TODO: API 호출
      // await _communityApiService.createPost(...);
      await loadPosts();
    } catch (e) {
      // TODO: 에러 처리
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

