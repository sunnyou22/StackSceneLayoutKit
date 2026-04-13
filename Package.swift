// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "StackSceneLayoutKit",
    platforms: [
        .iOS(.v17),
    ],
    products: [
        .library(
            name: "StackSceneLayoutKit",
            targets: ["StackSceneLayoutKit"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/sunnyou22/Stack3DKit.git", branch: "main"),
    ],
    targets: [
        .target(
            name: "StackSceneLayoutKit",
            dependencies: ["Stack3DKit"]
        ),
        .testTarget(
            name: "StackSceneLayoutKitTests",
            dependencies: ["StackSceneLayoutKit"]
        ),
    ]
)
