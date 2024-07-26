// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Reach5WeChat",
    products: [
        .library(name: "Reach5WeChat", targets: ["Reach5WeChat"]),
    ],
    dependencies: [
        .package(url: "https://github.com/ReachFive/reachfive-ios.git", branch: "7.0.0"),
        .package(url: "https://github.com/yanyin1986/WechatOpenSDK.git", .upToNextMajor(from: "2.0.0")),
    ],
    targets: [
        .target(
            name: "Reach5WeChat",
            dependencies: [
                .product(name: "Reach5", package: "reachfive-ios"),
                .product(name: "WechatOpenSDK", package: "WechatOpenSDK"),
            ],
            path: "IdentitySdkWeChat",
            resources: [
              .copy("PrivacyInfo.xcprivacy")
            ]
        ),
    ]
)
