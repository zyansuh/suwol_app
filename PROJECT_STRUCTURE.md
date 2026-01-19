# 카페링크 수월 프로젝트 구조

## 전체 구조

```
suwol/
├── lib/
│   ├── main.dart                    # 앱 진입점
│   ├── app.dart                     # 앱 설정 및 Provider 초기화
│   │
│   ├── models/                      # 데이터 모델
│   │   ├── user/
│   │   │   └── user_model.dart      # 사용자 모델
│   │   ├── cafe/
│   │   │   └── cafe_model.dart      # 카페 모델
│   │   ├── point/
│   │   │   └── point_model.dart     # 포인트 모델
│   │   ├── coupon/
│   │   │   └── coupon_model.dart    # 쿠폰 모델
│   │   ├── reward/
│   │   │   └── reward_model.dart    # 리워드/등급 모델
│   │   └── community/
│   │       └── community_model.dart # 커뮤니티 모델
│   │
│   ├── screens/                     # 화면 (UI)
│   │   ├── auth/
│   │   │   ├── login_screen.dart    # 로그인 화면
│   │   │   └── register_screen.dart # 회원가입 화면
│   │   ├── customer/
│   │   │   ├── home_screen.dart     # 고객 홈 화면
│   │   │   ├── point_screen.dart     # 포인트 화면
│   │   │   ├── coupon_screen.dart    # 쿠폰 화면
│   │   │   ├── reward_screen.dart    # 리워드 화면
│   │   │   └── profile_screen.dart   # 프로필 화면
│   │   ├── owner/
│   │   │   ├── owner_home_screen.dart      # 사장님 홈 화면
│   │   │   ├── cafe_manage_screen.dart     # 카페 관리 화면
│   │   │   ├── coupon_manage_screen.dart  # 쿠폰 관리 화면
│   │   │   └── statistics_screen.dart     # 통계 화면
│   │   ├── map/
│   │   │   ├── cafe_map_screen.dart        # 카페 지도 화면
│   │   │   ├── cafe_list_screen.dart       # 카페 목록 화면
│   │   │   └── cafe_detail_screen.dart      # 카페 상세 화면
│   │   ├── community/
│   │   │   ├── community_feed_screen.dart  # 커뮤니티 피드 화면
│   │   │   └── post_detail_screen.dart     # 게시글 상세 화면
│   │   └── common/
│   │       └── splash_screen.dart          # 스플래시 화면
│   │
│   ├── widgets/                     # 재사용 가능한 위젯
│   │   ├── common/
│   │   │   ├── app_button.dart      # 공통 버튼
│   │   │   ├── loading_indicator.dart # 로딩 인디케이터
│   │   │   └── error_widget.dart    # 에러 위젯
│   │   ├── point/
│   │   │   └── point_card.dart      # 포인트 카드
│   │   ├── coupon/
│   │   │   └── coupon_card.dart    # 쿠폰 카드
│   │   ├── cafe/
│   │   │   └── cafe_card.dart       # 카페 카드
│   │   └── community/
│   │       └── post_card.dart      # 게시글 카드
│   │
│   ├── services/                    # 서비스 레이어
│   │   ├── api/
│   │   │   ├── api_client.dart      # API 클라이언트 (Dio)
│   │   │   ├── user_api_service.dart    # 사용자 API
│   │   │   ├── cafe_api_service.dart    # 카페 API
│   │   │   ├── point_api_service.dart   # 포인트 API
│   │   │   └── coupon_api_service.dart  # 쿠폰 API
│   │   ├── auth/
│   │   │   └── auth_service.dart    # 인증 서비스 (Firebase)
│   │   ├── storage/
│   │   │   └── local_storage_service.dart # 로컬 스토리지
│   │   └── location/
│   │       └── location_service.dart     # 위치 서비스
│   │
│   ├── providers/                   # 상태 관리 (Provider)
│   │   ├── auth/
│   │   │   └── auth_provider.dart   # 인증 상태 관리
│   │   ├── user/
│   │   │   └── user_provider.dart   # 사용자 상태 관리
│   │   ├── cafe/
│   │   │   └── cafe_provider.dart   # 카페 상태 관리
│   │   ├── point/
│   │   │   └── point_provider.dart  # 포인트 상태 관리
│   │   ├── coupon/
│   │   │   └── coupon_provider.dart # 쿠폰 상태 관리
│   │   └── community/
│   │       └── community_provider.dart # 커뮤니티 상태 관리
│   │
│   ├── utils/                       # 유틸리티 함수
│   │   ├── date_formatter.dart       # 날짜 포맷터
│   │   ├── validators.dart          # 입력 검증
│   │   └── format_helper.dart       # 포맷 헬퍼
│   │
│   ├── constants/                   # 상수
│   │   ├── api_constants.dart       # API 상수
│   │   ├── app_constants.dart       # 앱 상수
│   │   └── storage_keys.dart        # 스토리지 키
│   │
│   ├── theme/                       # 테마 설정
│   │   └── app_theme.dart          # 앱 테마
│   │
│   └── routes/                      # 라우팅
│       └── app_router.dart         # GoRouter 설정
│
├── assets/                          # 리소스
│   ├── images/                     # 이미지
│   ├── icons/                      # 아이콘
│   └── fonts/                      # 폰트
│
├── pubspec.yaml                     # 의존성 관리
├── README.md                        # 프로젝트 설명
├── PROJECT_STRUCTURE.md             # 이 파일
└── .gitignore                       # Git 제외 파일
```

## 주요 기능별 구조

### 1. 통합포인트/쿠폰 시스템

- **모델**: `models/point/`, `models/coupon/`
- **화면**: `screens/customer/point_screen.dart`, `screens/customer/coupon_screen.dart`
- **위젯**: `widgets/point/`, `widgets/coupon/`
- **서비스**: `services/api/point_api_service.dart`, `services/api/coupon_api_service.dart`
- **상태 관리**: `providers/point/`, `providers/coupon/`

### 2. 카페 맵 & 탐색 기능

- **모델**: `models/cafe/`
- **화면**: `screens/map/`
- **위젯**: `widgets/cafe/`
- **서비스**: `services/api/cafe_api_service.dart`, `services/location/`
- **상태 관리**: `providers/cafe/`

### 3. 고객 리워드 & 등급제

- **모델**: `models/reward/`
- **화면**: `screens/customer/reward_screen.dart`
- **서비스**: `services/api/` (포인트와 연계)

### 4. 사장님 전용 관리 페이지

- **화면**: `screens/owner/`
- **서비스**: `services/api/cafe_api_service.dart`, `services/api/coupon_api_service.dart`

### 5. 커뮤니티 피드

- **모델**: `models/community/`
- **화면**: `screens/community/`
- **위젯**: `widgets/community/`
- **상태 관리**: `providers/community/`

## 다음 단계

1. **의존성 설치**: `flutter pub get`
2. **Firebase 설정**: Firebase 프로젝트 생성 및 설정 파일 추가
3. **API 서버 연동**: `constants/api_constants.dart`에서 API URL 설정
4. **화면 구현**: 각 화면의 UI 및 로직 구현
5. **테스트**: 단위 테스트 및 통합 테스트 작성
