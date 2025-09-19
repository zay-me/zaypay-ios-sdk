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
            checksum: "14cd9387447b236093dc7b3cc02beedc6e90aa26c2e396dc5e4321a6f3fa6a78"
        )
    ]
)
