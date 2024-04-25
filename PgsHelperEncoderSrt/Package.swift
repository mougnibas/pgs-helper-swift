// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PgsHelperEncoderSrt",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "PgsHelperEncoderSrt",
            targets: ["PgsHelperEncoderSrt"]),
    ],
    dependencies: [
        .package(path: "../PgsHelperCommon"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "PgsHelperEncoderSrt",
            dependencies: [
                "PgsHelperCommon",
            ]
        ),
        .testTarget(
            name: "PgsHelperEncoderSrtTests",
            dependencies: ["PgsHelperEncoderSrt"]),
    ]
)
