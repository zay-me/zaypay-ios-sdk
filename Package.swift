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
            checksum: "917319aad8002c365eb25335c35843d4871ae5afca5e4b0c95f6422321a10bd2"
        )
    ]
)
