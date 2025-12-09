# Xcode와 Flutter 연결 가이드 📱

이 가이드는 macOS에서 Xcode와 Flutter 프로젝트를 연결하고 iOS 시뮬레이터에서 앱을 실행하는 방법을 설명합니다.

---

## 📋 사전 준비사항

### 1. Xcode 설치 확인

```bash
xcode-select --version
```

Xcode가 설치되어 있지 않다면:

- Mac App Store에서 Xcode 설치
- 또는 [Apple Developer 사이트](https://developer.apple.com/xcode/)에서 다운로드

### 2. Xcode Command Line Tools 설치

```bash
xcode-select --install
```

### 3. Xcode 라이선스 동의

```bash
sudo xcodebuild -license accept
```

---

## 🔧 단계별 설정

### Step 1: CocoaPods 설치

CocoaPods는 iOS 프로젝트의 의존성 관리 도구입니다.

#### 방법 1: Homebrew로 설치 (권장)

```bash
brew install cocoapods
```

#### 방법 2: Ruby gem으로 설치

```bash
sudo gem install cocoapods
```

#### 설치 확인

```bash
pod --version
```

---

### Step 2: iOS 프로젝트 생성 (이미 완료됨 ✅)

프로젝트에 iOS 플랫폼이 이미 추가되어 있습니다:

```bash
flutter create --platforms=ios .
```

---

### Step 3: iOS 의존성 설치

프로젝트 루트에서 다음 명령어 실행:

```bash
cd ios
pod install
cd ..
```

또는 Flutter 명령어로:

```bash
flutter pub get
cd ios && pod install && cd ..
```

---

### Step 4: Flutter Doctor 확인

환경 설정이 올바른지 확인:

```bash
flutter doctor -v
```

다음 항목들이 체크되어야 합니다:

- ✅ Flutter
- ✅ Xcode
- ✅ CocoaPods
- ✅ iOS toolchain

---

## 🚀 앱 실행 방법

### 방법 1: Flutter CLI로 실행 (권장)

#### 1. 사용 가능한 디바이스 확인

```bash
flutter devices
```

출력 예시:

```
iPhone 15 Pro (mobile) • 12345678-1234-1234-1234-123456789ABC • ios • com.apple.CoreSimulator.SimRuntime.iOS-17-0 (simulator)
```

#### 2. 시뮬레이터 실행

```bash
open -a Simulator
```

또는 특정 시뮬레이터 실행:

```bash
xcrun simctl boot "iPhone 15 Pro"
```

#### 3. 앱 실행

```bash
flutter run
```

특정 디바이스 지정:

```bash
flutter run -d "iPhone 15 Pro"
```

---

### 방법 2: Xcode에서 직접 실행

#### 1. Xcode로 프로젝트 열기

```bash
open ios/Runner.xcworkspace
```

**⚠️ 중요**: `.xcworkspace` 파일을 열어야 합니다! `.xcodeproj`가 아닙니다!

#### 2. Xcode에서 설정

1. **상단 툴바에서 시뮬레이터 선택**

   - "Runner" 옆의 디바이스 선택 드롭다운 클릭
   - 원하는 iPhone 시뮬레이터 선택 (예: iPhone 15 Pro)

2. **빌드 및 실행**
   - `Cmd + R` 또는 상단의 ▶️ 버튼 클릭
   - 또는 `Product > Run` 메뉴 선택

#### 3. 첫 실행 시 주의사항

- **서명 설정**: Xcode에서 자동으로 개발자 계정을 설정하거나, 수동으로 설정해야 할 수 있습니다.
  - `Runner` 프로젝트 선택 → `Signing & Capabilities` 탭
  - `Team` 선택 (Apple ID로 로그인 필요)

---

## 🛠 문제 해결

### 문제 1: CocoaPods 설치 오류

**에러**: `pod: command not found`

**해결**:

```bash
# Homebrew로 재설치
brew install cocoapods

# 또는 PATH 확인
which pod
```

---

### 문제 2: Pod Install 실패

**에러**: `[!] CocoaPods could not find compatible versions`

**해결**:

```bash
cd ios
rm -rf Pods Podfile.lock
pod cache clean --all
pod install --repo-update
cd ..
```

---

### 문제 3: Xcode 버전 호환성

**에러**: `Xcode version mismatch`

**해결**:

```bash
# Xcode 경로 확인
xcode-select -p

# Xcode 경로 설정 (필요시)
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
```

---

### 문제 4: 시뮬레이터가 보이지 않음

**해결**:

```bash
# 시뮬레이터 목록 확인
xcrun simctl list devices

# 시뮬레이터 부팅
open -a Simulator

# Flutter 디바이스 새로고침
flutter devices
```

---

### 문제 5: 빌드 오류 (Signing)

**에러**: `Signing for "Runner" requires a development team`

**해결**:

1. Xcode에서 `Runner` 프로젝트 선택
2. `Signing & Capabilities` 탭으로 이동
3. `Team` 드롭다운에서 Apple ID 선택
4. `Automatically manage signing` 체크

---

### 문제 6: "Unable to boot simulator" 오류

**해결**:

```bash
# 모든 시뮬레이터 종료
killall Simulator

# 시뮬레이터 재시작
open -a Simulator
```

---

## 📱 실제 기기에서 테스트

### 1. 기기 등록

1. Xcode에서 `Window > Devices and Simulators` 열기
2. iPhone을 USB로 연결
3. "Trust This Computer" 선택
4. 기기가 목록에 나타나는지 확인

### 2. 개발자 계정 설정

1. Xcode에서 `Preferences > Accounts` 열기
2. Apple ID 추가
3. `Runner` 프로젝트 → `Signing & Capabilities`
4. `Team` 선택

### 3. 실행

```bash
flutter run -d <device-id>
```

또는 Xcode에서 직접 실행

---

## 🔍 유용한 명령어

### Flutter 관련

```bash
# 디바이스 목록
flutter devices

# 앱 실행 (핫 리로드)
flutter run

# 릴리즈 빌드
flutter build ios

# 의존성 업데이트
flutter pub get
```

### CocoaPods 관련

```bash
# Pod 설치
cd ios && pod install && cd ..

# Pod 업데이트
cd ios && pod update && cd ..

# Pod 캐시 정리
pod cache clean --all
```

### 시뮬레이터 관련

```bash
# 시뮬레이터 목록
xcrun simctl list devices

# 시뮬레이터 부팅
xcrun simctl boot "iPhone 15 Pro"

# 시뮬레이터 종료
xcrun simctl shutdown all

# 시뮬레이터 재설정
xcrun simctl erase all
```

---

## ✅ 체크리스트

앱을 실행하기 전에 다음을 확인하세요:

- [ ] Xcode 설치됨
- [ ] Xcode Command Line Tools 설치됨
- [ ] CocoaPods 설치됨 (`pod --version`)
- [ ] iOS 프로젝트 생성됨 (`ios/` 폴더 존재)
- [ ] Pod 설치 완료 (`cd ios && pod install`)
- [ ] Flutter Doctor 통과 (`flutter doctor`)
- [ ] 시뮬레이터 또는 실제 기기 연결됨 (`flutter devices`)
- [ ] Xcode에서 서명 설정 완료 (실제 기기인 경우)

---

## 🎯 빠른 시작 (요약)

```bash
# 1. CocoaPods 설치
brew install cocoapods

# 2. iOS 의존성 설치
cd ios && pod install && cd ..

# 3. 시뮬레이터 실행
open -a Simulator

# 4. 앱 실행
flutter run
```

또는 Xcode에서:

```bash
# 1. Xcode로 프로젝트 열기
open ios/Runner.xcworkspace

# 2. Xcode에서 Cmd + R로 실행
```

---

## 📚 추가 자료

- [Flutter iOS 설정 공식 문서](https://docs.flutter.dev/get-started/install/macos#ios-setup)
- [CocoaPods 공식 문서](https://guides.cocoapods.org/)
- [Xcode 공식 문서](https://developer.apple.com/documentation/xcode)

---

**문제가 발생하면**: GitHub Issues에 등록하거나 `flutter doctor -v` 결과를 공유해주세요!


