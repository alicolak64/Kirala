//
//  UserDefaults+Extension.swift
//  UniTurkey
//
//  Created by Ali Çolak on 16.04.2024.
//

import Foundation

/// An extension to provide additional functionality for UserDefaults.
extension UserDefaults {
    
    // MARK: - Subscript
    
    /// Accesses the value associated with the specified key.
    /// - Parameter key: The key whose value to retrieve.
    subscript(key: String) -> Any? {
        get {
            return object(forKey: key)
        }
        set {
            set(newValue, forKey: key)
        }
    }
    
    // MARK: - Methods
    
    /// Retrieves a `Codable` object from UserDefaults.
    /// - Parameters:
    ///   - type: The type of the object to retrieve.
    ///   - key: The key with which the object is associated.
    ///   - decoder: The JSONDecoder to use for decoding the object. Defaults to `JSONDecoder()`.
    /// - Returns: The object of the specified type, or `nil` if the object does not exist or decoding fails.
    func object<T: Codable>(_ type: T.Type, with key: String, usingDecoder decoder: JSONDecoder = JSONDecoder()) -> T? {
        guard let data = value(forKey: key) as? Data else { return nil }
        do {
            return try decoder.decode(type.self, from: data)
        } catch {
            print("Failed to decode object for key \(key): \(error)")
            return nil
        }
    }
    
    /// Saves a `Codable` object to UserDefaults.
    /// - Parameters:
    ///   - object: The object to save.
    ///   - key: The key with which to associate the object.
    ///   - encoder: The JSONEncoder to use for encoding the object. Defaults to `JSONEncoder()`.
    func set<T: Codable>(object: T, forKey key: String, usingEncoder encoder: JSONEncoder = JSONEncoder()) {
        do {
            let data = try encoder.encode(object)
            set(data, forKey: key)
        } catch {
            print("Failed to encode object for key \(key): \(error)")
        }
    }
}
