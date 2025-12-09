# 카페링크 수월 (CafeLink Suwol) ☕

**슬로건**: 우리 동네 카페들이 하나로 이어지다

[![Flutter](https://img.shields.io/badge/Flutter-3.0+-02569B?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.0+-0175C2?logo=dart)](https://dart.dev)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

---

## 📱 프로젝트 소개

**카페링크 수월**은 독립 카페들이 함께 고객 혜택을 공유하고, 소비자는 연합 멤버십을 통해 다양한 카페를 즐길 수 있는 상생 플랫폼입니다.

하나의 앱으로 모든 제휴 카페의 포인트와 쿠폰을 통합 관리하며, 소비자는 "통합 포인트"를 적립/사용하고, 카페 사장님은 "연합 마케팅" 및 신규 고객 유입 효과를 누릴 수 있습니다.

---

## 🎯 서비스 대상자

- **자영업 카페 운영자**: 연합 마케팅을 통한 신규 고객 유입 및 고객 관리
- **지역 카페 이용 소비자**: 다양한 카페에서 통합 포인트 적립 및 사용

---

## 💎 핵심 가치

- ✅ 독립 카페들이 함께 고객 혜택을 공유
- ✅ 소비자는 연합 멤버십을 통해 다양한 카페를 즐길 수 있음
- ✅ 하나의 앱으로 모든 제휴 카페의 포인트, 쿠폰을 통합 관리
- ✅ 소비자는 "통합 포인트"를 적립/사용
- ✅ 카페 사장님은 "연합 마케팅" 및 신규 고객 유입 효과

---

## 🚀 주요 기능

### 1. 통합포인트/쿠폰 시스템 ✅

- ✅ 포인트 모델 및 데이터 구조 설계
- ✅ 쿠폰 모델 및 데이터 구조 설계
- ✅ 포인트 적립/사용 API 서비스 구조
- ✅ 쿠폰 발급/사용 API 서비스 구조
- ✅ 포인트 카드 UI 컴포넌트 (그라데이션 디자인)
- ✅ 쿠폰 카드 UI 컴포넌트
- ✅ 포인트 화면 스켈레톤
- ✅ 쿠폰 화면 스켈레톤
- ~~실제 API 서버 연동~~
- ~~포인트 적립/사용 로직 구현~~
- ~~쿠폰 발급/사용 로직 구현~~
- ~~포인트 내역 조회 기능~~
- ~~쿠폰 사용 내역 조회 기능~~

### 1-1. 인증/회원 관리 ✅/⚠️

- ✅ 역할 기반 회원가입 UI (고객/사업자, 사업자 등록번호 입력 및 인증 버튼 포함)
- ✅ 역할 기반 로그인 UI (고객/사업자, 사업자 등록번호 입력)
- ⚠️ 실제 인증 로직(API/Firebase) 연동 미완
- ⚠️ 이메일/비밀번호 찾기, 소셜 로그인 미구현

### 2. 카페 맵 & 탐색 기능 ⚠️

- ✅ 카페 모델 및 데이터 구조 설계
- ✅ 카페 API 서비스 구조
- ✅ 위치 서비스 (Geolocator) 설정
- ✅ 카페 카드 UI 컴포넌트
- ✅ 카페 지도 화면 스켈레톤
- ✅ 카페 목록 화면 스켈레톤
- ✅ 카페 상세 화면 스켈레톤
- ~~Google Maps 실제 연동~~
- ~~카페 위치 기반 검색 기능~~
- ~~거리 계산 및 표시 기능~~
- ~~카페 필터링 기능 (거리, 혜택 등)~~
- ~~카페 상세 정보 표시~~

### 3. 고객 리워드 & 등급제 ⚠️

- ✅ 리워드 모델 및 데이터 구조 설계
- ✅ 등급 시스템 (브론즈, 실버, 골드, 플래티넘)
- ✅ 리워드 화면 스켈레톤
- ~~등급별 혜택 표시~~
- ~~등급 진행률 표시~~
- ~~방문 횟수 집계~~
- ~~리워드 히스토리 조회~~

### 4. 사장님 전용 관리 페이지 ⚠️

- ✅ 사장님 홈 화면 스켈레톤
- ✅ 카페 관리 화면 스켈레톤
- ✅ 쿠폰 관리 화면 스켈레톤
- ✅ 통계 화면 스켈레톤
- ~~카페 정보 등록/수정 기능~~
- ~~쿠폰 생성/수정/삭제 기능~~
- ~~매출 통계 및 분석~~
- ~~고객 방문 통계~~
- ~~포인트 사용 통계~~

### 5. 커뮤니티 피드 ⚠️

- ✅ 커뮤니티 모델 (게시글, 댓글) 설계
- ✅ 게시글 카드 UI 컴포넌트
- ✅ 커뮤니티 피드 화면 스켈레톤
- ✅ 게시글 상세 화면 스켈레톤
- ~~커뮤니티 API 서비스~~
- ~~게시글 작성/수정/삭제 기능~~
- ~~댓글 작성/수정/삭제 기능~~
- ~~좋아요 기능~~
- ~~이미지 업로드 기능~~

---

## 🎨 디자인 시스템

### 컬러 팔레트

#### Brand Colors

- **Primary**: `#5A3825` - 카페 감성의 메인 브라운
- **Secondary**: `#EEDAC6` - 부드러운 라떼톤 배경
- **Accent**: `#8BC8A6` - 리워드·포인트 강조 컬러

#### Neutral Colors

- **White**: `#FFFFFF`
- **Light**: `#FAF9F7`
- **Gray1**: `#E5E5E5`
- **Gray2**: `#A1A1A1`
- **Gray3**: `#6F6F6F`
- **Dark**: `#2A2A2A`

#### Dark Mode (준비됨)

- **Background**: `#1B1B1B`
- **Card**: `#262626`
- **TextPrimary**: `#F1F1F1`
- **TextSecondary**: `#A8A8A8`

### 타이포그래피

**폰트**: Pretendard (Google Fonts)

- **Display/Large**: 28px / Bold - 웰컴 화면, 큰 타이틀
- **Display/Medium**: 24px / SemiBold - 메인 헤더
- **Display/Small**: 20px / Medium - 섹션 헤더
- **Body/Large**: 18px / Medium
- **Body/Medium**: 16px / Regular
- **Body/Small**: 14px / Regular
- **Caption**: 12px / Regular
- **Tag**: 11px / SemiBold

### 레이아웃 토큰

- **Default Padding**: 16px
- **Section Gap**: 24px
- **Card Radius**: 12px
- **Button Radius**: 8px
- **Image Radius**: 10px
- **NavBar Height**: 72px
- **App Bar Height**: 56px

---

## 📁 프로젝트 구조

```
suwol/
├── lib/
│   ├── main.dart                    # 앱 진입점
│   ├── app.dart                     # 앱 설정 및 Provider 초기화
│   │
│   ├── models/                      # 데이터 모델 ✅
│   │   ├── user/user_model.dart
│   │   ├── cafe/cafe_model.dart
│   │   ├── point/point_model.dart
│   │   ├── coupon/coupon_model.dart
│   │   ├── reward/reward_model.dart
│   │   └── community/community_model.dart
│   │
│   ├── screens/                     # 화면 (UI) ⚠️
│   │   ├── auth/                    # 로그인/회원가입 (역할 선택 UI 구현)
│   │   ├── customer/                # 고객 화면 (홈 화면 일부 구현)
│   │   ├── owner/                   # 사장님 화면 (스켈레톤)
│   │   ├── map/                     # 지도 화면 (스켈레톤)
│   │   ├── community/               # 커뮤니티 화면 (스켈레톤)
│   │   └── common/                  # 공통 화면
│   │
│   ├── widgets/                     # 재사용 가능한 위젯 ✅
│   │   ├── common/                  # 공통 위젯
│   │   ├── point/                   # 포인트 위젯 (카드 구현)
│   │   ├── coupon/                  # 쿠폰 위젯 (카드 구현)
│   │   ├── cafe/                    # 카페 위젯 (카드 구현)
│   │   └── community/               # 커뮤니티 위젯 (카드 구현)
│   │
│   ├── services/                    # 서비스 레이어 ⚠️
│   │   ├── api/                     # API 서비스 (구조만)
│   │   ├── auth/                    # 인증 서비스 (Firebase 구조)
│   │   ├── storage/                 # 로컬 스토리지
│   │   └── location/                # 위치 서비스
│   │
│   ├── providers/                   # 상태 관리 (Provider) ⚠️
│   │   ├── auth/
│   │   ├── user/
│   │   ├── cafe/
│   │   ├── point/
│   │   ├── coupon/
│   │   └── community/
│   │
│   ├── utils/                       # 유틸리티 함수 ✅
│   │   ├── date_formatter.dart
│   │   ├── validators.dart
│   │   └── format_helper.dart
│   │
│   ├── constants/                   # 상수 ✅
│   │   ├── api_constants.dart
│   │   ├── app_constants.dart
│   │   └── storage_keys.dart
│   │
│   ├── theme/                       # 테마 설정 ✅
│   │   └── app_theme.dart          # 완전 구현됨
│   │
│   └── routes/                      # 라우팅 ✅
│       └── app_router.dart         # GoRouter 설정
│
├── assets/                          # 리소스
│   ├── images/
│   ├── icons/
│   └── fonts/
│
├── pubspec.yaml                     # 의존성 관리
├── README.md                        # 프로젝트 설명
├── PROJECT_STRUCTURE.md             # 상세 구조 문서
└── .gitignore
```

**범례**:

- ✅ 완전 구현됨
- ⚠️ 기본 구조만 구현됨 (로직 미완성)
- ~~취소선~~ 아직 구현되지 않음

---

## 🛠 기술 스택

### 프레임워크 & 언어

- **Flutter**: 3.0+
- **Dart**: 3.0+

### 상태 관리

- **Provider**: 6.1.1 - 주요 상태 관리
- **flutter_bloc**: 8.1.3 - 선택적 사용

### 네비게이션

- **go_router**: 13.0.0 - 선언적 라우팅

### 네트워킹

- **dio**: 5.4.0 - HTTP 클라이언트

### 로컬 스토리지

- **shared_preferences**: 2.2.2 - 간단한 키-값 저장
- **hive**: 2.2.3 - 빠른 로컬 데이터베이스

### 지도 & 위치

- **google_maps_flutter**: 2.5.0 - Google Maps 연동
- **geolocator**: 10.1.0 - 위치 정보
- **geocoding**: 2.1.1 - 주소 변환

### 인증

- **firebase_core**: 2.24.2
- **firebase_auth**: 4.15.3

### UI 컴포넌트

- **flutter_svg**: 2.0.9 - SVG 이미지
- **cached_network_image**: 3.3.1 - 이미지 캐싱
- **shimmer**: 3.0.0 - 로딩 애니메이션
- **google_fonts**: 6.3.3 - Pretendard 폰트

### 유틸리티

- **intl**: 0.18.1 - 국제화 및 날짜 포맷
- **uuid**: 4.2.1 - 고유 ID 생성
- **image_picker**: 1.0.7 - 이미지 선택

---

## 🚀 시작하기

### 사전 요구사항

- Flutter SDK 3.0 이상
- Dart SDK 3.0 이상
- iOS 개발: Xcode 14 이상 (macOS)
- Android 개발: Android Studio 또는 VS Code

### 설치 방법

1. **저장소 클론**

   ```bash
   git clone https://github.com/zyansuh/suwol_app.git
   cd suwol_app
   ```

2. **의존성 설치**

   ```bash
   flutter pub get
   ```

3. **Firebase 설정** (필수)

   - Firebase 프로젝트 생성
   - `ios/Runner/GoogleService-Info.plist` 추가
   - `android/app/google-services.json` 추가
   - Firebase Authentication 활성화

4. **API 서버 설정** (필수)

   - `lib/constants/api_constants.dart`에서 API 베이스 URL 설정

   ```dart
   static const String baseUrl = 'https://your-api-server.com';
   ```

5. **앱 실행**
   ```bash
   flutter run
   ```

### 개발 환경 설정

1. **코드 포맷팅**

   ```bash
   dart format lib/
   ```

2. **코드 분석**

   ```bash
   flutter analyze
   ```

3. **의존성 업데이트 확인**
   ```bash
   flutter pub outdated
   ```

---

## 📱 주요 화면

### 고객 화면

- ✅ **홈 화면**: 포인트 카드, 쿠폰 목록, 주변 카페 리스트 (일부 구현)
- ⚠️ **포인트 화면**: 포인트 내역 및 적립/사용 (스켈레톤)
- ⚠️ **쿠폰 화면**: 보유 쿠폰 목록 (스켈레톤)
- ⚠️ **리워드 화면**: 등급 및 혜택 정보 (스켈레톤)
- ⚠️ **프로필 화면**: 사용자 정보 및 설정 (스켈레톤)
- ✅ **로그인/회원가입**: 고객/사업자 선택형 UI, 사업자용 추가 필드

### 사장님 화면

- ⚠️ **관리 홈**: 대시보드 및 주요 통계 (스켈레톤)
- ⚠️ **카페 관리**: 카페 정보 등록/수정 (스켈레톤)
- ⚠️ **쿠폰 관리**: 쿠폰 생성/수정/삭제 (스켈레톤)
- ⚠️ **통계**: 매출 및 고객 통계 (스켈레톤)

### 공통 화면

- ✅ **스플래시 화면**: 앱 시작 화면
- ⚠️ **로그인 화면**: 이메일/비밀번호 로그인 (스켈레톤)
- ⚠️ **회원가입 화면**: 신규 사용자 등록 (스켈레톤)
- ⚠️ **카페 지도**: Google Maps 연동 (스켈레톤)
- ⚠️ **카페 목록**: 주변 카페 리스트 (스켈레톤)
- ⚠️ **카페 상세**: 카페 정보 및 혜택 (스켈레톤)
- ⚠️ **커뮤니티 피드**: 게시글 목록 (스켈레톤)
- ✅ **로그인/회원가입**: 역할 기반 폼 (고객/사업자), 사업자 인증 입력 포함

---

## 🔧 개발 상태

### 완료된 작업 ✅

- [x] 프로젝트 구조 설계 및 생성
- [x] 모든 데이터 모델 클래스 작성
- [x] 기본 화면 스켈레톤 생성
- [x] 재사용 가능한 위젯 컴포넌트 작성
- [x] API 서비스 레이어 구조 설계
- [x] 상태 관리 Provider 구조 설계
- [x] 디자인 시스템 (컬러, 타이포그래피, 레이아웃) 완전 구현
- [x] 홈 화면 기본 UI 구현
- [x] 포인트 카드 그라데이션 디자인 구현
- [x] 라우팅 시스템 (GoRouter) 설정
- [x] 유틸리티 함수 작성
- [x] Git 저장소 초기화 및 GitHub 연동

### 진행 중 ⚠️

- [ ] 실제 API 서버 연동
- [ ] Firebase 인증 구현
- [ ] 각 화면의 비즈니스 로직 구현
- [ ] Google Maps 실제 연동
- [ ] 이미지 업로드 기능

### 예정된 작업 📋

- [ ] 포인트 적립/사용 로직 완성
- [ ] 쿠폰 발급/사용 로직 완성
- [ ] 카페 검색 및 필터링 기능
- [ ] 커뮤니티 게시글 CRUD 기능
- [ ] 사장님 관리 기능 완성
- [ ] 통계 및 분석 기능
- [ ] 푸시 알림 설정
- [ ] 다크 모드 지원
- [ ] 단위 테스트 작성
- [ ] 통합 테스트 작성
- [ ] 앱 스토어 배포 준비

---

## 🤝 기여하기

프로젝트에 기여하고 싶으시다면:

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 📄 라이선스

이 프로젝트는 MIT 라이선스를 따릅니다. 자세한 내용은 `LICENSE` 파일을 참조하세요.

---

## 📞 문의

프로젝트에 대한 문의사항이 있으시면 이슈를 등록해주세요.

- GitHub Issues: [이슈 등록](https://github.com/zyansuh/suwol_app/issues)

---

## 🙏 감사의 말

이 프로젝트는 독립 카페와 지역 커뮤니티의 상생을 위해 만들어졌습니다.

**"우리 동네 카페들이 하나로 이어지다"** ☕

---

**Made with ❤️ for local cafes**

---

## 📚 추가 문서

- 빠른 실행 가이드: `QUICK_START.md`
- Xcode / iOS 설정 가이드: `XCODE_SETUP_GUIDE.md`
