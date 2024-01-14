// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ETNetwork",
    platforms: [.iOS(.v12)],
    products: [
        .library(
            name: "ETNetwork",
            targets: ["ETNetwork"]),
    ],
    targets: [
        .target(
            name: "ETNetwork"),
        .testTarget(
            name: "ETNetworkTests",
            dependencies: ["ETNetwork"]),
    ]
)
