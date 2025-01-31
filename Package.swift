// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "CapacitorPluginIosLocalNetworkPermissionChecker",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "CapacitorPluginIosLocalNetworkPermissionChecker",
            targets: ["LocalNetworkPermissionCheckerPlugin"])
    ],
    dependencies: [
        .package(url: "https://github.com/ionic-team/capacitor-swift-pm.git", from: "7.0.0")
    ],
    targets: [
        .target(
            name: "LocalNetworkPermissionCheckerPlugin",
            dependencies: [
                .product(name: "Capacitor", package: "capacitor-swift-pm"),
                .product(name: "Cordova", package: "capacitor-swift-pm")
            ],
            path: "ios/Sources/LocalNetworkPermissionCheckerPlugin"),
        .testTarget(
            name: "LocalNetworkPermissionCheckerPluginTests",
            dependencies: ["LocalNetworkPermissionCheckerPlugin"],
            path: "ios/Tests/LocalNetworkPermissionCheckerPluginTests")
    ]
)