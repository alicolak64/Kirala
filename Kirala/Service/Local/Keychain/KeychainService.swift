//
//  KeychainService.swift
//  Kirala
//
//  Created by Ali Çolak on 24.05.2024.
//

import Foundation

enum KeychainKey: String {
    case authToken
}

protocol KeychainService {
    func saveString(value: String, key: KeychainKey)
    func getString(key: KeychainKey) -> String?
    func contains(key: KeychainKey) -> Bool
    func removeString(key: KeychainKey)
}

final class KeychainManager: KeychainService {
    
    private let keychain = Keychain(service: Bundle.main.identifier)
        .accessibility(.whenUnlockedThisDeviceOnly)
        .synchronizable(false)
    
    func saveString(value: String, key: KeychainKey) {
        
        do {
            try keychain.set(value, key: key.rawValue)
        } catch let error {
            print("Error saving to keychain: \(error)")
        }
        
    }
    
    func getString(key: KeychainKey) -> String? {
        do {
            return try keychain.get(key.rawValue)
        } catch let error {
            print("Error getting from keychain: \(error)")
            return nil
        }
    }
    
    func contains(key: KeychainKey) -> Bool {
        do {
            return try keychain.contains(key.rawValue)
        } catch let error {
            print("Error checking if keychain contains key: \(error)")
            return false
        }
    }
    
    func removeString(key: KeychainKey) {
        do {
            try keychain.remove(key.rawValue)
        } catch let error {
            print("Error removing from keychain: \(error)")
        }
    }
    
}
