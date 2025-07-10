// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "VulnerableApp",
    platforms: [
        .iOS(.v13)
    ],
    dependencies: [
        // Known vulnerable version of Alamofire (e.g., 5.4.3 had CVE-2022-31093)
        .package(url: "https://github.com/Alamofire/Alamofire.git", .exact("5.4.3")),
        
        // SwiftyJSON version with known memory handling issues (hypothetical CVE)
        .package(url: "https://github.com/SwiftyJSON/SwiftyJSON.git", from: "4.0.0"),

        // CryptoSwift with older CVEs (e.g., CVE-2020-26217 in versions <1.3.8)
        .package(url: "https://github.com/krzyzanowskim/CryptoSwift.git", .exact("1.3.0"))
    ],
    targets: [
        .target(
            name: "VulnerableApp",
            dependencies: [
                "Alamofire",
                "SwiftyJSON",
                "CryptoSwift"
            ]
        ),
        .testTarget(
            name: "VulnerableAppTests",
            dependencies: ["VulnerableApp"]
        )
    ]
)
