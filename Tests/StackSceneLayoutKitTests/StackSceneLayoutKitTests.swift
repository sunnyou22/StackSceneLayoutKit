import Testing
import Stack3DKit
@testable import StackSceneLayoutKit

struct StackSceneLayoutKitTests {

    @Test("홈 스택 레이아웃은 아이템 수에 따라 프리셋이 바뀐다")
    func homeStackConfigurationChangesByItemCount() {
        let single = Stack3DConfiguration.sceneLayoutsHomeStack(
            itemCount: 1,
            backgroundColor: .red,
            floorColor: .green
        )
        let multiple = Stack3DConfiguration.sceneLayoutsHomeStack(itemCount: 4)

        #expect(single.usesOrthographicProjection)
        #expect(multiple.usesOrthographicProjection)
        #expect(single.cardWidth == 2.95)
        #expect(single.cardHeight == 2.95)
        #expect(single.backgroundColor.isEqual(.red))
        #expect(single.floorColor.isEqual(.green))
        #expect(single.cameraOrthographicScale == 4.0)
        #expect(multiple.cameraOrthographicScale == 4.45)
        #expect(single.cardSpreadX == 0.0)
        #expect(multiple.cardSpreadX == 0.18)
        #expect(single.stackRootPosition.x == -0.30)
        #expect(multiple.stackRootPosition.x == -0.80)
    }
}
