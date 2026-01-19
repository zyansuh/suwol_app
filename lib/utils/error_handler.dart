import 'package:flutter/material.dart';

/// 에러 처리 유틸리티
class ErrorHandler {
  /// 에러 메시지를 사용자 친화적인 메시지로 변환
  static String getErrorMessage(dynamic error) {
    if (error is String) {
      return error;
    }

    // 네트워크 에러
    if (error.toString().contains('SocketException') ||
        error.toString().contains('Network')) {
      return '네트워크 연결을 확인해주세요';
    }

    // 타임아웃 에러
    if (error.toString().contains('Timeout')) {
      return '요청 시간이 초과되었습니다';
    }

    // 인증 에러
    if (error.toString().contains('401') ||
        error.toString().contains('Unauthorized')) {
      return '인증이 필요합니다';
    }

    // 서버 에러
    if (error.toString().contains('500') ||
        error.toString().contains('Server')) {
      return '서버 오류가 발생했습니다';
    }

    // 기본 메시지
    return '오류가 발생했습니다. 다시 시도해주세요';
  }

  /// 스낵바로 에러 표시
  static void showErrorSnackBar(BuildContext context, dynamic error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(getErrorMessage(error)),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  /// 다이얼로그로 에러 표시
  static void showErrorDialog(BuildContext context, dynamic error) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('오류'),
        content: Text(getErrorMessage(error)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }
}
