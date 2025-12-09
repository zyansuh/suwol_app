import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import '../../models/community/community_model.dart';

class CommunityProvider with ChangeNotifier {
  final _uuid = const Uuid();
  List<PostModel> _posts = [];
  List<CommentModel> _comments = [];
  bool _isLoading = false;

  List<PostModel> get posts => _posts;
  bool get isLoading => _isLoading;

  Future<void> loadPosts() async {
    _isLoading = true;
    notifyListeners();

    try {
      // TODO: API 호출
      // _posts = await _communityApiService.getPosts();
      // 데모용 더미 데이터
      _posts = [
        PostModel(
          id: _uuid.v4(),
          userId: 'user-1',
          cafeId: 'cafe-1',
          content: '새로 오픈한 카페, 라떼 맛집이네요!',
          images: const [],
          likeCount: 12,
          commentCount: 3,
          createdAt: DateTime.now().subtract(const Duration(hours: 3)),
        ),
      ];
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
      final newPost = PostModel(
        id: _uuid.v4(),
        userId: userId,
        cafeId: cafeId,
        content: content,
        images: images ?? const [],
        likeCount: 0,
        commentCount: 0,
        createdAt: DateTime.now(),
      );
      _posts = [newPost, ..._posts];
    } catch (e) {
      // TODO: 에러 처리
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updatePost({
    required String postId,
    required String content,
    List<String>? images,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      _posts = _posts.map((post) {
        if (post.id == postId) {
          return PostModel(
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
        }
        return post;
      }).toList();
    } catch (e) {
      // TODO: 에러 처리
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deletePost(String postId) async {
    _isLoading = true;
    notifyListeners();
    try {
      _posts = _posts.where((post) => post.id != postId).toList();
    } catch (e) {
      // TODO: 에러 처리
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addComment({
    required String postId,
    required String userId,
    required String content,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final comment = CommentModel(
        id: _uuid.v4(),
        postId: postId,
        userId: userId,
        content: content,
        createdAt: DateTime.now(),
      );
      _comments = [comment, ..._comments];
      _posts = _posts.map((post) {
        if (post.id == postId) {
          return PostModel(
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
        return post;
      }).toList();
    } catch (e) {
      // TODO: 에러 처리
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

