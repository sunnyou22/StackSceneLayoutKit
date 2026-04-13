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
        #expect(multiple.cameraOrthographicScale == 4.38)
        #expect(single.cardSpreadX == 0.0)
        #expect(multiple.cardSpreadX == 0.15)
        #expect(single.stackRootPosition.x == -0.30)
        #expect(multiple.stackRootPosition.x == -0.40)
    }

    @Test("홈 스택 레이아웃은 시각 대칭을 위해 왼쪽을 조금 더 멀게, 오른쪽을 조금 더 가깝게 둔다")
    func homeStackConfigurationAppliesVisualSymmetryCompensation() {
        let two = Stack3DConfiguration.sceneLayoutsHomeStack(itemCount: 2)
        let three = Stack3DConfiguration.sceneLayoutsHomeStack(itemCount: 3)
        let four = Stack3DConfiguration.sceneLayoutsHomeStack(itemCount: 4)

        #expect(two.leftSideStackBaseOffsetX > two.rightSideStackBaseOffsetX)
        #expect(three.leftSideStackBaseOffsetX > three.rightSideStackBaseOffsetX)
        #expect(four.leftSideStackBaseOffsetX > four.rightSideStackBaseOffsetX)

        #expect(two.leftSideStackBaseOffsetZ > two.rightSideStackBaseOffsetZ)
        #expect(three.leftSideStackBaseOffsetZ > three.rightSideStackBaseOffsetZ)
        #expect(four.leftSideStackBaseOffsetZ > four.rightSideStackBaseOffsetZ)

        #expect(two.leftSideStackBaseOffsetX < three.leftSideStackBaseOffsetX)
        #expect(three.leftSideStackBaseOffsetX < four.leftSideStackBaseOffsetX)
        #expect(four.leftSideStackBaseOffsetX - two.leftSideStackBaseOffsetX <= 0.45)

        #expect(two.cameraLookAt.x > three.cameraLookAt.x)
        #expect(three.cameraLookAt.x > four.cameraLookAt.x)
        #expect(four.stackRootPosition.x > -0.45)
    }
}
