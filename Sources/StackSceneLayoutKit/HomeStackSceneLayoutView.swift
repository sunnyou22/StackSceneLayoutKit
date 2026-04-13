import SceneKit
import Stack3DKit
import SwiftUI
import UIKit

public struct HomeStackSceneLayoutView<ID: Hashable>: View {
    public let items: [Stack3DItem<ID>]
    public var isInteractionEnabled: Bool
    public var backgroundColor: UIColor
    public var floorColor: UIColor
    public var onSelect: (ID) -> Void
    public var onActivate: (ID) -> Void
    @Binding public var selectedItemID: ID?
    @Binding public var deletingItemID: ID?
    @Binding public var frontItemID: ID?

    public init(
        items: [Stack3DItem<ID>],
        isInteractionEnabled: Bool = true,
        backgroundColor: UIColor = .clear,
        floorColor: UIColor = .clear,
        onSelect: @escaping (ID) -> Void,
        onActivate: @escaping (ID) -> Void = { _ in },
        selectedItemID: Binding<ID?>,
        deletingItemID: Binding<ID?>,
        frontItemID: Binding<ID?>
    ) {
        self.items = items
        self.isInteractionEnabled = isInteractionEnabled
        self.backgroundColor = backgroundColor
        self.floorColor = floorColor
        self.onSelect = onSelect
        self.onActivate = onActivate
        self._selectedItemID = selectedItemID
        self._deletingItemID = deletingItemID
        self._frontItemID = frontItemID
    }

    public var body: some View {
        Stack3DSceneView(
            items: items,
            configuration: .sceneLayoutsHomeStack(
                itemCount: items.count,
                backgroundColor: backgroundColor,
                floorColor: floorColor
            ),
            isInteractionEnabled: isInteractionEnabled,
            onSelect: onSelect,
            onActivate: onActivate,
            selectedItemID: $selectedItemID,
            deletingItemID: $deletingItemID,
            frontItemID: $frontItemID
        )
    }
}

public extension Stack3DConfiguration {
    static func sceneLayoutsHomeStack(
        itemCount: Int,
        backgroundColor: UIColor = .clear,
        floorColor: UIColor = .clear
    ) -> Stack3DConfiguration {
        let layoutProfile = HomeStackLayoutProfile.make(for: itemCount)
        var configuration = sceneLayoutsBase(
            backgroundColor: backgroundColor,
            floorColor: floorColor
        )

        let unitHeight: CGFloat = 2.95
        configuration.cardHeight = unitHeight
        configuration.cardWidth = unitHeight
        configuration.cardThickness = 0.003
        configuration.chamferRadius = 0.0

        configuration.cardSpreadX = layoutProfile.cardSpreadX
        configuration.cardSpreadY = layoutProfile.cardSpreadY
        configuration.cardSpreadZ = layoutProfile.cardSpreadZ

        configuration.leftSideStackBaseOffsetX = layoutProfile.leftSideStackBaseOffsetX
        configuration.rightSideStackBaseOffsetX = layoutProfile.rightSideStackBaseOffsetX
        configuration.sideStackBaseOffsetY = layoutProfile.sideStackBaseOffsetY
        configuration.leftSideStackBaseOffsetZ = layoutProfile.leftSideStackBaseOffsetZ
        configuration.rightSideStackBaseOffsetZ = layoutProfile.rightSideStackBaseOffsetZ

        configuration.focusedCardScale = layoutProfile.focusedCardScale
        configuration.cardLiftOnFocus = 0.05
        configuration.cardPullOutX = 0.0
        configuration.cardPullOutZ = layoutProfile.cardPullOutZ

        configuration.frontCardRotationY = layoutProfile.frontCardRotationY
        configuration.cardPitchX = -0.02

        configuration.usesOrthographicProjection = true
        configuration.cameraOrthographicScale = layoutProfile.cameraOrthographicScale
        configuration.cameraPosition = layoutProfile.cameraPosition
        configuration.cameraLookAt = layoutProfile.cameraLookAt
        configuration.stackRootPosition = layoutProfile.stackRootPosition
        configuration.inactiveCardOpacity = 0.82

        return configuration
    }
}

private extension Stack3DConfiguration {
    static func sceneLayoutsBase(
        backgroundColor: UIColor,
        floorColor: UIColor
    ) -> Stack3DConfiguration {
        Stack3DConfiguration(
            backgroundColor: backgroundColor,
            floorColor: floorColor,
            cardWidth: 1.56,
            cardHeight: 0.98,
            cardThickness: 0.006,
            dummyThickness: 0.006,
            primaryDummyCount: 0,
            secondaryDummyCount: 0,
            chamferRadius: 0.0,
            cardPitchX: 0.0,
            cardYawPerIndex: -0.003,
            cardSpreadX: 0.06,
            cardSpreadY: 0.02,
            cardSpreadZ: 0.02,
            leftSideStackBaseOffsetX: 1.0,
            rightSideStackBaseOffsetX: 1.0,
            sideStackBaseOffsetY: 0.56,
            leftSideStackBaseOffsetZ: 0.56,
            rightSideStackBaseOffsetZ: 0.56,
            inactiveCardOpacity: 0.74,
            focusedCardScale: 1.08,
            cardLiftOnFocus: 0.02,
            cardPullOutX: 0.0,
            cardPullOutZ: 0.2,
            paperColor: .white,
            edgeColors: [
                UIColor(red: 0.894, green: 0.906, blue: 0.867, alpha: 1),
                UIColor(red: 0.871, green: 0.886, blue: 0.839, alpha: 1),
                UIColor(red: 0.909, green: 0.925, blue: 0.886, alpha: 1),
                UIColor(red: 0.922, green: 0.937, blue: 0.906, alpha: 1),
                UIColor(red: 0.878, green: 0.894, blue: 0.851, alpha: 1),
                UIColor(red: 0.937, green: 0.949, blue: 0.918, alpha: 1),
                UIColor(red: 0.953, green: 0.961, blue: 0.933, alpha: 1),
                UIColor(red: 0.886, green: 0.902, blue: 0.859, alpha: 1),
            ],
            usesOrthographicProjection: false,
            cameraOrthographicScale: 5.2,
            cameraFieldOfView: 40,
            cameraPosition: SCNVector3(0.0, 2.0, 10.4),
            cameraLookAt: SCNVector3(0.0, -0.18, 0.0),
            ambientIntensity: 900,
            directionalIntensity: 300,
            directionalEulerAngles: SCNVector3(
                x: -Float.pi / 4,
                y: Float.pi / 6,
                z: 0
            ),
            floorYPosition: -2.0,
            groupingStrategy: .single,
            stackRootPosition: SCNVector3(0.0, -0.26, -0.05),
            stackRootRotationY: 0.0,
            frontCardRotationY: -0.24,
            swipeTranslationThreshold: 50,
            swipeVelocityThreshold: 200
        )
    }
}

