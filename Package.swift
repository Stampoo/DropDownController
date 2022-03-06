// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DropDownController",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(name: "DropDownController", targets: ["DropDownController"])
    ],
    dependencies: [
    ],
    targets: [
        .target(name: "DropDownController", dependencies: []),
        .testTarget(name: "DropDownControllerTests", dependencies: ["DropDownController"]),
    ]
)

