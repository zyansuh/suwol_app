/// 앱에서 사용하는 메시지 상수
class MessageConstants {
  // 공통
  static const String loading = '로딩 중...';
  static const String error = '오류가 발생했습니다';
  static const String success = '성공했습니다';
  static const String cancel = '취소';
  static const String confirm = '확인';
  static const String save = '저장';
  static const String delete = '삭제';
  static const String edit = '수정';
  static const String close = '닫기';

  // 인증
  static const String loginSuccess = '로그인되었습니다';
  static const String logoutSuccess = '로그아웃되었습니다';
  static const String registerSuccess = '회원가입이 완료되었습니다';

  // 포인트
  static const String pointEarned = '포인트가 적립되었습니다';
  static const String pointUsed = '포인트가 사용되었습니다';
  static const String noPointHistory = '포인트 내역이 없습니다';

  // 쿠폰
  static const String couponIssued = '쿠폰이 발급되었습니다';
  static const String couponUsed = '쿠폰이 사용되었습니다';
  static const String noCoupons = '보유한 쿠폰이 없습니다';
  static const String noUsedCoupons = '사용한 쿠폰이 없습니다';

  // 커뮤니티
  static const String postCreated = '게시글이 작성되었습니다';
  static const String postDeleted = '게시글이 삭제되었습니다';
  static const String commentCreated = '댓글이 작성되었습니다';
  static const String noPosts = '아직 게시글이 없습니다';
  static const String noComments = '댓글이 없습니다';

  // 프로필
  static const String profileUpdated = '프로필이 저장되었습니다';
  static const String imageUploaded = '이미지가 업로드되었습니다';

  // 검색
  static const String noSearchResults = '검색 결과가 없습니다';
  static const String enterSearchKeyword = '검색어를 입력해주세요';

  // 네트워크
  static const String networkError = '네트워크 연결을 확인해주세요';
  static const String timeoutError = '요청 시간이 초과되었습니다';
  static const String serverError = '서버 오류가 발생했습니다';
}
