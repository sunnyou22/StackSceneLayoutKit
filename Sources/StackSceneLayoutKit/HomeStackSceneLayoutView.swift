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
        if itemCount < 2 {
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
        }

        let clampedCount = min(max(itemCount, 2), 4)
        let step = Float(clampedCount - 2)
        let baseOffsetX = 1.44 + (0.18 * step)
        let baseOffsetZ = 0.52 + (0.10 * step)
        let spreadX = 0.11 + (0.02 * step)
        let spreadY = 0.08 + (0.01 * step)
        let spreadZ = 0.10 + (0.015 * step)
        let sideBaseOffsetY = 0.34 + (0.05 * step)
        let focusedCardScale = 1.30 - (0.03 * step)
        let cardPullOutZ = 0.40 + (0.02 * step)
        let frontCardRotationY = -0.24 - (0.02 * step)
        let cameraOrthographicScale = 4.10 + Double(step) * 0.14
        let cameraPosition = SCNVector3(
            7.6 + (0.15 * step),
            5.9 + (0.05 * step),
            9.9 + (0.05 * step)
        )
        let cameraLookAt = SCNVector3(
            -0.04 - (0.02 * step),
            0.01,
            0.0
        )
        let stackRootPosition = SCNVector3(
            -0.34 - (0.06 * step),
            -0.10,
            0.0
        )

        return HomeStackLayoutProfile(
            cardSpreadX: spreadX,
            cardSpreadY: spreadY,
            cardSpreadZ: spreadZ,
            leftSideStackBaseOffsetX: baseOffsetX,
            rightSideStackBaseOffsetX: baseOffsetX,
            sideStackBaseOffsetY: sideBaseOffsetY,
            leftSideStackBaseOffsetZ: baseOffsetZ,
            rightSideStackBaseOffsetZ: baseOffsetZ,
            focusedCardScale: focusedCardScale,
            cardPullOutZ: cardPullOutZ,
            frontCardRotationY: frontCardRotationY,
            cameraOrthographicScale: cameraOrthographicScale,
            cameraPosition: cameraPosition,
            cameraLookAt: cameraLookAt,
            stackRootPosition: stackRootPosition
        )
    }
}
