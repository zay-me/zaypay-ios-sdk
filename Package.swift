// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ZayPay",
    products: [
        .library(
            name: "ZayPay",
            targets: ["ZayPay"]
        )
    ],
    targets: [
        .binaryTarget(
            name: "ZayPay",
            url: "https://github.com/zay-me/zaypay-ios-sdk/releases/download/1.0.0/ZayPay.xcframework.zip",
            checksum: "5ca9a91db23fff12c89b8a1760c6bbf23700fb7e8745cbfc36858e24c56e8080"
        )
    ]
)
