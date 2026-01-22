import 'package:uuid/uuid.dart';
import '../../models/community/community_model.dart';
import '../../services/auth/current_user_service.dart';
import '../../core/base_provider.dart';

class CommunityProvider extends BaseProvider {
  final CurrentUserService _currentUserService = CurrentUserService();
  final _uuid = const Uuid();
  
  List<PostModel> _posts = [];
  Map<String, List<CommentModel>> _comments = {};
  Set<String> _likedPosts = {};

  List<PostModel> get posts => _posts;
  
  String? get _currentUserId => _currentUserService.currentUserId ?? 'user1';

  // 게시글 관련
  Future<void> loadPosts() async {
    await safeAsync(() async {
      // 로컬 모킹 데이터
      _posts = [
        PostModel(
          id: '1',
          userId: 'user1',
          cafeId: 'cafe1',
          content: '오늘 방문한 카페가 너무 좋았어요! 분위기도 좋고 커피 맛도 최고였습니다 ☕',
          images: [],
          likeCount: 23,
          commentCount: 5,
          createdAt: DateTime.now().subtract(const Duration(hours: 2)),
        ),
        PostModel(
          id: '2',
          userId: 'user2',
          content: '새로 오픈한 카페 다녀왔어요~ 인테리어가 예뻐서 사진 찍기 좋네요',
          images: [],
          likeCount: 15,
          commentCount: 3,
          createdAt: DateTime.now().subtract(const Duration(days: 1)),
        ),
      ];
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
      final newPost = PostModel(
        id: _uuid.v4(),
        userId: targetUserId,
        cafeId: cafeId,
        content: content,
        images: images ?? [],
        likeCount: 0,
        commentCount: 0,
        createdAt: DateTime.now(),
      );
      _posts.insert(0, newPost);
      notifyListeners();
    });
  }

  Future<void> updatePost({
    required String postId,
    required String content,
    List<String>? images,
  }) async {
    await safeAsync(() async {
      final index = _posts.indexWhere((p) => p.id == postId);
      if (index != -1) {
        final post = _posts[index];
        _posts[index] = PostModel(
          id: post.id,
          userId: post.userId,
          cafeId: post.cafeId,
          content: content,
          images: images ?? post.images,
          likeCount: post.likeCount,
          commentCount: post.commentCount,
          createdAt: post.createdAt,
          updatedAt: DateTime.now(),
        );
        notifyListeners();
      }
    });
  }

  Future<void> deletePost(String postId) async {
    await safeAsync(() async {
      _posts.removeWhere((p) => p.id == postId);
      _comments.remove(postId);
      notifyListeners();
    });
  }

  // 댓글 관련
  List<CommentModel> getComments(String postId) {
    return _comments[postId] ?? [];
  }

  Future<void> loadComments(String postId) async {
    await safeAsync(() async {
      // 로컬 모킹 데이터
      _comments[postId] = [
        CommentModel(
          id: '1',
          postId: postId,
          userId: 'user3',
          content: '좋은 정보 감사합니다!',
          createdAt: DateTime.now().subtract(const Duration(hours: 1)),
        ),
        CommentModel(
          id: '2',
          postId: postId,
          userId: 'user4',
          content: '저도 가보고 싶네요',
          createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
        ),
      ];
      notifyListeners();
    });
  }

  Future<void> createComment({
    required String postId,
    String? userId,
    required String content,
  }) async {
    final targetUserId = userId ?? _currentUserId;
    if (targetUserId == null) return;

    await safeAsync(() async {
      final newComment = CommentModel(
        id: _uuid.v4(),
        postId: postId,
        userId: targetUserId,
        content: content,
        createdAt: DateTime.now(),
      );

      if (_comments[postId] == null) {
        _comments[postId] = [];
      }
      _comments[postId]!.add(newComment);

      // 게시글의 댓글 수 증가
      final postIndex = _posts.indexWhere((p) => p.id == postId);
      if (postIndex != -1) {
        final post = _posts[postIndex];
        _posts[postIndex] = PostModel(
          id: post.id,
          userId: post.userId,
          cafeId: post.cafeId,
          content: post.content,
          images: post.images,
          likeCount: post.likeCount,
          commentCount: post.commentCount + 1,
          createdAt: post.createdAt,
          updatedAt: post.updatedAt,
        );
      }

      notifyListeners();
    });
  }

  Future<void> updateComment({
    required String commentId,
    required String postId,
    required String content,
  }) async {
    await safeAsync(() async {
      final comments = _comments[postId];
      if (comments != null) {
        final index = comments.indexWhere((c) => c.id == commentId);
        if (index != -1) {
          final comment = comments[index];
          comments[index] = CommentModel(
            id: comment.id,
            postId: comment.postId,
            userId: comment.userId,
            content: content,
            createdAt: comment.createdAt,
            updatedAt: DateTime.now(),
          );
          notifyListeners();
        }
      }
    });
  }

  Future<void> deleteComment(String postId, String commentId) async {
    await safeAsync(() async {
      final comments = _comments[postId];
      if (comments != null) {
        comments.removeWhere((c) => c.id == commentId);

        // 게시글의 댓글 수 감소
        final postIndex = _posts.indexWhere((p) => p.id == postId);
        if (postIndex != -1) {
          final post = _posts[postIndex];
          _posts[postIndex] = PostModel(
            id: post.id,
            userId: post.userId,
            cafeId: post.cafeId,
            content: post.content,
            images: post.images,
            likeCount: post.likeCount,
            commentCount: post.commentCount - 1,
            createdAt: post.createdAt,
            updatedAt: post.updatedAt,
          );
        }

        notifyListeners();
      }
    });
  }

  // 좋아요 관련
  bool isLiked(String postId) {
    return _likedPosts.contains(postId);
  }

  Future<void> toggleLike(String postId) async {
    await safeAsync(() async {
      final postIndex = _posts.indexWhere((p) => p.id == postId);
      if (postIndex != -1) {
        final post = _posts[postIndex];
        final isCurrentlyLiked = _likedPosts.contains(postId);

        if (isCurrentlyLiked) {
          _likedPosts.remove(postId);
        } else {
          _likedPosts.add(postId);
        }

        _posts[postIndex] = PostModel(
          id: post.id,
          userId: post.userId,
          cafeId: post.cafeId,
          content: post.content,
          images: post.images,
          likeCount: isCurrentlyLiked ? post.likeCount - 1 : post.likeCount + 1,
          commentCount: post.commentCount,
          createdAt: post.createdAt,
          updatedAt: post.updatedAt,
        );

        notifyListeners();
      }
    });
  }

  PostModel? getPost(String postId) {
    try {
      return _posts.firstWhere((p) => p.id == postId);
    } catch (e) {
      return null;
    }
  }
}