private struct HomeStackLayoutProfile {
    let cardSpreadX: Float
    let cardSpreadY: Float
    let cardSpreadZ: Float
    let leftSideStackBaseOffsetX: Float
    let rightSideStackBaseOffsetX: Float
    let sideStackBaseOffsetY: Float
    let leftSideStackBaseOffsetZ: Float
    let rightSideStackBaseOffsetZ: Float
    let focusedCardScale: Float
    let cardPullOutZ: Float
    let frontCardRotationY: Float
    let cameraOrthographicScale: Double
    let cameraPosition: SCNVector3
    let cameraLookAt: SCNVector3
    let stackRootPosition: SCNVector3

    static func make(for itemCount: Int) -> HomeStackLayoutProfile {
        switch itemCount {
        case ..<2:
            return HomeStackLayoutProfile(
                cardSpreadX: 0.0,
                cardSpreadY: 0.0,
                cardSpreadZ: 0.0,
                leftSideStackBaseOffsetX: 0.0,
                rightSideStackBaseOffsetX: 0.0,
                sideStackBaseOffsetY: 0.0,
                leftSideStackBaseOffsetZ: 0.0,
                rightSideStackBaseOffsetZ: 0.0,
                focusedCardScale: 1.34,
                cardPullOutZ: 0.34,
                frontCardRotationY: -0.22,
                cameraOrthographicScale: 4.0,
                cameraPosition: SCNVector3(7.4, 5.9, 9.8),
                cameraLookAt: SCNVector3(-0.02, 0.02, 0.0),
                stackRootPosition: SCNVector3(-0.30, -0.10, 0.0)
            )
        case 2:
            return HomeStackLayoutProfile(
                cardSpreadX: 0.12,
                cardSpreadY: 0.09,
                cardSpreadZ: 0.11,
                leftSideStackBaseOffsetX: 1.48,
                rightSideStackBaseOffsetX: 1.55,
                sideStackBaseOffsetY: 0.38,
                leftSideStackBaseOffsetZ: 0.80,
                rightSideStackBaseOffsetZ: 0.28,
                focusedCardScale: 1.30,
                cardPullOutZ: 0.40,
                frontCardRotationY: -0.24,
                cameraOrthographicScale: 4.12,
                cameraPosition: SCNVector3(7.6, 5.9, 9.9),
                cameraLookAt: SCNVector3(-0.06, 0.02, 0.0),
                stackRootPosition: SCNVector3(-0.40, -0.10, 0.0)
            )
        case 3:
            return HomeStackLayoutProfile(
                cardSpreadX: 0.15,
                cardSpreadY: 0.10,
                cardSpreadZ: 0.13,
                leftSideStackBaseOffsetX: 2.50,
                rightSideStackBaseOffsetX: 1.92,
                sideStackBaseOffsetY: 0.45,
                leftSideStackBaseOffsetZ: 1.50,
                rightSideStackBaseOffsetZ: 0.34,
                focusedCardScale: 1.26,
                cardPullOutZ: 0.42,
                frontCardRotationY: -0.28,
                cameraOrthographicScale: 4.28,
                cameraPosition: SCNVector3(7.8, 6.0, 10.0),
                cameraLookAt: SCNVector3(-0.16, 0.0, 0.0),
                stackRootPosition: SCNVector3(-0.58, -0.10, 0.0)
            )
        default:
            return HomeStackLayoutProfile(
                cardSpreadX: 0.18,
                cardSpreadY: 0.12,
                cardSpreadZ: 0.15,
                leftSideStackBaseOffsetX: 2.10,
                rightSideStackBaseOffsetX: 2.18,
                sideStackBaseOffsetY: 0.5,
                leftSideStackBaseOffsetZ: 1.60,
                rightSideStackBaseOffsetZ: 0.42,
                focusedCardScale: 1.24,
                cardPullOutZ: 0.45,
                frontCardRotationY: -0.3,
                cameraOrthographicScale: 4.45,
                cameraPosition: SCNVector3(8.0, 6.0, 10.0),
                cameraLookAt: SCNVector3(-0.24, 0.0, 0.0),
                stackRootPosition: SCNVector3(-0.80, -0.1, 0.0)
            )
        }
    }
}
