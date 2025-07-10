// swift-tools-version: 5.7
import PackageDescription

let package = Package(
    name: "SASTCSATestSuite",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "SASTCSATestSuite",
            targets: ["SASTCSATestSuite"]
        ),
    ], 
    dependencies: [ 
        // CSA testing dependencies - strategically older/vulnerable versions
        .package(url: "https://github.com/Alamofire/Alamofire.git",
                 exact: "4.9.1"),                    // Older version with known issues
        .package(url: "https://github.com/SwiftyJSON/SwiftyJSON.git",
                 exact: "4.3.0"),                    // Potential parsing vulnerabilities
        .package(url: "https://github.com/kishikawakatsumi/KeychainAccess.git",
                 exact: "3.2.1"),                    // Keychain access patterns
        .package(url: "https://github.com/realm/realm-swift.git",
                 exact: "5.4.8"),                    // Database ORM with potential issues
        .package(url: "https://github.com/socketio/socket.io-client-swift.git",
                 exact: "15.2.0"),                   // WebSocket implementation
        .package(url: "https://github.com/SDWebImage/SDWebImage.git",
                 exact: "5.8.4"),                    // Image processing library
    ],
    targets: [
        .target(
            name: "SASTCSATestSuite",
            dependencies: [
                "Alamofire",
                "SwiftyJSON",
                "KeychainAccess",
                .product(name: "Realm", package: "realm-swift"),
                .product(name: "SocketIO", package: "socket.io-client-swift"),
                "SDWebImage"
            ]
        ),
    ]
)