// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "PixieCacheKit",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "PixieCacheKit",
            targets: ["PixieCacheKit"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "PixieCacheKit",
            dependencies: []),
    ]
)
