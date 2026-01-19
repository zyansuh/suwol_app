import '../../models/community/community_model.dart';
import '../../services/auth/current_user_service.dart';
import '../../core/base_provider.dart';

class CommunityProvider extends BaseProvider {
  final CurrentUserService _currentUserService = CurrentUserService();
  List<PostModel> _posts = [];

  List<PostModel> get posts => _posts;

  String? get _currentUserId => _currentUserService.currentUserId;

  Future<void> loadPosts() async {
    await safeAsync(() async {
      // TODO: API 호출
      // _posts = await _communityApiService.getPosts();
    });
  }

  Future<void> createPost({
    String? userId,
    String? cafeId,
    required String content,
    List<String>? images,
  }) async {
    final targetUserId = userId ?? _currentUserId;
    if (targetUserId == null) return;

    await safeAsync(() async {
      // TODO: API 호출
      // await _communityApiService.createPost(...);
      await loadPosts();
    });
  }

  Future<void> deletePost(String postId) async {
    await safeAsync(() async {
      // TODO: API 호출
      // await _communityApiService.deletePost(postId);
      await loadPosts();
    });
  }
}
