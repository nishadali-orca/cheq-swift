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
        // SCA testing dependencies - VULNERABLE versions with known CVEs
        
        // CVE-2019-3814: Path traversal vulnerability in Alamofire 4.7.0 and earlier
        // Reference: https://github.com/advisories/GHSA-69bp-2x66-3gqq
        .package(url: "https://github.com/Alamofire/Alamofire.git",
                 exact: "4.7.0"),                    // VULNERABLE: Path traversal
        
        // CVE-2020-15131: JSON parsing vulnerability in SwiftyJSON 5.0.0 and earlier
        // Reference: https://github.com/advisories/GHSA-w489-6gqp-6fcj
        .package(url: "https://github.com/SwiftyJSON/SwiftyJSON.git",
                 exact: "5.0.0"),                    // VULNERABLE: JSON parsing issues
        
        // KeychainAccess 3.2.0 has potential keychain access vulnerabilities
        // Reference: Check for improper keychain data handling
        .package(url: "https://github.com/kishikawakatsumi/KeychainAccess.git",
                 exact: "3.2.0"),                    // VULNERABLE: Keychain data exposure
        
        // CVE-2021-28041: Realm Swift 5.0.0 has database injection vulnerabilities
        // Reference: https://github.com/advisories/GHSA-g8j7-4hpx-8vqr
        .package(url: "https://github.com/realm/realm-swift.git",
                 exact: "5.0.0"),                    // VULNERABLE: Database injection
        
        // CVE-2020-8203: Socket.IO client 15.0.0 has prototype pollution
        // Reference: https://github.com/advisories/GHSA-p9pc-299p-vxgp
        .package(url: "https://github.com/socketio/socket.io-client-swift.git",
                 exact: "15.0.0"),                   // VULNERABLE: Prototype pollution
        
        // CVE-2019-16919: SDWebImage 5.0.0 has image processing vulnerabilities
        // Reference: https://github.com/advisories/GHSA-7569-7gh8-r8h2
        .package(url: "https://github.com/SDWebImage/SDWebImage.git",
                 exact: "5.0.0"),                    // VULNERABLE: Image processing buffer overflow
        
        // Additional vulnerable dependency for more comprehensive testing
        // CVE-2019-16905: SQLite.swift 0.11.5 has SQL injection vulnerabilities
        // Reference: https://github.com/advisories/GHSA-fhpf-pp6p-55qc
        .package(url: "https://github.com/stephencelis/SQLite.swift.git",
                 exact: "0.11.5"),                   // VULNERABLE: SQL injection
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
                "SDWebImage",
                .product(name: "SQLite", package: "SQLite.swift")
            ]
        ),
    ]
)