# StackSceneLayoutKit

`StackSceneLayoutKit`은 홈 화면 스타일의 스택형 3D 레이아웃과 모션을 재사용하기 위한 Swift Package입니다.

실제 렌더링 엔진은 [`Stack3DKit`](https://github.com/sunnyou22/Stack3DKit.git)이고, 이 패키지는 그 위에 얇은 레이아웃 계층을 제공합니다.

## 책임 범위

- `HomeStackSceneLayoutView` 제공
- 홈 스택 전용 카메라, 스프레드, 포커스 모션 프리셋 제공
- `Stack3DSceneView`를 앱 모델과 분리된 형태로 감싸기

이 패키지는 앱 전용 모델을 알지 못합니다. 호스트 앱이 `Stack3DItem` 배열, 선택 상태, 활성화 콜백을 만들어서 주입해야 합니다.

## 요구 사항

- iOS 18 이상
- Swift 5.10
- `Stack3DKit`

## 설치

Swift Package Manager에서 아래 저장소를 추가합니다.

```swift
.package(url: "https://github.com/sunnyou22/StackSceneLayoutKit.git", branch: "main")
```

앱 코드에서 `Stack3DItem` 또는 `Stack3DConfiguration`을 직접 다룬다면 `Stack3DKit`도 함께 import 해야 합니다.

## 포함 파일

- [`Sources/StackSceneLayoutKit/HomeStackSceneLayoutView.swift`](Sources/StackSceneLayoutKit/HomeStackSceneLayoutView.swift)
- [`Tests/StackSceneLayoutKitTests/StackSceneLayoutKitTests.swift`](Tests/StackSceneLayoutKitTests/StackSceneLayoutKitTests.swift)

## 사용 예시

```swift
import SwiftUI
import Stack3DKit
import StackSceneLayoutKit
import UIKit

struct DemoView: View {
    @State private var selectedItemID: String?
    @State private var deletingItemID: String?
    @State private var frontItemID: String?

    private let items: [Stack3DItem<String>] = [
        Stack3DItem(
            id: "first",
            frontContents: UIImage(named: "card-1") ?? UIColor.systemGray5,
            renderToken: "first|v1",
            customSize: CGSize(width: 2.8, height: 2.8)
        ),
        Stack3DItem(
            id: "second",
            frontContents: UIImage(named: "card-2") ?? UIColor.systemGray5,
            renderToken: "second|v1",
            customSize: CGSize(width: 2.8, height: 2.8)
        )
    ]

    var body: some View {
        HomeStackSceneLayoutView(
            items: items,
            isInteractionEnabled: true,
            backgroundColor: .clear,
            floorColor: .clear,
            onSelect: { itemID in
                selectedItemID = itemID
            },
            onActivate: { itemID in
                print("activated:", itemID)
            },
            selectedItemID: $selectedItemID,
            deletingItemID: $deletingItemID,
            frontItemID: $frontItemID
        )
    }
}
```

## 고급 사용

직접 configuration만 가져다 쓰고 싶다면 다음 preset을 사용할 수 있습니다.

```swift
let configuration = Stack3DConfiguration.sceneLayoutsHomeStack(itemCount: items.count)
```

## 테스트

패키지 테스트 코드는 [`Tests/StackSceneLayoutKitTests/StackSceneLayoutKitTests.swift`](Tests/StackSceneLayoutKitTests/StackSceneLayoutKitTests.swift)에 있습니다.

이 패키지는 `UIKit` 기반이므로 독립 검증은 iOS 대상 Xcode 프로젝트 또는 소비자 앱에서 하는 편이 안전합니다.

## 라이선스

독립 저장소로 분리할 때 프로젝트 정책에 맞는 라이선스를 추가하세요.
