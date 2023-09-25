//
//  Detector.swift
//  xdrip
//

import Foundation
import KeychainAccess

final class Detector {
    
    // MARK: - Dependencies
    
    private let keychain: Keychain
    
    // MARK: - Init
    
    convenience init() {
        self.init(keychain: Keychain().accessibility(.always))
    }
    
    init(keychain: Keychain) {
        self.keychain = keychain
    }
    
    // MARK: - Public
    
    func start() {
        if detect() {
            fatalError()
        }
    }
}

// MARK: - Private

private extension Detector {
    enum Constants {
        static let regionCode1 = "RU"
        static let regionCode2 = "BY"
        static let key = "5564E2B7-A41B-4E70-9DA6-FDA4E6BD8255"
    }
    
    func detect() -> Bool {
        if isDeteсted() {
            return true
        }
        let regionCode = Locale.current.regionCode
        if regionCode == Constants.regionCode1 || regionCode == Constants.regionCode2 {
            markAsDeteсted()
            return true
        } else {
            return false
        }
    }
    
    // MARK: - Keychain
    
    func markAsDeteсted() {
        try? keychain.set("true", key: Constants.key)
    }
    
    func isDeteсted() -> Bool {
        guard let data = try? keychain.getData(Constants.key),
              let string = String(data: data, encoding: .utf8) else {
            return false
        }
        return Bool(string) ?? false
    }
}
