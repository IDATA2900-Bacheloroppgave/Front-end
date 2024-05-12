import Foundation
import Security

class KeychainManager {
    static let shared = KeychainManager()

    func saveToken(_ token: String, for email: String) throws {
        let tokenData = Data(token.utf8)
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: email,
            kSecValueData as String: tokenData
        ]

        // Attempt to delete any existing item first
        let deleteStatus = SecItemDelete(query as CFDictionary)
        if deleteStatus == errSecSuccess {
            print("Previous token deleted successfully.")
        } else {
            print("No existing token to delete or failed to delete: \(deleteStatus).")
        }

        // Attempt to add the new item
        let addStatus = SecItemAdd(query as CFDictionary, nil)
        if addStatus == errSecSuccess {
            print("Token saved successfully.")
        } else {
            if let errorMessage = SecCopyErrorMessageString(addStatus, nil) {
                print("Failed to save token: \(errorMessage)")
            }
            throw NSError(domain: NSOSStatusErrorDomain, code: Int(addStatus), userInfo: nil)
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
            print("Token loaded successfully.")
            return token
        } else {
            print("Failed to load token, error code: \(status).")
            if let errorMessage = SecCopyErrorMessageString(status, nil) {
                print("Error message: \(errorMessage)")
            }
            throw NSError(domain: NSOSStatusErrorDomain, code: Int(status), userInfo: nil)
        }
    }

    func deleteToken(for email: String) throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: email
        ]

        let status = SecItemDelete(query as CFDictionary)
        if status == errSecSuccess {
            print("Token deleted successfully.")
        } else {
            print("Failed to delete token, error code: \(status).")
            throw NSError(domain: NSOSStatusErrorDomain, code: Int(status), userInfo: nil)
        }
    }
}

