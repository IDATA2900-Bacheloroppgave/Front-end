//
//  KeychainManager.swift
//  Front End
//
//  Created by Siri Sandnes on 18/04/2024.
//

import Foundation
import Security

class KeychainManager {
    static let shared = KeychainManager()

    enum KeychainError: Error, LocalizedError {
        case itemNotFound
        case failedToDelete
        case failedToSave(status: OSStatus)
        case failedToLoad(status: OSStatus)
        
        var errorDescription: String? {
            switch self {
            case .itemNotFound:
                return "The requested item could not be found in the keychain."
            case .failedToDelete:
                return "Failed to delete the existing item from the keychain."
            case .failedToSave(let status):
                return "Failed to save the item to the keychain with status code: \(status)."
            case .failedToLoad(let status):
                return "Failed to load the item from the keychain with status code: \(status)."
            }
        }
    }

    func saveToken(_ token: String, for email: String) throws {
        let tokenData = Data(token.utf8)
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: email,
            kSecValueData as String: tokenData
        ]

  
        let deleteStatus = SecItemDelete(query as CFDictionary)
        if deleteStatus != errSecSuccess && deleteStatus != errSecItemNotFound {
            throw KeychainError.failedToDelete
        }

    
        let addStatus = SecItemAdd(query as CFDictionary, nil)
        if addStatus != errSecSuccess {
            throw KeychainError.failedToSave(status: addStatus)
        }
    }

    func loadToken(for email: String) throws -> String {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: email,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var item: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        if status == errSecSuccess, let data = item as? Data, let token = String(data: data, encoding: .utf8) {
            return token
        } else if status == errSecItemNotFound {
            throw KeychainError.itemNotFound
        } else {
            throw KeychainError.failedToLoad(status: status)
        }
    }

    func deleteToken(for email: String) throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: email
        ]

        let status = SecItemDelete(query as CFDictionary)
        if status != errSecSuccess && status != errSecItemNotFound {
            throw KeychainError.failedToDelete
        }
    }
}

