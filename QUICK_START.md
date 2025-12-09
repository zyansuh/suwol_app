# 빠른 시작 가이드 🚀

## ✅ 완료된 작업

1. ✅ CocoaPods 설치 완료
2. ✅ iOS 프로젝트 생성 완료
3. ✅ iOS 의존성 설치 완료 (pod install)

---

## 📱 앱 실행하기

### 방법 1: Flutter CLI로 실행 (가장 간단)

터미널에서 다음 명령어를 순서대로 실행하세요:

```bash
# 1. 프로젝트 폴더로 이동
cd /Users/suhzian/Documents/suwol

# 2. 시뮬레이터 실행 (이미 열려있다면 생략)
open -a Simulator

# 3. 잠시 기다린 후 (시뮬레이터가 완전히 부팅될 때까지)
# 4. 사용 가능한 디바이스 확인
flutter devices

# 5. 앱 실행
flutter run
```

**예상 출력**:
```
Launching lib/main.dart on iPhone 15 Pro in debug mode...
Running pod install...
Running Xcode build...
```

---

### 방법 2: Xcode에서 실행

```bash
# 1. Xcode로 프로젝트 열기 (중요: .xcworkspace 파일!)
open ios/Runner.xcworkspace
```

**Xcode에서**:
1. 상단 툴바에서 시뮬레이터 선택 (예: "iPhone 15 Pro")
2. `Cmd + R` 또는 ▶️ 버튼 클릭
3. 첫 실행 시 서명 설정 필요:
   - 왼쪽 프로젝트 네비게이터에서 `Runner` 선택
   - `Signing & Capabilities` 탭
   - `Team` 드롭다운에서 Apple ID 선택
   - `Automatically manage signing` 체크

---

## 🔍 문제 해결

### 시뮬레이터가 보이지 않을 때

```bash
# 시뮬레이터 목록 확인
xcrun simctl list devices

# 특정 시뮬레이터 부팅
xcrun simctl boot "iPhone 15 Pro"

# Flutter 디바이스 새로고침
flutter devices
```

### 빌드 오류가 발생할 때

```bash
# Flutter 클린 빌드
flutter clean
flutter pub get
cd ios && pod install && cd ..
flutter run
```

### 서명 오류가 발생할 때

Xcode에서:
1. `Runner` 프로젝트 선택
2. `Signing & Capabilities` 탭
3. `Team` 선택 (Apple ID로 로그인 필요)
4. `Automatically manage signing` 체크

---

## 📚 더 자세한 가이드

상세한 설정 방법은 `XCODE_SETUP_GUIDE.md` 파일을 참고하세요.

---

**이제 앱을 실행해보세요!** 🎉



