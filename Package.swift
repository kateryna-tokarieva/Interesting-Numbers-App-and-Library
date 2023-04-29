// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "InterestingNumbersLibrary",
    products: [
        
        .library(
            name: "InterestingNumbersLibrary",
            targets: ["InterestingNumbersLibrary"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "InterestingNumbersLibrary"
        ),
        .testTarget(
            name: "InterestingNumbersLibraryTests",
            dependencies: ["InterestingNumbersLibrary"],
            resources: [
                .copy("Resources/TestResources/validData.json"),
                .copy("Resources/TestResources/notValidData.json")
            ]
        )
    ]
)
