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
            url: "https://github.com/zay-me/zaypay-ios-sdk/releases/download/1.0.1/ZayPay.xcframework.zip",
            checksum: "cec57d10792989d7b4d8544ea07bf14dc0d069495085e8eead4f9101e5cdbec1"
        )
    ]
)
