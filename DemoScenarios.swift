import UIKit
import WebKit
import SQLite3
import Foundation
import Security
import CommonCrypto
import CryptoKit
import Network

// Third-party imports for CSA testing
import Alamofire          // HTTP networking library
import SwiftyJSON         // JSON parsing
import KeychainAccess     // Keychain wrapper
import RealmSwift         // Database ORM
import SocketIO           // WebSocket library
import SDWebImage         // Image loading/caching


class DemoScenarios {
    private let dbPointer: OpaquePointer? = {
        var db: OpaquePointer? = nil
        let fileURL = try! FileManager.default
            .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("demo.db")
        sqlite3_open(fileURL.path, &db)
        return db
    }()

    // -----
    // + A1
    func opA1(_ input: String) {
        let q = "SELECT * FROM users WHERE id = '\(input)'"
        var s: OpaquePointer?
        sqlite3_prepare_v2(dbPointer, q, -1, &s, nil)
        sqlite3_step(s)
        sqlite3_finalize(s)
    }
    // -----
    // - B2
    func opB2(_ input: String) {
        let q = "SELECT * FROM users WHERE id = ?"
        var s: OpaquePointer?
        sqlite3_prepare_v2(dbPointer, q, -1, &s, nil)
        sqlite3_bind_text(s, 1, input, -1, nil)
        sqlite3_step(s)
        sqlite3_finalize(s)
    }
    // -----
    // + C3
    func opC3(_ web: WKWebView, _ v: String) {
        let h = "<html><body>\(v)</body></html>"
        web.loadHTMLString(h, baseURL: nil)
    }
    // -----
    // - D4
    func opD4(_ web: WKWebView, _ v: String) {
        let e = v
            .replacingOccurrences(of: "&", with: "&amp;")
            .replacingOccurrences(of: "<", with: "&lt;")
            .replacingOccurrences(of: ">", with: "&gt;")
        let h = "<html><body>\(e)</body></html>"
        web.loadHTMLString(h, baseURL: nil)
    }
    // -----
    // + E5
    func opE5(_ arg: String) {
        let c = "ls \(arg)"
        let t = Process()
        t.launchPath = "/bin/sh"
        t.arguments = ["-c", c]
        t.launch()
    }
    // -----
    // - F6
    func opF6(_ arg: String) {
        let t = Process()
        t.launchPath = "/bin/ls"
        t.arguments = [arg]
        t.launch()
    }
    // -----
    // + G7
    func opG7() {
        do {
            throw NSError(domain: "", code: 0, userInfo: nil)
        } catch {
        }
    }
    // -----
    // - H8
    func opH8() {
        do {
            throw NSError(domain: "", code: 0, userInfo: nil)
        } catch let e {
            print(e)
        }
    }
    // -----
    // + I9
    func opI9() {
        var x = 0
        for _ in 0..<5 {
            x += 1
        }
    }
    // -----
    // - J10
    private let lv = 5
    func opJ10() {
        var x = 0
        for _ in 0..<lv {
            x += 1
        }
    }
    // -----
    // + K11
    func opK11(_ a: Bool, _ b: Bool, _ c: Bool) {
        if a {
            if b {
                if c {
                }
            }
        }
    }
    // -----
    // - L12
    func opL12(_ a: Bool, _ b: Bool, _ c: Bool) {
        guard a, b, c else { return }
    }
    // -----    
    // + M13 
    func opM13() {
        let unused = 0
    }
    // -----
    // - N14
    func opN14(_ v: Int) {
        let used = v
        _ = used
    }

    // ---------------------------------------------------
    // CSA Test 1: Weak Cryptography (Medium)
    // ⚠️
    // ---------------------------------------------------
    func weakCrypto(_ password: String) -> String {
        let data = password.data(using: .utf8)!
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        data.withUnsafeBytes {
            _ = CC_MD5($0.baseAddress, CC_LONG(data.count), &digest)
        }
        return digest.map { String(format: "%02hhx", $0) }.joined()
    }
    


}
